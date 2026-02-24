import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Hyprland

WrapperRectangle {
    id: musicPlayer

    property var player: Mpris.players.values.find(p => p.isPlaying) || Mpris.players.values[0]

    color: "#303446"
    margin: 4
    radius: 4
    implicitHeight: 30
    width: Math.min(contentText.implicitWidth + 20, 800)
    border.color: "#8caaee"
    border.width: 1

    component MediaButton: Button {
        id: control
        Layout.fillWidth: true
        contentItem: Text {
            text: control.text
            font {
                family: "MonaspiceRn NFP"
                pointSize: 12
            }
            color: "#c6d0f5"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            implicitHeight: 30
            color: "#414559"
            radius: 100
        }
    }

    Text {
        id: contentText
        anchors.fill: parent
        anchors.margins: 10
        text: player ? `${player.trackArtist} - ${player.trackTitle}` : "No Media"
        color: "#c6d0f5"
        font {
            family: "MonaspiceRn NFP"
            pointSize: 14
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                musicPane.visible = true;
                grab.active = true;
            }
        }
    }

    PopupWindow {
        id: musicPane
        anchor.window: bar
        anchor.rect.x: bar.width / 2 - width / 2
        anchor.rect.y: 34
        implicitWidth: 500
        implicitHeight: contentRect.height
        color: "transparent"

        HyprlandFocusGrab {
            id: grab
            windows: [musicPane]
            onCleared: musicPane.visible = false
        }

        WrapperRectangle {
            id: contentRect
            color: "#303446"
            margin: 4
            radius: 4
            implicitWidth: 500

            border.color: "#8caaee"
            border.width: 1

            child: ColumnLayout {
                width: parent.width - 20
                anchors.centerIn: parent
                spacing: 8

                Row {
                    Layout.fillWidth: true
                    spacing: 8
                    ClippingWrapperRectangle {
                        radius: 20
                        margin: 4
                        color: "#303446"
                        IconImage {
                            visible: musicPlayer.player?.trackArtUrl
                            source: musicPlayer.player?.trackArtUrl
                            asynchronous: true
                            implicitSize: 100
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }

                    Column {
                        Text {
                            text: musicPlayer.player?.trackTitle ?? "Unknown Title"
                            color: "#c6d0f5"
                            width: musicPane.width - 116
                            font {
                                family: "MonaspiceRn NFP"
                                pointSize: 14
                                bold: true
                            }
                            wrapMode: Text.WordWrap
                        }

                        Text {
                            text: musicPlayer.player?.trackArtist ?? "Unknown Artist"
                            color: "#b5bfe2"
                            width: musicPane.width - 116
                            font {
                                family: "MonaspiceRn NFP"
                                pointSize: 10
                            }
                        }
                    }
                }

                FlexboxLayout {
                    Layout.fillWidth: true
                    direction: FlexboxLayout.Row
                    justifyContent: FlexboxLayout.JustifySpaceAround
                    gap: 10
                    MediaButton {
                        text: ""
                        visible: musicPlayer.player?.canGoPrevious ?? false
                        onClicked: musicPlayer.player.previous()
                    }
                    MediaButton {
                        text: ""
                        visible: musicPlayer.player?.canSeek ?? false
                        onClicked: musicPlayer.player.seek(-0.02)
                    }
                    MediaButton {
                        text: musicPlayer.player?.playbackState === MprisPlaybackState.Playing ? "" : ""
                        visible: musicPlayer.player?.canTogglePlaying ?? false
                        onClicked: musicPlayer.player.togglePlaying()
                    }
                    MediaButton {
                        text: ""
                        visible: musicPlayer.player?.canSeek ?? false
                        onClicked: musicPlayer.player.seek(0.02)
                    }
                    MediaButton {
                        text: ""
                        visible: musicPlayer.player?.canGoNext ?? false
                        onClicked: musicPlayer.player.next()
                    }
                    MediaButton {
                        text: ""
                        visible: musicPlayer.player?.shuffleSupported ?? false
                        onClicked: musicPlayer.player.shuffle = !musicPlayer.player.shuffle
                        opacity: musicPlayer.player?.shuffle ? 1.0 : 0.5
                    }
                }

                Slider {
                    id: progressSlider
                    Layout.fillWidth: true
                    visible: (musicPlayer.player?.positionSupported && musicPlayer.player?.lengthSupported) ?? false
                    from: 0
                    to: musicPlayer.player?.length ?? 0
                    live: false
                    value: musicPlayer.player?.position ?? 0

                    background: Rectangle {
                        x: progressSlider.leftPadding
                        y: progressSlider.topPadding + (progressSlider.availableHeight - height) / 2
                        implicitHeight: 4
                        width: progressSlider.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#414559"

                        Rectangle {
                            width: progressSlider.visualPosition * parent.width
                            height: parent.height
                            color: "#4761a0"
                            radius: 2
                        }
                    }
                    handle: Rectangle {
                        x: progressSlider.leftPadding + progressSlider.visualPosition * (progressSlider.availableWidth - width)
                        y: progressSlider.topPadding + (progressSlider.availableHeight - height) / 2
                        implicitWidth: 12
                        implicitHeight: 12
                        radius: 3
                        color: "#8caaee"
                        visible: musicPlayer.player?.canControl
                    }
                    onMoved: if (musicPlayer.player?.canControl)
                        musicPlayer.player.position = value
                }

                Slider {
                    id: volumeSlider
                    Layout.fillWidth: true
                    visible: (musicPlayer.player?.volumeSupported && musicPlayer.player?.canControl) ?? false
                    value: musicPlayer.player?.volume ?? 0
                    live: false

                    background: Rectangle {
                        x: volumeSlider.leftPadding
                        y: volumeSlider.topPadding + (volumeSlider.availableHeight - height) / 2
                        implicitHeight: 4
                        width: volumeSlider.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#414559"

                        Rectangle {
                            width: volumeSlider.visualPosition * parent.width
                            height: parent.height
                            color: "#8caaee"
                            radius: 2
                        }
                    }
                    onMoved: musicPlayer.player.volume = value
                }
            }
        }

        FrameAnimation {
            running: player.playbackState == MprisPlaybackState.Playing
            onTriggered: player.positionChanged()
        }

        Connections {
            target: player
            function onPostTrackChanged() {
                player.seek(0);
            }
        }
    }
}

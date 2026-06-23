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

  color: Theme.bgBase
  implicitHeight: 30
  margin: Theme.defaultMargin
  radius: Theme.cornerRadius
  width: Math.min(contentText.implicitWidth + 20, 800)

  Text {
    id: contentText

    anchors.fill: parent
    anchors.margins: 10
    color: Theme.textMain
    elide: Text.ElideRight
    font: Theme.defaultFont
    horizontalAlignment: Text.AlignHCenter
    text: player ? `${player.trackArtist} - ${player.trackTitle}` : "No Media"
    verticalAlignment: Text.AlignVCenter

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

    anchor.rect.x: bar.width / 2 - width / 2
    anchor.rect.y: 34
    anchor.window: bar
    color: "transparent"
    implicitHeight: contentRect.height
    implicitWidth: 500

    HyprlandFocusGrab {
      id: grab

      windows: [musicPane]

      onCleared: musicPane.visible = false
    }
    WrapperRectangle {
      id: contentRect

      color: Theme.bgBase
      implicitWidth: 500
      margin: Theme.defaultMargin
      radius: Theme.cornerRadius

      child: ColumnLayout {
        anchors.centerIn: parent
        spacing: 8
        width: parent.width - 20

        Row {
          Layout.fillWidth: true
          spacing: Theme.defaultSpacing

          ClippingWrapperRectangle {
            color: Theme.bgBase
            margin: Theme.cornerRadius
            radius: 20

            IconImage {
              Layout.alignment: Qt.AlignHCenter
              asynchronous: true
              implicitSize: 100
              source: musicPlayer.player?.trackArtUrl
              visible: musicPlayer.player?.trackArtUrl
            }
          }
          Column {
            Text {
              color: Theme.textMain
              text: musicPlayer.player?.trackTitle ?? "Unknown Title"
              width: musicPane.width - 116
              wrapMode: Text.WordWrap

              font {
                bold: true
                family: "Iosevka Nerd Font Propo"
                pointSize: 14
              }
            }
            Text {
              color: "#b5bfe2"
              text: musicPlayer.player?.trackArtist ?? "Unknown Artist"
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
          gap: 10
          justifyContent: FlexboxLayout.JustifySpaceAround

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
            opacity: musicPlayer.player?.shuffle ? 1.0 : 0.5
            text: ""
            visible: musicPlayer.player?.shuffleSupported ?? false

            onClicked: musicPlayer.player.shuffle = !musicPlayer.player.shuffle
          }
        }
        Slider {
          id: progressSlider

          Layout.fillWidth: true
          from: 0
          live: false
          to: musicPlayer.player?.length ?? 0
          value: musicPlayer.player?.position ?? 0
          visible: (musicPlayer.player?.positionSupported && musicPlayer.player?.lengthSupported) ?? false

          background: Rectangle {
            color: "#414559"
            height: implicitHeight
            implicitHeight: 4
            radius: 2
            width: progressSlider.availableWidth
            x: progressSlider.leftPadding
            y: progressSlider.topPadding + (progressSlider.availableHeight - height) / 2

            Rectangle {
              color: "#4761a0"
              height: parent.height
              radius: 2
              width: progressSlider.visualPosition * parent.width
            }
          }
          handle: Rectangle {
            color: Theme.accent
            implicitHeight: 12
            implicitWidth: 12
            radius: 3
            visible: musicPlayer.player?.canControl
            x: progressSlider.leftPadding + progressSlider.visualPosition * (progressSlider.availableWidth - width)
            y: progressSlider.topPadding + (progressSlider.availableHeight - height) / 2
          }

          onMoved: if (musicPlayer.player?.canControl)
            musicPlayer.player.position = value
        }
        Slider {
          id: volumeSlider

          Layout.fillWidth: true
          live: false
          value: musicPlayer.player?.volume ?? 0
          visible: (musicPlayer.player?.volumeSupported && musicPlayer.player?.canControl) ?? false

          background: Rectangle {
            color: "#414559"
            height: implicitHeight
            implicitHeight: 4
            radius: 2
            width: volumeSlider.availableWidth
            x: volumeSlider.leftPadding
            y: volumeSlider.topPadding + (volumeSlider.availableHeight - height) / 2

            Rectangle {
              color: Theme.accent
              height: parent.height
              radius: 2
              width: volumeSlider.visualPosition * parent.width
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
      function onPostTrackChanged() {
        player.seek(0);
      }

      target: player
    }
  }

  component MediaButton: Button {
    id: control

    Layout.fillWidth: true

    background: Rectangle {
      color: "#414559"
      implicitHeight: 30
      radius: 100
    }
    contentItem: Text {
      color: Theme.textMain
      horizontalAlignment: Text.AlignHCenter
      text: control.text
      verticalAlignment: Text.AlignVCenter

      font {
        family: "Iosevka Nerd Font Propo"
        pointSize: 12
      }
    }
  }
}

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Hyprland

Column {
  required property MprisPlayer player

  height: 200
  spacing: 8
  width: 500

  Row {
    spacing: Theme.defaultSpacing

    ClippingWrapperRectangle {
      color: Theme.bgBase
      margin: Theme.cornerRadius
      radius: 20

      IconImage {
        Layout.alignment: Qt.AlignHCenter
        asynchronous: true
        implicitSize: 100
        source: player?.trackArtUrl ?? ""
        visible: player?.trackArtUrl ?? true
      }
    }
    Column {
      Text {
        color: Theme.textMain
        text: player?.trackTitle ?? "Unknown Title"
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
        text: player?.trackArtist ?? "Unknown Artist"
        width: musicPane.width - 116

        font {
          family: "MonaspiceRn NFP"
          pointSize: 10
        }
      }
    }
  }
  FlexboxLayout {
    direction: FlexboxLayout.Row
    gap: 10
    justifyContent: FlexboxLayout.JustifySpaceAround
    width: parent.width

    MediaButton {
      text: ""
      visible: player?.canGoPrevious ?? false

      onClicked: player.previous()
    }
    MediaButton {
      text: ""
      visible: player?.canSeek ?? false

      onClicked: player.seek(-0.02)
    }
    MediaButton {
      text: player?.playbackState === MprisPlaybackState.Playing ? "" : ""
      visible: player?.canTogglePlaying || false

      onClicked: player.togglePlaying()
    }
    MediaButton {
      text: ""
      visible: player?.canSeek ?? false

      onClicked: player.seek(0.02)
    }
    MediaButton {
      text: ""
      visible: player?.canGoNext ?? false

      onClicked: player.next()
    }
    MediaButton {
      opacity: player?.shuffle ? 1.0 : 0.5
      text: ""
      visible: player?.shuffleSupported ?? false

      onClicked: player.shuffle = !player.shuffle
    }
  }
  Slider {
    id: progressSlider

    from: 0
    live: false
    to: player?.length ?? 0
    value: player?.position ?? 0
    visible: (player?.positionSupported && player?.lengthSupported) ?? false
    width: parent.width

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
      visible: player?.canControl || true
      x: progressSlider.leftPadding + progressSlider.visualPosition * (progressSlider.availableWidth - width)
      y: progressSlider.topPadding + (progressSlider.availableHeight - height) / 2
    }

    onMoved: if (player?.canControl)
      player.position = value
  }
  FrameAnimation {
    running: player?.playbackState == MprisPlaybackState.Playing

    onTriggered: player.positionChanged()
  }
  Connections {
    function onPostTrackChanged() {
      player.seek(0);
    }

    target: player
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

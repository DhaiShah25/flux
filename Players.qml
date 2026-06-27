import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Hyprland

WrapperRectangle {
  id: musicPlayer

  property int idx: 0
  property var player: Mpris.players.values[idx]

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
      implicitHeight: 220
      implicitWidth: 500
      margin: Theme.defaultMargin
      radius: Theme.cornerRadius

      Column {
        SwipeView {
          id: view

          anchors.fill: parent
          clip: true
          currentIndex: idx

          Repeater {
            model: Mpris.players

            delegate: Player {
              required property var modelData

              player: modelData
            }
          }
        }
        PageIndicator {
          id: indicator

          anchors.bottom: view.bottom
          anchors.horizontalCenter: parent.horizontalCenter
          count: view.count
          currentIndex: view.currentIndex
        }
      }
    }
  }
}

import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Repeater {
  model: SystemTray.items

  delegate: WrapperRectangle {
    id: trayItem

    required property var modelData

    color: Theme.bgBase
    height: 30
    margin: Theme.defaultMargin
    radius: Theme.cornerRadius
    width: 30

    IconImage {
      source: trayItem.modelData.icon

      MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent

        onClicked: mouse => {
          if (mouse.button === Qt.RightButton) {
            trayMenu.open();
          } else {
            trayItem.modelData.activate();
          }
        }
      }
      QsMenuAnchor {
        id: trayMenu

        anchor.item: trayItem
        anchor.rect.y: 30
        menu: trayItem.modelData.menu
      }
    }
  }
}

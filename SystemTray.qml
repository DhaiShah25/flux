import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Repeater {
    model: SystemTray.items

    delegate: WrapperRectangle {
        id: trayItem
        required property var modelData

        width: 30
        height: 30
        radius: 4
        margin: 4
        color: "#303446"
        border.color: "#8caaee"
        border.width: 1

        IconImage {
            source: trayItem.modelData.icon

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
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

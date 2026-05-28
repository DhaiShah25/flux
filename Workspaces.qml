import QtQuick
import Quickshell.Widgets
import Quickshell.Hyprland

WrapperRectangle {
    color: Theme.bgBase
    margin: Theme.defaultMargin
    radius: Theme.cornerRadius
    implicitHeight: 30

    Row {
        spacing: 10
        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                required property var modelData

                width: 20
                height: 20
                radius: 3
                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: modelData.name
                    font.family: "Iosevka Nerd Font Propo"
                    font.pointSize: 14.0
                    color: modelData.active ? Theme.accent : Theme.textMain
                }
            }
        }
    }
}

import QtQuick
import Quickshell.Widgets
import Quickshell.Hyprland

WrapperRectangle {
    color: "#303446"
    margin: 4
    radius: 4
    implicitHeight: 30
    border.color: "#8caaee"
    border.width: 1

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
                    text: {
                        switch (modelData.id) {
                        case 1:
                            return "󰖟";
                        case 2:
                            return "";
                        case 3:
                            return "󱞁";
                        default:
                            return modelData.name;
                        }
                    }
                    font.family: "MonaspiceRn NFP"
                    font.pointSize: 14.0
                    color: modelData.active ? "#8caaee" : "#c6d0f5"
                }
            }
        }
    }
}

import Quickshell.Widgets
import Quickshell
import QtQuick
import Quickshell.Hyprland

WrapperRectangle {
    id: notifIcon
    color: "#303446"
    margin: 4
    implicitHeight: 30
    radius: 4
    border.color: "#8caaee"
    border.width: 1

    Text {
        text: " "
        font.family: "MonaspiceRn NFP"
        font.pointSize: 14.0
        color: "#c6d0f5"
        Text {
            text: NotifData.tracked.values.length
            font.family: "MonaspiceRn NFP"
            font.pointSize: 8.0
            font.bold: true
            color: "#c6d0f5"
            anchors.bottom: parent.bottom
            anchors.right: parent.right
        }
        MouseArea {
            anchors.fill: parent
            onClicked: panel.visible = !panel.visible
        }
    }

    GlobalShortcut {
        name: "panelToggle"
        description: "Toggles The Notification Panel"
        onReleased: panel.visible = !panel.visible
    }

    PanelWindow {
        id: panel
        implicitWidth: 400
        visible: false

        anchors {
            top: true
            bottom: true
            right: true
        }

        margins.right: 3

        exclusionMode: ExclusionMode.Normal

        color: "transparent"
        NotifPanel {}
    }
}

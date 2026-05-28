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

    Text {
        text: " "
        font: Theme.defaultFont
        color: Theme.textMain
        Text {
            text: NotifData.tracked.values.length
            font.family: "Iosevka Nerd Font Propo"
            font.pointSize: 8.0
            font.bold: true
            color: Theme.textMain
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

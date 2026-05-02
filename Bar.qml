import QtQuick
import Quickshell

PanelWindow {
    id: bar

    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        left: 3
        right: 3
        top: 3
        bottom: 3
    }

    implicitHeight: 30

    Row {
        spacing: 10
        Power {}
        Clock {}
        Workspaces {}
    }

    Players {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Row {
        anchors.right: parent.right
        spacing: 10

        SystemTray {}
        NotifIcon {}
        Volume {}
    }
}

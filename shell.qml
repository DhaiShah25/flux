//@ pragma UseQApplication
import Quickshell
import QtQuick

Variants {
    model: Quickshell.screens

    Component.onCompleted: {
        console.log("\x1B[2J\x1B[3J\x1B[H");
    }

    delegate: Component {
        PanelWindow {
            id: bar
            required property var modelData

            Eye {}

            screen: modelData
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
                Clock {}
                Workspaces {}
            }

            Players {
                anchors.verticalCenter: parent.horizontalCenter
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
    }
}

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

WrapperRectangle {
    id: powerButton

    color: "#303446"
    margin: 4
    radius: 4
    implicitHeight: 30
    border.color: "#8caaee"
    border.width: 1

    Text {
        id: contentText
        text: ""
        color: "#c6d0f5"
        font {
            family: "MonaspiceRn NFP"
            pointSize: 14
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                powerPane.visible = !powerPane.visible;
            }
        }
    }

    PopupWindow {
        id: powerPane
        anchor.window: bar
        anchor.rect.y: 34
        implicitHeight: contentRect.height
        color: "transparent"

        WrapperRectangle {
            id: contentRect
            color: "#303446"
            margin: 4
            radius: 4

            border.color: "#8caaee"
            border.width: 1

            child: Column {
                spacing: 10

                Text {
                    text: "Sleep"
                    font {
                        family: "MonaspiceRn NFP"
                        pointSize: 12
                    }
                    color: "#c6d0f5"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: sleepProc.running = true
                    }
                    Process {
                        id: sleepProc
                        command: ["systemctl", "sleep"]
                        running: false
                    }
                }
                Text {
                    text: "Hibernate"
                    font {
                        family: "MonaspiceRn NFP"
                        pointSize: 12
                    }
                    color: "#c6d0f5"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: hibernateProc.running = true
                    }
                    Process {
                        id: hibernateProc
                        command: ["systemctl", "hibernate"]
                        running: false
                    }
                }
                Text {
                    text: "Shutdown"
                    font {
                        family: "MonaspiceRn NFP"
                        pointSize: 12
                    }
                    color: "#c6d0f5"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: shutdownProc.running = true
                    }
                    Process {
                        id: shutdownProc
                        command: ["systemctl", "shutdown"]
                        running: false
                    }
                }
                Text {
                    text: "Restart"
                    font {
                        family: "MonaspiceRn NFP"
                        pointSize: 12
                    }
                    color: "#c6d0f5"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: restartProc.running = true
                    }
                    Process {
                        id: restartProc
                        command: ["systemctl", "reboot"]
                        running: false
                    }
                }
            }
        }
    }
}

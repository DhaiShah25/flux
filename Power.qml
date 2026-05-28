import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

WrapperRectangle {
    id: powerButton

    color: Theme.bgBase
    margin: Theme.defaultMargin
    radius: Theme.cornerRadius
    implicitHeight: 30

    Text {
        id: contentText
        text: ""
        color: Theme.textMain
        font: Theme.defaultFont
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
            color: Theme.bgBase
            margin: Theme.defaultMargin
            radius: Theme.cornerRadius

            child: Column {
                spacing: Theme.defaultSpacing

                Text {
                    text: "Sleep"
                    font {
                        family: "Iosevka Nerd Font Propo"
                        pointSize: 12
                    }
                    color: Theme.textMain
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
                        family: "Iosevka Nerd Font Propo"
                        pointSize: 12
                    }
                    color: Theme.textMain
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
                        family: "Iosevka Nerd Font Propo"
                        pointSize: 12
                    }
                    color: Theme.textMain
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
                        family: "Iosevka Nerd Font Propo"
                        pointSize: 12
                    }
                    color: Theme.textMain
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

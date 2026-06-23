import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

WrapperRectangle {
  id: powerButton

  color: Theme.bgBase
  implicitHeight: 30
  margin: Theme.defaultMargin
  radius: Theme.cornerRadius

  Text {
    id: contentText

    color: Theme.textMain
    font: Theme.defaultFont
    text: ""

    MouseArea {
      anchors.fill: parent

      onClicked: {
        powerPane.visible = !powerPane.visible;
      }
    }
  }
  PopupWindow {
    id: powerPane

    anchor.rect.y: 34
    anchor.window: bar
    color: "transparent"
    implicitHeight: contentRect.height

    WrapperRectangle {
      id: contentRect

      color: Theme.bgBase
      margin: Theme.defaultMargin
      radius: Theme.cornerRadius

      child: Column {
        spacing: Theme.defaultSpacing

        Text {
          color: Theme.textMain
          text: "Sleep"

          font {
            family: "Iosevka Nerd Font Propo"
            pointSize: 12
          }
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
          color: Theme.textMain
          text: "Hibernate"

          font {
            family: "Iosevka Nerd Font Propo"
            pointSize: 12
          }
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
          color: Theme.textMain
          text: "Shutdown"

          font {
            family: "Iosevka Nerd Font Propo"
            pointSize: 12
          }
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
          color: Theme.textMain
          text: "Restart"

          font {
            family: "Iosevka Nerd Font Propo"
            pointSize: 12
          }
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

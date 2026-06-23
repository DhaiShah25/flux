import Quickshell.Widgets
import Quickshell
import QtQuick
import Quickshell.Io

WrapperRectangle {
  id: notifIcon

  color: "#303446"
  implicitHeight: 30
  margin: 4
  radius: 4

  Text {
    color: Theme.textMain
    font: Theme.defaultFont
    text: " "

    Text {
      anchors.bottom: parent.bottom
      anchors.right: parent.right
      color: Theme.textMain
      font.bold: true
      font.family: "Iosevka Nerd Font Propo"
      font.pointSize: 8.0
      text: Notifs.history.length
      visible: Notifs.history.length !== 0
    }
    MouseArea {
      anchors.fill: parent

      onClicked: notifs.centerOpen = !notifs.centerOpen
    }
  }
  Notifs {
    id: notifs
  }
}

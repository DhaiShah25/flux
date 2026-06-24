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

  child: Text {
    color: Theme.textMain
    font: Theme.defaultFont
    text: " " + (NotifData.history.count || "")

    MouseArea {
      anchors.fill: parent

      onClicked: NotifData.centerOpen = !NotifData.centerOpen
    }
  }

  Notifs {
    id: notifs
  }
}

import QtQuick
import Quickshell.Widgets
import Quickshell.Hyprland

WrapperRectangle {
  color: Theme.bgBase
  implicitHeight: 30
  margin: Theme.defaultMargin
  radius: Theme.cornerRadius

  Row {
    spacing: 10

    Repeater {
      model: Hyprland.workspaces

      delegate: Rectangle {
        required property var modelData

        color: "transparent"
        height: 20
        radius: 3
        width: 20

        Text {
          anchors.centerIn: parent
          color: modelData.active ? Theme.accent : Theme.textMain
          font.family: "Iosevka Nerd Font Propo"
          font.pointSize: 14.0
          text: modelData.name
        }
      }
    }
  }
}

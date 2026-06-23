import QtQuick
import Quickshell

PanelWindow {
  id: eyeTimer

  required property var screen

  color: Theme.bgBase
  exclusionMode: ExclusionMode.Normal
  focusable: false

  anchors {
    bottom: true
    left: true
    right: true
    top: true
  }
  Column {
    anchors.centerIn: parent

    Text {
      color: Theme.textMain
      font.bold: true
      font.family: "Iosevka Nerd Font Propo"
      font.pointSize: 160
      horizontalAlignment: Text.AlignHCenter
      text: "Eye Break"
    }
  }
}

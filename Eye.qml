import QtQuick
import Quickshell

PanelWindow {
    id: eyeTimer
    focusable: false
    color: Theme.bgBase

    required property var screen

    exclusionMode: ExclusionMode.Normal

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    Column {
        anchors.centerIn: parent
        Text {
            text: "Eye Break"
            font.family: "Iosevka Nerd Font Propo"
            font.bold: true
            font.pointSize: 160
            color: Theme.textMain
            horizontalAlignment: Text.AlignHCenter
        }
    }
}

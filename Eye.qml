import QtQuick
import Quickshell

PanelWindow {
    id: eyeTimer
    focusable: false
    color: "#303446"

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
            font.family: "MonaspiceRn NFP"
            font.bold: true
            font.pointSize: 160
            color: "#c6d0f5"
            horizontalAlignment: Text.AlignHCenter
        }
    }
}

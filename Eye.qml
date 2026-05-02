import QtQuick
import Quickshell
import Quickshell.Io

PanelWindow {
    id: eyeTimer
    focusable: false
    color: "#303446"
    visible: false

    exclusionMode: ExclusionMode.Normal

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    Timer {
        interval: eyeTimer.visible ? 20000 : 1200000
        running: true
        repeat: true
        onTriggered: {
            eyeTimer.visible = !eyeTimer.visible;
            breakSoundRunner.exec(["ffplay", "/run/current-system/sw/share/sounds/ocean/stereo/bell.oga", "-nodisp", "-autoexit", "-af", "volume=2.0"]);
        }
    }
    Process {id: breakSoundRunner}

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
        Text {
            text: "Skip"
            font.family: "MonaspiceRn NFP"
            font.bold: true
            font.pointSize: 20
            color: "#c6d0f5"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            MouseArea {
                anchors.fill: parent
                onClicked: eyeTimer.visible = !eyeTimer.visible
            }
        }
    }
}

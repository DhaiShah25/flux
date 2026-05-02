//@ pragma UseQApplication
import Quickshell
import QtQuick
import Quickshell.Io
ShellRoot {
    id: root
    property bool eyeVisible: false
    Timer {
        interval: eyeVisible ? 20000 : 1200000
        running: true
        repeat: true
        onTriggered: {
            eyeVisible = !eyeVisible;
            breakSoundRunner.exec(["ffplay", "/run/current-system/sw/share/sounds/ocean/stereo/bell.oga", "-nodisp", "-autoexit", "-af", "volume=1.0"]);
        }
    }
    Process {id: breakSoundRunner}

    Variants {
        model: Quickshell.screens


        delegate: Item {
            required property var modelData
            Bar {
                screen: modelData
            }
            Eye {
                screen: modelData
                visible: root.eyeVisible
            }
        }
    }

}

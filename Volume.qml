import QtQuick
import Quickshell.Widgets
import Quickshell.Services.Pipewire

WrapperRectangle {
    color: "#303446"
    margin: 4
    radius: 4
    implicitHeight: 30
    border.color: "#8caaee"
    border.width: 1

    Text {
        text: (Pipewire.defaultAudioSink.audio.volume * 100).toFixed(0) + (Pipewire.defaultAudioSink.audio.muted ? "% " : "% ")
        font.family: "MonaspiceRn NFP"
        font.pointSize: 14.
        color: "#e0def4"

        PwObjectTracker {
            objects: [Pipewire.defaultAudioSink]
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
            }
            onWheel: wheel => {
                wheel.accepted = true;
                Pipewire.defaultAudioSink.audio.volume += (wheel.angleDelta.y / 12000) ?? (wheel.pixelDelta.y / 3000.0);
                Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(1, Pipewire.defaultAudioSink.audio.volume));
            }
        }
    }
}

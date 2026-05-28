import QtQuick
import Quickshell.Widgets
import Quickshell.Services.Pipewire

WrapperRectangle {
    color: Theme.bgBase
    margin: Theme.defaultMargin
    radius: Theme.cornerRadius
    implicitHeight: 30

    Text {
        text: (Pipewire.defaultAudioSink.audio.volume * 100).toFixed(0) + (Pipewire.defaultAudioSink.audio.muted ? "% " : "% ")
        font.family: "Iosevka Nerd Font Propo"
        font.pointSize: 14.
        color: Theme.textMain

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

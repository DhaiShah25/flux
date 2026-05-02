pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Io

Singleton {
    id: root
    property var tracked: server.trackedNotifications
    NotificationServer {
        id: server
        actionsSupported: true
        actionIconsSupported: true
        bodyMarkupSupported: true
        imageSupported: true
        onNotification: (notif) => {
            notif.tracked = true;
            notifSoundRunner.exec(["ffplay", "/run/current-system/sw/share/sounds/ocean/stereo/outcome-success.oga", "-nodisp", "-autoexit", "-af", "volume=1.0"]);
        }
    }
    Process {id: notifSoundRunner}
}

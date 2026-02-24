pragma Singleton
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root
    property var tracked: server.trackedNotifications
    NotificationServer {
        id: server
        actionsSupported: true
        actionIconsSupported: true
        bodyMarkupSupported: true
        imageSupported: true
        onNotification: notif => notif.tracked = true
    }
}

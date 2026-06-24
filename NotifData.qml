pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

Item {
  id: notifData

  property bool centerOpen: false
  property alias history: historyModel
  property alias server: serverModel

  IpcHandler {
    function toggle(): void {
      notifData.centerOpen = !notifRoot.centerOpen;
    }

    target: "notifs"
  }
  ListModel {
    id: historyModel
  }
  Process {
    id: notifSoundRunner
  }
  NotificationServer {
    id: serverModel

    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: notif => {
      notif.tracked = true;
      historyModel.insert(0, {
        summary: notif.summary,
        body: notif.body,
        appName: notif.appName,
        time: Qt.formatDateTime(new Date(), "HH:mm")
      });

      notifSoundRunner.exec(["ffplay", "/run/current-system/sw/share/sounds/ocean/stereo/outcome-success.oga", "-nodisp", "-autoexit", "-af", "volume=1.0"]);
    }
  }
}

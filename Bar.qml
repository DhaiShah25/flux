import QtQuick
import Quickshell

PanelWindow {
  id: bar

  color: "transparent"
  implicitHeight: 30

  anchors {
    left: true
    right: true
    top: true
  }
  margins {
    bottom: 3
    left: 3
    right: 3
    top: 3
  }
  Row {
    spacing: Theme.defaultSpacing

    Power {}
    Clock {}
    Workspaces {}
  }
  Players {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
  }
  Row {
    anchors.right: parent.right
    spacing: Theme.defaultSpacing

    SystemTray {}
    NotifIcon {}
    Volume {}
  }
}

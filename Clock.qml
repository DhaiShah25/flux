import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Controls

WrapperRectangle {
  color: Theme.bgBase
  implicitHeight: 30
  implicitWidth: clockText.implicitWidth + 24
  margin: Theme.defaultMargin
  radius: Theme.cornerRadius

  Button {
    id: clockButton

    anchors.fill: parent
    hoverEnabled: true

    background: Rectangle {
      color: "transparent"
    }
    contentItem: Text {
      id: clockText

      color: Theme.textMain
      font: Theme.defaultFont
      horizontalAlignment: Text.AlignHCenter
      text: clockButton.hovered ? Qt.formatDateTime(clock.date, "MMM d, yyyy") : Qt.formatDateTime(clock.date, "ddd - hh:mm A")
      verticalAlignment: Text.AlignVCenter

      SystemClock {
        id: clock

        precision: SystemClock.Minutes
      }
    }
  }
}

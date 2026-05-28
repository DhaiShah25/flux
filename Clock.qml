import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Controls

WrapperRectangle {
    color: Theme.bgBase
    margin: Theme.defaultMargin
    radius: Theme.cornerRadius

    implicitWidth: clockText.implicitWidth + 24 
    implicitHeight: 30

    Button {
        id: clockButton
        anchors.fill: parent
        hoverEnabled: true

        background: Rectangle {
            color: "transparent"
        }

        contentItem: Text {
            id: clockText
            text: clockButton.hovered ? Qt.formatDateTime(clock.date, "MMM d, yyyy") : Qt.formatDateTime(clock.date, "ddd - hh:mm A")
            font: Theme.defaultFont
            color: Theme.textMain
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            SystemClock {
                id: clock
                precision: SystemClock.Minutes
            }
        }
    }
}

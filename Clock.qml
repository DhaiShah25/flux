import QtQuick
import Quickshell
import Quickshell.Widgets

WrapperRectangle {
    color: "#303446"
    margin: 4
    radius: 4
    implicitHeight: 30
    border.color: "#8caaee"
    border.width: 1
    Text {
        text: Qt.formatDateTime(clock.date, "ddd - hh:mm A")
        font.family: "MonaspiceRn NFP"
        font.pointSize: 14.0
        color: "#c6d0f5"

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }
    }
}

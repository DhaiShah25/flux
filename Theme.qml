pragma Singleton
import QtQuick

QtObject {
    readonly property color bgBase: "#303446"
    readonly property color bgSurface: "#292c3c"
    readonly property color textMain: "#c6d0f5"
    readonly property color textMuted: "#a5adce"
    readonly property color accent: "#8caaee"
    readonly property color border: "#414559"

    readonly property string fontFamily: "Iosevka Nerd Font Propo"
    
    readonly property font defaultFont: Qt.font({
        family: fontFamily,
        pointSize: 14.0,
        weight: Font.Normal
    })

    readonly property font titleFont: Qt.font({
        family: fontFamily,
        pointSize: 16.0,
        weight: Font.Bold
    })

    readonly property int cornerRadius: 4
    readonly property int defaultMargin: 4
    readonly property int defaultPadding: 8
    readonly property int defaultSpacing: 4
}

pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Notifications

WrapperRectangle {
    id: root

    property alias model: listView.model
    property string title: "Notifications:"

    color: Theme.bgBase
    radius: Theme.cornerRadius
    margin: Theme.defaultMargin
    implicitWidth: parent.width
    implicitHeight: parent.height - 8

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Text {
            text: root.title
            Layout.leftMargin: 8
            font.family: "Iosevka Nerd Font Propo"
            font.pointSize: 24.0
            font.bold: true
            color: Theme.textMain
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: Theme.defaultSpacing
            clip: true

            delegate: WrapperRectangle {
                id: notif
                margin: 4
                radius: 4
                color: "#414559"
                width: listView.width - (margin * 2)

                required property Notification modelData

                Column {
                    width: parent.width
                    spacing: 8

                    Row {
                        width: parent.width
                        spacing: 8

                        Image {
                            visible: !!(notif.modelData.image || notif.modelData.appIcon)
                            source: notif.modelData.image || notif.modelData.appIcon
                            height: 40
                            width: 40
                            fillMode: Image.PreserveAspectCrop
                            clip: true
                        }

                        Column {
                            width: parent.width - (visible ? 48 : 0)
                            Text {
                                width: parent.width
                                text: notif.modelData.summary
                                font.family: "Iosevka Nerd Font Propo"
                                font.pointSize: 14.
                                font.bold: true
                                color: Theme.textMain
                                wrapMode: Text.WordWrap
                            }
                            Text {
                                width: parent.width
                                text: notif.modelData.body
                                font.family: "Iosevka Nerd Font Propo"
                                font.pointSize: 10.
                                font.bold: true
                                color: "#b5bfe2"
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    FlexboxLayout {
                        width: parent.width
                        direction: FlexboxLayout.Row
                        justifyContent: FlexboxLayout.JustifySpaceEvenly
                        gap: 10

                        Repeater {
                            model: notif.modelData.actions
                            ActionButton {
                                required property var modelData
                                text: modelData.text
                                onClicked: modelData.invoke()
                            }
                        }

                        ActionButton {
                            text: ""
                            onClicked: notif.modelData.dismiss()
                        }
                    }
                }
            }
        }
    }

    component ActionButton: Button {
        id: control
        Layout.fillWidth: true
        contentItem: Text {
            text: control.text
            font {
                family: "Iosevka Nerd Font Propo"
                pointSize: 12
            }
            color: Theme.textMain
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            implicitHeight: 30
            color: control.hovered ? "#626880" : "#51576d"
            radius: 100
        }
    }
}

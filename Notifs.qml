import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import "config.js" as Config

Item {
  id: notifRoot

  PanelWindow {
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: Math.max(1, column.implicitHeight)
    implicitWidth: 380

    anchors {
      right: true
      top: true
    }
    margins {
      right: 12
      top: Config.bar.height + 8
    }
    ColumnLayout {
      id: column

      spacing: 10
      width: parent.width

      Repeater {
        model: NotifData.server.trackedNotifications

        delegate: WrapperRectangle {
          id: card

          required property var modelData

          Layout.fillWidth: true
          border.color: modelData.urgency === NotificationUrgency.Critical ? Config.colors.red : Config.colors.accent
          border.width: 2
          color: Config.colors.bg
          margin: 4
          radius: 8

          Timer {
            interval: Config.notifications.timeout
            running: modelData.urgency !== NotificationUrgency.Critical && modelData.actions.length === 0

            onTriggered: card.modelData.dismiss()
          }
          ColumnLayout {
            Layout.fillWidth: true

            RowLayout {
              id: layout

              spacing: 10

              Image {
                Layout.alignment: Qt.AlignTop
                Layout.preferredHeight: 36
                Layout.preferredWidth: 36
                fillMode: Image.PreserveAspectFit
                source: card.modelData.image || card.modelData.appIcon || ""
                visible: source.toString() !== ""
              }
              ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                RowLayout {
                  Layout.fillWidth: true

                  Text {
                    Layout.fillWidth: true
                    color: Config.colors.cyan
                    elide: Text.ElideRight
                    font.bold: true
                    font.family: Config.bar.fontFamily
                    font.pixelSize: Config.bar.fontSize
                    text: card.modelData.summary
                  }
                  WrapperRectangle {
                    color: "transparent"
                    margin: 4

                    child: Text {
                      color: Config.colors.red
                      text: "x"

                      font {
                        family: Config.bar.fontSize
                        pointSize: 12
                      }
                    }
                  }
                  MouseArea {
                    anchors.fill: parent

                    onClicked: card.modelData.dismiss()
                  }
                }
                Text {
                  Layout.fillWidth: true
                  color: Config.colors.text
                  font.family: Config.bar.fontFamily
                  font.pixelSize: Config.bar.fontSize * 0.8
                  text: card.modelData.body
                  visible: text !== ""
                  wrapMode: Text.WordWrap
                }
              }
            }
            FlexboxLayout {
              direction: FlexboxLayout.Row
              gap: 10
              justifyContent: FlexboxLayout.JustifySpaceEvenly
              width: parent.width

              Repeater {
                model: card.modelData.actions

                Text {
                  required property var modelData

                  Layout.fillWidth: true
                  color: Config.colors.text
                  horizontalAlignment: Text.AlignHCenter
                  text: modelData.text

                  font {
                    family: Config.bar.fontSize
                    pointSize: 12
                  }
                  MouseArea {
                    anchors.fill: parent

                    onClicked: modelData.invoke()
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  PanelWindow {
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: centerCol.implicitHeight + 24
    implicitWidth: 380
    visible: NotifData.centerOpen

    anchors {
      right: true
      top: true
    }
    margins {
      right: 12
      top: Config.bar.height + 12
    }
    Rectangle {
      anchors.fill: parent
      border.color: Config.colors.accent
      border.width: 2
      color: Config.colors.bg
      radius: 10

      ColumnLayout {
        id: centerCol

        anchors.fill: parent
        anchors.margins: 12
        spacing: 10
        width: parent.width

        RowLayout {
          Layout.fillWidth: true

          Text {
            Layout.fillWidth: true
            color: Config.colors.cyan
            font.bold: true
            font.family: Config.bar.fontFamily
            font.pointSize: Config.bar.fontSize + 2
            text: "Notifications"
          }
          Text {
            color: Config.colors.red
            font.family: Config.bar.fontFamily
            font.pointSize: Config.bar.fontSize - 4
            text: "Clear All"
            visible: NotifData.history.count !== 0

            MouseArea {
              anchors.fill: parent

              onClicked: NotifData.history.clear()
            }
          }
        }
        ListView {
          clip: false
          height: 600
          model: NotifData.history
          spacing: 10
          width: 360

          delegate: WrapperRectangle {
            id: card

            required property int index
            required property var modelData

            border.color: modelData.urgency === NotificationUrgency.Critical ? Config.colors.red : Config.colors.accent
            border.width: 1
            color: Config.colors.bg
            margin: 4
            radius: 8
            width: 360

            ColumnLayout {
              Layout.fillWidth: true
              spacing: 2

              RowLayout {
                Layout.fillWidth: true
                spacing: 6

                Text {
                  Layout.fillWidth: true
                  color: Config.colors.cyan
                  font.bold: true
                  font.family: Config.bar.fontFamily
                  font.pixelSize: Config.bar.fontSize
                  text: card.modelData.appName + ": " + card.modelData.summary
                }
                Text {
                  color: Config.colors.muted
                  font.family: Config.bar.fontFamily
                  font.pixelSize: Config.bar.fontSize - 3
                  text: card.modelData.time
                }
                Text {
                  color: Config.colors.red
                  font.family: Config.bar.fontFamily
                  font.pixelSize: Config.bar.fontSize - 3
                  text: "x"

                  MouseArea {
                    anchors.fill: parent

                    onClicked: NotifData.history.remove(index)
                  }
                }
              }
              Text {
                Layout.fillWidth: true
                color: Config.colors.text
                font.family: Config.bar.fontFamily
                font.pixelSize: Config.bar.fontSize * 0.8
                text: card.modelData.body
                visible: text !== ""
                wrapMode: Text.WordWrap
              }
            }
          }
        }
      }
    }
  }
}

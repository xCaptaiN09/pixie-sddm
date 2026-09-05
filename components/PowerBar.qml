/**
 * Pixie SDDM - PowerBar Component
 * Author: xCaptaiN09
 */
import QtQuick

Row {
    id: powerBarRoot
    spacing: 20
    height: 30

    property color textColor: "white"

    FontLoader { id: iconFont; source: "../assets/fonts/MaterialDesignIcons.ttf" }

    property bool hintMode: false

    function cycleLayout() {
        if (typeof keyboard !== "undefined" && keyboard.layouts.length > 1)
            keyboard.currentLayout = (keyboard.currentLayout + 1) % keyboard.layouts.length
    }
    function doSuspend() { sddm.suspend() }
    function doReboot() { sddm.reboot() }
    function doPowerOff() { sddm.powerOff() }

    component HintBadge : Rectangle {
        property string letter: ""
        property bool shown: false
        width: 16; height: 16; radius: 8
        color: "black"; opacity: 0.78
        visible: shown
        Text {
            text: parent.letter
            color: "white"
            font.pixelSize: 11
            font.weight: Font.Bold
            anchors.centerIn: parent
        }
    }

    // Battery (With forced live updates)
    Row {
        id: batteryRow
        spacing: 5
        visible: typeof battery !== "undefined" && typeof battery.percent !== "undefined"
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: batteryText
            text: (typeof battery !== "undefined" ? battery.percent : "0") + "%"
            color: textColor
            font.pixelSize: 14
            font.weight: Font.Medium
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            id: batteryIcon
            text: (typeof battery !== "undefined" && battery.charging) ? "󱐋" : "󰁹"
            color: textColor
            font.pixelSize: 18
            font.family: iconFont.name
            anchors.verticalCenter: parent.verticalCenter
        }

        // Bulletproof Live Update: SDDM sometimes fails to emit battery signals,
        // so we force a check every 5 seconds.
        Timer {
            interval: 5000
            running: typeof battery !== "undefined" && battery.present
            repeat: true
            onTriggered: {
                batteryText.text = battery.percent + "%"
                batteryIcon.text = battery.charging ? "󱐋" : "󰁹"
            }
        }
    }

    // Keyboard Layout
    Text {
        text: (typeof keyboard !== "undefined" && keyboard.layouts[keyboard.currentLayout]) ? keyboard.layouts[keyboard.currentLayout].shortName : "US"
        color: textColor
        font.pixelSize: 14
        font.capitalization: Font.AllUppercase
        visible: typeof keyboard !== "undefined" && keyboard.layouts.length > 1
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            onClicked: powerBarRoot.cycleLayout()
        }
    }

    // Suspend
    Text {
        text: "󰤄"
        color: textColor
        font.pixelSize: 20
        font.family: iconFont.name
        anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: powerBarRoot.doSuspend()
            }
            HintBadge {
                letter: "s"
                shown: powerBarRoot.hintMode
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                anchors.topMargin: 4
            }
        }

    // Restart
    Text {
        text: "󰑐"
        color: textColor
        font.pixelSize: 20
        font.family: iconFont.name
        anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: powerBarRoot.doReboot()
            }
            HintBadge {
                letter: "r"
                shown: powerBarRoot.hintMode
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                anchors.topMargin: 4
            }
        }

    // Shutdown
    Text {
        text: "󰐥"
        color: textColor
        font.pixelSize: 20
        font.family: iconFont.name
        anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: powerBarRoot.doPowerOff()
            }
            HintBadge {
                letter: "p"
                shown: powerBarRoot.hintMode
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.bottom
                anchors.topMargin: 4
            }
        }
}

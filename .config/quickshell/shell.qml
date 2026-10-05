import Quickshell
import Quickshell.Wayland
import QtQuick


PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: "#ffffff"

    Text {
        anchors.centerIn: parent
        text: "Top bar"
        color: "#000000"
        font.pixelSize: 18
    }
}

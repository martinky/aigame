import Felgo 3.0
import QtQuick 2.0

/*!
    \brief Splash Scene shown at the start of the game app.
*/
SceneBase {

    signal finished

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Column {
        anchors.centerIn: parent
        spacing: 50

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "red"
            font.pixelSize: 36
            font.bold: true

            text: "ALIEN INVASION!"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "red"
            font.pixelSize: 16

            text: "Tap the screen to continue..."
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: false
        onTriggered: finished()
    }

    MouseArea {
        anchors.fill: parent

        onPressed: finished()
    }

}

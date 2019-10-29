import Felgo 3.0
import QtQuick 2.0

//
// Splash Scene shown at the start of the app.
//
SceneBase {

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

            text: "ALIEN INVASION"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "red"
            font.pixelSize: 16

            text: "Tap the screen to begin a new game."
        }
    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            gameWindow.resetGame()
        }
    }

}

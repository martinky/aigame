import Felgo 3.0
import QtQuick 2.0

//
// Scene shown at Game Over.
//
SceneBase {

    property int score: 0

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Column {
        anchors.centerIn: parent
        spacing: 5

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "darkred"
            font.pointSize: 14
            font.bold: true

            text: "GAME OVER"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "darkred"
            font.pointSize: 12

            text: "Your score is: " + score
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "darkred"
            font.pointSize: 10

            text: "Tap the screen to restart the game."
        }
    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            gameWindow.resetGame()
        }
    }

}

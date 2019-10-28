import Felgo 3.0
import QtQuick 2.0

//
// Scene shown at end game - both at game over and victory situations.
//
SceneBase {

    property int score: 0
    property bool victory: false

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Column {
        anchors.centerIn: parent
        spacing: 15

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "red"
            font.pixelSize: 24
            font.bold: true

            horizontalAlignment: Text.AlignHCenter

            text: victory ? "CONGRATULATIONS\nYOU HAVE WON!" : "GAME OVER"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "red"
            font.pixelSize: 22

            text: "Your score is: " + score
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

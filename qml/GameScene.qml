import Felgo 3.0
import QtQuick 2.0

//
// Scene that hosts the gameplay.
//
SceneBase {
    property int score: 0
    property bool victory: false

    //TODO: support multiple levels
    property string levelSource: "LevelOne.qml"

    signal gameFinished()

    function reset() {
        score = 0
        victory = false
        entityManager.removeAllEntities()
        levelLoader.source = ""
        levelLoader.source = levelSource
    }

    PhysicsWorld {
        //debugDrawVisible: true
        z: 1000
    }

    Loader {
        id: levelLoader
        anchors.fill: parent
        source: levelSource
    }

    Connections {
        target: levelLoader.item
        onLevelFinished: {
            victory = true
            gameFinished()
            //TODO: go to next level when multiple levels are supported
        }
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 25

        color: "white"
        font.pixelSize: 20
        font.bold: true

        text: "Score: " + gameScene.score
    }
}

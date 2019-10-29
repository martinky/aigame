import Felgo 3.0
import QtQuick 2.0

//
// Scene that hosts the gameplay.
//
SceneBase {
    property int score: 0
    property bool victory: false

    // array of level source files
    property string levelsBaseDir: "../levels/"
    property variant levels: []
    property int currentLevel_: 0

    signal gameFinished()

    function reset() {
        currentLevel_ = 0
        score = 0
        victory = false
        entityManager.removeAllEntities()
        levelLoader.source = ""
        if (currentLevel_ < levels.length) {
            levelLoader.source = levelsBaseDir + levels[currentLevel_]
        }
    }

    PhysicsWorld {
        //debugDrawVisible: true
        z: 1000
    }

    Loader {
        id: levelLoader
        anchors.fill: parent
        source: levels[0]
    }

    Connections {
        target: levelLoader.item
        onLevelFinished: {
            entityManager.removeAllEntities()
            currentLevel_ ++
            if (currentLevel_ < levels.length) {
                // go to next level...
                levelLoader.source = levelsBaseDir + levels[currentLevel_]
            } else {
                // or declare victory if already at last level
                levelLoader.source = ""
                victory = true
                gameFinished()
            }
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

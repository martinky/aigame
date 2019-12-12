import Felgo 3.0
import QtQuick 2.0

/*!
    \brief Scene that hosts the gameplay.

    Handles \l Level switching and counting of the player's score.

    The game ends when all levels are cleared or the player is destroyed and
    the \l gameFinished() signal is then triggered.
*/
SceneBase {
    /*! This property holds the player score. */
    property int score: 0
    /*! This property says whether the game ended in a victory. */
    property bool victory: false

    /*! List of urls to level source files. */
    property variant levels: []
    /*! \internal Index of the current level. */
    property int currentLevel_: 0

    /*! This signal is triggered once all levels are cleared or the player is destroyed. */
    signal gameFinished()

    /*! Restarts the game from the first level. */
    function reset(levelIndex) {
        currentLevel_ = levelIndex === undefined ? 0 : levelIndex;
        score = 0;
        victory = false;
        entityManager.removeAllEntities();
        levelLoader.source = "";
        if (currentLevel_ < levels.length) {
            setLevel_(currentLevel_);
        }
    }

    function setLevel_(index) {
        levelLoader.setSource(levels[index].url, { levelCode: levels[index].code });
    }

    PhysicsWorld {
        //debugDrawVisible: true
        z: 1000
    }

    Loader {
        id: levelLoader
        anchors.fill: parent
    }

    Connections {
        target: levelLoader.item
        onLevelFinished: {
            entityManager.removeAllEntities();
            currentLevel_ ++;
            if (currentLevel_ < levels.length) {
                // go to next level...
                setLevel_(currentLevel_);
            } else {
                // or declare victory if already at last level
                levelLoader.source = "";
                victory = true;
                gameFinished();
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

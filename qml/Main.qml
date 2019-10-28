import QtQuick 2.0
import Felgo 3.0

GameWindow {
    id: gameWindow

    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    activeScene: gameScene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 960
    screenHeight: 640

    property alias entityManager: entityManager
    property alias scene: gameScene

    function createExplosion(x, y) {
        var explosionProperties = {
            x: x - 32,
            y: y - 32,
            rotation: 0
        }

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("Explosion.qml"),
                    explosionProperties);
    }

    function resetGame() {
        state = "GAME"
        entityManager.removeAllEntities()
        gameScene.reset()
    }

    function setGameOver() {
        gameOverTimer.restart()
    }

    function setGameOverReally() {
        state = "GAME_OVER"
    }

    Timer {
        id: gameOverTimer
        interval: 1000
        onTriggered: setGameOverReally()
    }

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    Scene {
        id: gameScene

        anchors.fill: gameWindow
        opacity: 0

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 800
        height: 512

        property int score: 0

        function reset() {
            score = 0
            levelLoader.source = ""
            levelLoader.source = "Level.qml"
        }

        PhysicsWorld {
            //debugDrawVisible: true
            z: 1000
        }

        Loader {
            id: levelLoader
            anchors.fill: parent
            source: "Level.qml"
        }
    }

    Scene {
        id: gameOverScene

        anchors.fill: gameWindow
        opacity: 0

        width: 800
        height: 512

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
                font.pointSize: 11
                //font.bold: true

                text: "Your score is: " + gameScene.score
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                color: "darkred"
                font.pointSize: 10
                //font.bold: true

                text: "Please tap the screen to restart game."
            }
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                gameWindow.resetGame()
            }
        }
    }


    state: "GAME"

    // state machine, takes care reversing the PropertyChanges when changing the state like changing the opacity back to 0
    states: [
        State {
            name: "GAME"
            PropertyChanges { target: gameScene; opacity: 1 }
            PropertyChanges { target: gameWindow; activeScene: gameScene }
        },
        State {
            name: "GAME_OVER"
            PropertyChanges { target: gameOverScene; opacity: 1 }
            PropertyChanges { target: gameWindow; activeScene: gameOverScene }
        }
        //TODO: menu scene, high-score scene
    ]

}

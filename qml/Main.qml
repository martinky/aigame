import QtQuick 2.0
import Felgo 3.0
import "scenes"

/*!
    \brief The root QML item of the game application.
*/
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

    /*! Property alias for easy access to the EntityManager from other components. */
    property alias entityManager: entityManager
    /*! Property alias for easy access to the \l GameScene from other components. */
    property alias gameScene: gameScene

    /*! Starts a new game. */
    function resetGame() {
        state = "GAME"
        gameScene.reset()
    }

    /*! Displays an end game screen. */
    function setGameOver() {
        gameOverTimer.restart()
    }

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    GameScene {
        id: gameScene

        levels: [
            Qt.resolvedUrl("levels/LevelOne.qml"),
            Qt.resolvedUrl("levels/LevelTwo.qml")
        ]

        onGameFinished: setGameOver()
    }

    GameOverScene {
        id: gameOverScene
    }

    SplashScene {
        id: splashScene
    }

    Timer {
        id: gameOverTimer
        interval: 1000
        onTriggered: {
            gameOverScene.score = gameScene.score
            gameOverScene.victory = gameScene.victory
            gameWindow.state = "GAME_OVER"
        }
    }

    state: "SPLASH"

    states: [
        State {
            name: "SPLASH"
            PropertyChanges { target: splashScene; opacity: 1 }
            PropertyChanges { target: gameWindow; activeScene: splashScene }
        },
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
    ]

}

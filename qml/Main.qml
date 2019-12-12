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
    function resetGame(levelIndex) {
        state = "GAME";
        gameScene.reset(levelIndex);
    }

    function resetGameWithLevel(code) {
        var levelIndex = gameScene.levels.findIndex(lvl => lvl.code == code);
        console.log("ENTERING LEVEL " + levelIndex);

        if (levelIndex >= 0) {
            resetGame(levelIndex);
        }
    }

    /*! Displays an end game screen. */
    function setGameOver() {
        gameOverScene.score = gameScene.score;
        gameOverScene.victory = gameScene.victory;
        gameWindow.state = "GAME_OVER";
    }

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    GameScene {
        id: gameScene

        levels: [
            { url: Qt.resolvedUrl("levels/LevelOne.qml"), code: "XYGA" },
            { url: Qt.resolvedUrl("levels/LevelTwo.qml"), code: "UVFQ" }
        ]

        onGameFinished: setGameOver()
    }

    GameOverScene {
        id: gameOverScene
        onGoBack: gameWindow.state = "MENU" // resetGame()
    }

    SplashScene {
        id: splashScene
        onFinished: gameWindow.state = "MENU" // resetGame()
    }

    MenuScene {
        id: menuScene
        onStartGame: resetGame()
        onGoToLevel: resetGameWithLevel(code)
        onQuit: Qt.quit()
    }

    // global sounds

    SoundEffect {
        id: soundExplosion
        source: "../assets/sounds/pexplosion.wav"
    }

    state: "SPLASH"

    states: [
        State {
            name: "SPLASH"
            PropertyChanges { target: splashScene; opacity: 1 }
            PropertyChanges { target: gameWindow; activeScene: splashScene }
        },
        State {
            name: "MENU"
            PropertyChanges { target: menuScene; opacity: 1 }
            PropertyChanges { target: gameWindow; activeScene: menuScene }
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

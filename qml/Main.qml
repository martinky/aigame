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

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    Scene {
        id: gameScene

        anchors.fill: gameWindow

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 800
        height: 512

        PhysicsWorld {
            debugDrawVisible: true
            z: 1000
        }

        ParallaxScrollingBackground {
            anchors.fill: parent

            sourceImage: "../assets/background/desert.png"
            movementVelocity: Qt.point(-50, 0)
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                console.log("pressed = " + mouse.x + " , " + mouse.y)
                player.move(mouse.x, mouse.y, true)
            }

            onPositionChanged: {
                console.log("position = " + mouse.x + " , " + mouse.y)
                player.move(mouse.x, mouse.y, true)
            }

            onReleased: {
                console.log("released = " + mouse.x + " , " + mouse.y)
                player.move(mouse.x, mouse.y, false)
            }
        }

        Player {
            id: player
        }

    }
}

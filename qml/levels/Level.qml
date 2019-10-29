import Felgo 3.0
import QtQuick 2.0
import"../entities"

/*!
    \brief This item holds the basic building blocks of a level.

    Contains basic building blocks of a level: the player entity,
    level background and enemy entities. Handles the input and controls the
    \l Player ship movements and actions.

    The \l levelFinished() signal is triggered once there are no more enemies
    alive.

    The background image, number, type and configuration of enemies comprise
    a specific level and are specified in a derived type.
*/
Item {
    id: level

    /*! Sets the url to the background image. */
    property alias backgroundImage: background.sourceImage

    /*! This signal is triggered once all enemies are cleared: either destroyed
        or went past the left edge of the screen. */
    signal levelFinished()

    ParallaxScrollingBackground {
        id: background
        anchors.fill: parent

        movementVelocity: Qt.point(-50, 0)
    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            player.move(mouse.x, mouse.y, true)
        }

        onPositionChanged: {
            player.move(mouse.x, mouse.y, true)
        }

        onReleased: {
            player.move(mouse.x, mouse.y, false)
        }
    }

    Player {
        id: player
        x: 20
        y: 200
    }

    Timer {
        id: finishTestTimer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            var enemies = entityManager.getEntityArrayByType("enemy")
            if (enemies.length == 0) {
                running = false
                levelFinished()
            }
        }
    }
}

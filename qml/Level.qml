import Felgo 3.0
import QtQuick 2.0

//
// Basic building blocks of a level: holds and controls the player entity,
// level background and enemy entities.
//
// The levelFinished() signal is triggered once there are no more enemies alive.
// Level finish condition is tested periodically by the finishTestTimer.
//
Item {
    id: level

    property alias backgroundImage: background.sourceImage

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

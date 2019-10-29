import Felgo 3.0
import QtQuick 2.0

//
// Abstract enemy ship - need to set at least the avatar.
// Enemies moves in from the right edge of the screen towards the player.
//
Ship {
    id: enemy
    entityType: "enemy"

    property int score: 100

    property real speed: 100
    property bool firing: false
    property int firingInterval: 1500
    property real projectileSpeed: 200

    onCollided: {
        if (collidedEntity.entityType === "playerProjectile") {
            gameScene.score += score
            collidedEntity.removeEntity()
            explode()
        }
    }

    MovementAnimation {
        target: enemy
        property: "x"
        minPropertyValue: -enemy.width
        velocity: -enemy.speed
        running: true
        onLimitReached: {
            enemy.removeEntity()
        }
    }

    Timer {
        repeat: true
        interval: enemy.firingInterval
        running: enemy.firing && enemy.x < gameScene.width
        triggeredOnStart: true
        onTriggered: {
            // create new enemy projectile
            var projectileProperties = {
                x: enemy.x,
                y: enemy.y + enemy.height / 2 - 5,
                rotation: 0,
                speed: enemy.projectileSpeed
            }

            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("EnemyProjectile.qml"),
                        projectileProperties);
        }
    }
}

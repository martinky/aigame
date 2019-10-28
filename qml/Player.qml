import QtQuick 2.0
import Felgo 3.0

//
// Player ship entity. Movement is controled by mouse input in the game scene.
// The ship can fire projectiles rapidly - controlled by the firing property.
//
Ship {
    id: player
    entityType: "player"

    avatar: "../assets/ships/ufo.png"

    property bool firing: false

    // Moves the player ship to given position and changes the firing state.
    function move(x, y, firing) {
        player.x = x - player.width / 2
        player.y = y - player.height / 2
        player.firing = firing
    }

    onCollided: {
        if (collidedEntity.entityType === "enemyProjectile") {
            collidedEntity.removeEntity()
            explode()
        }
        if (collidedEntity.entityType === "enemy") {
            collidedEntity.explode()
            explode()
        }
    }

    onShipDestroyed: {
        //TODO: game over
        console.log("GAME OVER")
    }

    Behavior on x { SmoothedAnimation { velocity: 300 } }
    Behavior on y { SmoothedAnimation { velocity: 300 } }

    Timer {
        repeat: true
        interval: 200
        running: player.firing
        triggeredOnStart: true
        onTriggered: {
            // create new projectile
            var projectileProperties = {
                x: player.x + 100,
                y: player.y + 18,
                rotation: 0
            }

            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("PlayerProjectile.qml"),
                        projectileProperties);
        }
    }
}

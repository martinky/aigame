import QtQuick 2.0
import Felgo 3.0

/*!
    \inherits Ship
    \brief Player ship entity.

    Movement of the player ship is controled by mouse input in the \l Level item.
    The ship can fire projectiles rapidly - controlled by the \l firing property.

    Collision logic with enemies and enemy projectiles is handled here.

    If the player collides with an \l Enemy or an \l EnemyProjectile, the player
    is destroyed and the game ends.
*/
Ship {
    id: player
    entityType: "player"

    avatar: "../../assets/ships/ufo.png"

    /*! Controls whether the player ship is firing projectiles. */
    property bool firing: false

    /*! Moves the player ship to given position and changes the firing state. */
    function move(x, y, firing) {
        player.x = x - player.width / 2;
        player.y = y - player.height / 2;
        player.firing = firing;
    }

    onCollided: {
        if (collidedEntity.entityType === "enemyProjectile" || collidedEntity.entityType === "enemy") {
            gameWindow.setGameOver();
            if (collidedEntity.entityType === "enemy") {
                collidedEntity.explode();
            } else {
                collidedEntity.removeEntity();
            }
            soundExplosion.play();
            explode();
        }
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
            };

            soundShot.play();
            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("PlayerProjectile.qml"),
                        projectileProperties);
        }
    }

    SoundEffect {
        id: soundShot
        source: "../../assets/sounds/pshot.wav"
    }
}

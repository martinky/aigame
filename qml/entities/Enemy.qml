import Felgo 3.0
import QtQuick 2.0

/*!
    \inherits Ship
    \brief Abstract enemy ship entity.

    Contains common parts of all enemy ships: their speed, firing mode,
    and score points which the player earns for destroing this enemy.

    Enemies emerge from the right edge of the screen and travel left, towards
    the player.

    Collision logic of the enemy entity with player's projectile is handled
    here.

    Enemy appearance is customized by setting the \l Ship::avatar property.
    Behavior can be customized in derived types, see: \l Plane, \l Scout, \l Turbo.
*/
Ship {
    id: enemy
    entityType: "enemy"

    /*! Score points the player earns when destroying this enemy. */
    property int score: 100

    /*! Travel speed in pixels per second. Enemies move from right to left. */
    property real speed: 100
    /*! Controls whether this enemy fires projectiles. */
    property bool firing: false
    /*! Interval between firing projectiles in milliseconds. */
    property int firingInterval: 1500
    /*! Speed of the fired projectile in pixels per second. The speed is absolute. */
    property real projectileSpeed: 200

    onCollided: {
        if (collidedEntity.entityType === "playerProjectile") {
            gameScene.score += score;
            collidedEntity.removeEntity();
            explode();
        }
    }

    MovementAnimation {
        target: enemy
        property: "x"
        minPropertyValue: -enemy.width
        velocity: -enemy.speed
        running: true
        onLimitReached: {
            enemy.removeEntity();
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
            };

            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("EnemyProjectile.qml"),
                        projectileProperties);
        }
    }
}

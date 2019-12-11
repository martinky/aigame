import QtQuick 2.0
import Felgo 3.0

/*!
    \brief Projectile entity fired by the \l Player ship.

    If an \l Enemy entity collides with the player's projectile, the enemy is
    destroyed.
*/
EntityBase {
    id: playerProjectile
    entityType: "playerProjectile"
    width: img.implicitWidth
    height: img.implicitHeight

    Image {
        id: img
        source: "../../assets/projectiles/bullet.png"
    }

    BoxCollider {
        id: collider
        anchors.fill: img
        collisionTestingOnlyMode: true
        bullet: true
    }

    MovementAnimation {
        target: playerProjectile
        property: "x"
        maxPropertyValue: gameScene.width
        velocity: 300
        running: true
        onLimitReached: {
            playerProjectile.removeEntity();
        }
    }
}

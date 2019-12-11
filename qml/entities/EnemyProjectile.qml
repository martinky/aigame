import QtQuick 2.0
import Felgo 3.0

/*!
    \brief Enemy projectile entity.

    Enemy projectiles move from right to left. If the \l Player collides with
    an enemy projectile, the player is destroyed. The \l speed is set by the
    \l Enemy entity that fires it.
*/
EntityBase {
    id: enemyProjectile
    entityType: "enemyProjectile"
    width: img.implicitWidth
    height: img.implicitHeight

    /*! Holds the speed of the projectile in pixels per second. */
    property real speed: 300

    Image {
        id: img
        source: "../../assets/projectiles/shot.png"
    }

    BoxCollider {
        id: collider
        anchors.fill: img
        collisionTestingOnlyMode: true
        bullet: true
    }

    MovementAnimation {
        // enemy projectiles travel to the left
        target: enemyProjectile
        property: "x"
        minPropertyValue: -enemyProjectile.width
        velocity: -enemyProjectile.speed
        running: true
        onLimitReached: {
            enemyProjectile.removeEntity();
        }
    }
}

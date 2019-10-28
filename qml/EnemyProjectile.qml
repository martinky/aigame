import QtQuick 2.0
import Felgo 3.0

//
// Projectile entity fired by enemy ships.
//
EntityBase {
    id: enemyProjectile
    entityType: "enemyProjectile"
    width: img.implicitWidth
    height: img.implicitHeight

    property real speed: 300

    Image {
        id: img
        source: "../assets/projectiles/shot.png"
    }

    BoxCollider {
        id: collider
        anchors.fill: img
        collisionTestingOnlyMode: true
        bullet: true
    }

    MovementAnimation {
        target: enemyProjectile
        property: "x"
        minPropertyValue: -enemyProjectile.width
        velocity: -enemyProjectile.speed
        running: true
        onLimitReached: {
            enemyProjectile.removeEntity()
        }
    }
}

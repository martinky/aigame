import QtQuick 2.0
import Felgo 3.0

//
// Projectile entity fired by the player's ship.
//
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
            playerProjectile.removeEntity()
        }
    }
}

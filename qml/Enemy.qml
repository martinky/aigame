import Felgo 3.0
import QtQuick 2.0

//TODO: make into generic base
//
// Enemy ship, moves in from the right edge of the screen, towards the player.
//
EntityBase {
    id: enemy
    entityType: "enemy"

    width: img.implicitWidth
    height: img.implicitHeight

    property real speed: 100
    property alias avatar: img.source

    // Replaces the ship with an explosion animation.
    function explode() {
        createExplosion(enemy.x + enemy.width / 2,
                        enemy.y + enemy.height / 2)
        enemy.removeEntity()
    }

    Image {
        id: img
        source: "../assets/ships/plane.png"
    }

    BoxCollider {
        id: collider
        anchors.fill: img
        anchors.margins: 5
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var body = other.getBody();
            var collidedEntity = body.target;
            var collidedEntityType = collidedEntity.entityType;
            //var collidedEntityId = collidedEntity.entityId;


            if (collidedEntityType === "playerProjectile") {
                collidedEntity.removeEntity()
                explode()
            }
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
}

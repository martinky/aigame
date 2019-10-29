import Felgo 3.0
import QtQuick 2.0

//
// Abstract ship - common parts of both player and enemy ships.
//
EntityBase {
    id: ship

    width: img.implicitWidth
    height: img.implicitHeight

    property alias avatar: img.source

    signal shipDestroyed()
    signal collided(var collidedEntity)

    // Replaces the ship with an explosion animation.
    function explode() {
        createExplosion(ship.x + ship.width / 2,
                        ship.y + ship.height / 2)
        ship.removeEntity()
        shipDestroyed()
    }

    Image {
        id: img
    }

    BoxCollider {
        id: collider
        anchors.fill: img
        anchors.margins: 5
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var body = other.getBody();
            var collidedEntity = body.target;
            collided(collidedEntity)
        }
    }
}

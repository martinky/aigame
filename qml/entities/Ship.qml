import Felgo 3.0
import QtQuick 2.0

/*!
    \inherits EntityBase
    \brief Abstract ship entity.

    Contains common parts of both player and enemy ships.

    Inherited entities: \l Player, \l Enemy
*/
EntityBase {
    id: ship

    width: img.implicitWidth
    height: img.implicitHeight

    /*! This property specifies the url for the ship's avatar image. */
    property alias avatar: img.source

    /*! This signal is triggered when the ship collides with another entity.
        The other entity can be accessed via the \a collidedEntity parameter.
    */
    signal collided(var collidedEntity)

    /*! Replaces the ship with an explosion animation. */
    function explode() {
        var explosionProperties = {
            x: ship.x + ship.width / 2 - 32,
            y: ship.y + ship.height / 2 - 32,
            rotation: 0
        };

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("Explosion.qml"),
                    explosionProperties);

        ship.removeEntity();
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
            collided(collidedEntity);
        }
    }
}

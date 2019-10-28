import QtQuick 2.0
import Felgo 3.0

//
// Player ship entity. Movement is controled by mouse input in the game scene.
// The ship can fire projectiles rapidly - controlled by the firing property.
//
EntityBase {
    id: player
    entityType: "player"
    width: img.implicitWidth
    height: img.implicitHeight

    property bool firing: false

    // Moves the player ship to given position and changes the firing state.
    function move(x, y, firing) {
        player.x = x - player.width / 2
        player.y = y - player.height / 2
        player.firing = firing
    }

    // Replaces the player ship with an explosion animation.
    function explode() {
        createExplosion(player.x + player.width / 2,
                        player.y + player.height / 2)
        player.removeEntity()
    }

    Behavior on x { SmoothedAnimation { velocity: 300 } }
    Behavior on y { SmoothedAnimation { velocity: 300 } }

    Image {
        id: img
        source: "../assets/ships/ufo.png"
    }

    BoxCollider {
        id: collider
        anchors.fill: img
        anchors.margins: 5
        collisionTestingOnlyMode: true
    }

    Timer {
        repeat: true
        interval: 150
        running: player.firing
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

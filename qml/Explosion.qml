import QtQuick 2.0
import Felgo 3.0

//
// An explosion animation.
//
EntityBase {
    id: explosion
    entityType: "explosion"
    width: 64
    height: 64

    SpriteSequence {
        anchors.centerIn: parent

        Sprite {
            id: sprite
            name: "explosion"
            frameCount: 25
            frameDuration: 30
            frameWidth: 64
            frameHeight: 64
            source: "../assets/effects/explosion.png"
        }
    }

    Timer {
        interval: sprite.frameCount * sprite.frameDuration
        running: true
        onTriggered: {
            explosion.removeEntity()
        }
    }
}

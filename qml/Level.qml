import Felgo 3.0
import QtQuick 2.0

Item {
    id: level

    ParallaxScrollingBackground {
        anchors.fill: parent

        sourceImage: "../assets/background/desert.png"
        movementVelocity: Qt.point(-50, 0)
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 25

        color: "white"
        font.pointSize: 12
        font.bold: true

        text: "Score: " + gameScene.score
    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            player.move(mouse.x, mouse.y, true)
        }

        onPositionChanged: {
            player.move(mouse.x, mouse.y, true)
        }

        onReleased: {
            player.move(mouse.x, mouse.y, false)
        }
    }

    //TODO: generate enemy entities dynamically
    //TODO: add victory condition

    Player {
        id: player
    }

    Plane {
        x: 1200
        y: 200
    }

    Plane {
        x: 1400
        y: 250
    }

    Plane {
        x: 1600
        y: 300
    }

    Scout {
        x: 2000
        y: 100
    }

    Turbo {
        x: 2500
        y: 300
        firing: true
    }
}

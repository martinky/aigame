import Felgo 3.0
import QtQuick 2.0
import"../entities"

/*!
    \brief This item holds the basic building blocks of a level.

    Contains basic building blocks of a level: the player entity,
    level background and enemy entities. Handles the input and controls the
    \l Player ship movements and actions.

    The \l levelFinished() signal is triggered once there are no more enemies
    alive.

    The background image, number, type and configuration of enemies comprise
    a specific level and are specified in a derived type.
*/
Item {
    id: level

    /*! Sets the url to the background image. */
    property alias backgroundImage: background.sourceImage

    /*! Name of the level that is shown at level beginning. */
    property alias introText: levelNameText.text

    /*! Code to enter the level directly from main menu. */
    property string levelCode: "XXXX"

    /*! This signal is triggered once all enemies are cleared: either destroyed
        or went past the left edge of the screen. */
    signal levelFinished()

    default property alias content: content.children

    Rectangle {
        id: intro
        anchors.fill: parent

        color: "black"
        opacity: 0

        Column {
            anchors.centerIn: parent
            spacing: 50

            Text {
                id: levelNameText
                anchors.horizontalCenter: parent.horizontalCenter

                color: "red"
                font.pixelSize: 36
                font.bold: true
            }

            Text {
                id: levelCodeText

                anchors.horizontalCenter: parent.horizontalCenter

                color: "red"
                font.pixelSize: 24
                font.bold: true

                text: "CODE: " + level.levelCode
            }
        }

    }

    Item {
        id: content
        anchors.fill: parent

        opacity: 0
        enabled: false // prevent player input until intro finished

        ParallaxScrollingBackground {
            id: background
            anchors.fill: parent

            movementVelocity: Qt.point(-50, 0)
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                player.move(mouse.x, mouse.y, true);
            }

            onPositionChanged: {
                player.move(mouse.x, mouse.y, true);
            }

            onReleased: {
                player.move(mouse.x, mouse.y, false);
            }
        }

        Player {
            id: player
            x: 20
            y: 200
        }
    }

    SequentialAnimation {
        id: introAnimation
        NumberAnimation { target: intro;   property: "opacity"; to: 1; duration: 500 }
        PauseAnimation  { duration: 2000 }
        NumberAnimation { target: intro;   property: "opacity"; to: 0; duration: 500 }
        NumberAnimation { target: content; property: "opacity"; to: 1; duration: 500 }
        onStopped: content.enabled = true
    }

    NumberAnimation {
        id: outroAnimation
        target: content; property: "opacity"; to: 0; duration: 500
        onStopped: levelFinished()
    }

    // This timer checks every 1 second if there are any remaining enemies
    // in the level and triggers the levelFinished() signal if there are none.
    Timer {
        id: finishTestTimer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            var enemies = entityManager.getEntityArrayByType("enemy");
            if (enemies.length === 0) {
                finishTestTimer.running = false;
                outroAnimation.start();
            }
        }
    }

    Component.onCompleted: introAnimation.start()
}

import Felgo 3.0
import QtQuick 2.0

//
// Enemy that makes a wawy vertical motion.
//
Enemy {
    id: scout
    avatar: "../assets/ships/scout.png"
    score: 150

    property real verticalRange: 150
    property real verticalVelocity: 100

    Behavior on y { SmoothedAnimation { velocity: verticalVelocity } }

    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        PauseAnimation { duration: 1500 }
        ScriptAction { script: { scout.y = scout.y + verticalRange } }
        PauseAnimation { duration: 1500 }
        ScriptAction { script: { scout.y = scout.y - verticalRange } }
    }
}

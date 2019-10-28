import Felgo 3.0
import QtQuick 2.0

//
// Enemy that makes a wawy vertical motion.
//
Enemy {
    id: scout
    avatar: "../assets/ships/scout.png"
    score: 150

    Behavior on y { SmoothedAnimation { velocity: 100 } }

    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        PauseAnimation { duration: 1500 }
        ScriptAction { script: { scout.y = scout.y + 150 } }
        PauseAnimation { duration: 1500 }
        ScriptAction { script: { scout.y = scout.y - 150 } }
    }
}

import Felgo 3.0
import QtQuick 2.0

/*!
    \inherits Enemy
    \brief An \l Enemy that makes a wawy vertical motion.
*/
Enemy {
    id: scout
    avatar: "../../assets/ships/scout.png"
    score: 150

    /*! Specifies the vertical range of motion in pixels. */
    property real verticalRange: 150
    /*! Specifies the maximum vertical velocity in pixels per second. */
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

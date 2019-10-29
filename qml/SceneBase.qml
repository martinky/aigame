import Felgo 3.0
import QtQuick 2.0

//
// Base scene. The NumberAnimation on opacity provides a cross-fade effect
// when switching scenes.
//
Scene {

    opacity: 0

    // scale of the original game
    width: 800
    height: 480

    Behavior on opacity {
        NumberAnimation {
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }
}

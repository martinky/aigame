import Felgo 3.0
import QtQuick 2.0

/*!
    \brief Base scene.

    Provides common behavior for all scenes - a cross-fade effect when scenes
    are being switched.
*/
Scene {

    // initially invisible, the visible scene is set by the state machine in Main.qml
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

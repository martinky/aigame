import Felgo 3.0
import QtQuick 2.0

//
// Scene that hosts the gameplay.
//
SceneBase {
    property int score: 0

    function reset() {
        score = 0
        entityManager.removeAllEntities()
        levelLoader.source = ""
        levelLoader.source = "Level.qml"
    }

    PhysicsWorld {
        //debugDrawVisible: true
        z: 1000
    }

    Loader {
        id: levelLoader
        anchors.fill: parent
        source: "Level.qml"
    }
}

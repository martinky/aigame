import Felgo 3.0
import QtQuick 2.0
import "../entities"

Level {
    id: level

    backgroundImage: "../../assets/background/canyon.png"
    introSound: "../../assets/sounds/level_intro2.wav"
    introText: "Area 51, Groom Lake, Nevada, 1960"

    // enemies in this level

    Plane { x: 1200; y: 200 }
    Plane { x: 1400; y: 250 }
    Plane { x: 1600; y: 300 }

    Scout { x: 2000; y: 100 }

    Turbo { x: 2500; y: 300; firing: true }
}

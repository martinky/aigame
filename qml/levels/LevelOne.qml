import Felgo 3.0
import QtQuick 2.0
import "../entities"

Level {
    id: level

    backgroundImage: "../../assets/background/desert.png"
    introText: "New Mexico, 1957"

    // enemies in this level

    Plane { x: 1000; y: 100 }
    Plane { x: 1200; y: 150 }
    Plane { x: 1400; y: 200 }

    Turbo { x: 2000; y: 200 }
    Turbo { x: 2100; y: 150 }
    Turbo { x: 2200; y: 250 }

    Scout { x: 2500; y: 100 }
    Scout { x: 2600; y: 150 }
    Scout { x: 2700; y: 50 }
}

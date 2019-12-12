import QtQuick 2.0
import Felgo 3.0
import "../components"

/*!
    \brief Main menu.
*/
SceneBase {

    signal startGame
    signal goToLevel(string code)
    signal quit

    Column {
        anchors.centerIn: parent
        spacing: dp(15)

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            color: "red"
            font.pixelSize: 36
            font.bold: true

            text: "ALIEN INVASION!"
        }

        Item {
            width: 10
            height: 30
        }

        MenuButton {
            anchors.horizontalCenter: parent.horizontalCenter

            text: "NEW GAME!"

            onClicked: {
                soundButton.play();
                startGame();
            }
        }

        MenuButton {
            id: codeInputBtn
            anchors.horizontalCenter: parent.horizontalCenter

            text: "ENTER CODE"

            onClicked: {
                soundButton.play();
                codeInputItem.visible = true;
                codeInputBtn.visible = false;
                codeInputText.text = "";
                codeInputText.focus = true;
            }
        }

        Row {
            id: codeInputItem
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: dp(15)
            visible: false
//            Text {
//                anchors.verticalCenter: parent.verticalCenter
//                color: "red"
//                font.pixelSize: 16
//                font.bold: true
//                text: "CODE:"
//            }
            Rectangle {
                border.color: "red"
                border.width: dp(1)
                radius: dp(4)
                color: "black"
                width: dp(100)
                height: dp(24)
                TextInput {
                    id: codeInputText
                    anchors.centerIn: parent
                    anchors.margins: dp(2)

                    color: "red"
                    font.pixelSize: 16
                    font.bold: true

                    //borderColor: "red"
                    //
                }
            }

            MenuButton {
                text: "GO"
                onClicked: {
                    soundButton.play();
                    codeInputItem.visible = false;
                    codeInputBtn.visible = true;
                    goToLevel(codeInputText.text.toUpperCase());
                }
            }
        }

        MenuButton {
            anchors.horizontalCenter: parent.horizontalCenter

            text: "HIGH SCORE"

            enabled: false
        }

        MenuButton {
            anchors.horizontalCenter: parent.horizontalCenter

            text: "QUIT"

            onClicked: {
                soundButton.play();
                quit();
            }
        }
    }


    SoundEffect {
        id: soundButton
        source: "../../assets/sounds/beep.wav"
    }

}

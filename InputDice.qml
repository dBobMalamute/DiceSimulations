import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle
{
    id: controlsArea
    width: 270
    height: 740
    gradient: Gradient
    {
        GradientStop{position: 0.05; color: "#0b0b19"}
        GradientStop{position: 0.5; color: "#382200"}
        GradientStop{position: 0.95; color: "#0b0b19"}
    }

    Row
    {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 5
        spacing: 5
        Image
        {
            source: "qrc:/DiceImages/6Sides1.png"
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    inputModel.addDie(1);
                }
            }
        }
        Image
        {
            source: "qrc:/DiceImages/6Sides2.png"
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    inputModel.addDie(2);
                }
            }
        }
        Image
        {
            source: "qrc:/DiceImages/6Sides3.png"
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    inputModel.addDie(3);
                }
            }
        }
        Image
        {
            source: "qrc:/DiceImages/6Sides4.png"
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    inputModel.addDie(4);
                }
            }
        }
        Image
        {
            source: "qrc:/DiceImages/6Sides5.png"
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    inputModel.addDie(5);
                }
            }
        }
        Image
        {
            source: "qrc:/DiceImages/6Sides6.png"
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    inputModel.addDie(6);
                }
            }
        }
    }

    Row
    {
        id: inputControlsRow
        anchors.horizontalCenter: parent.horizontalCenter
        y: 60;
        spacing: 10

        property int diceToRoll: 1

        Rectangle
        {
            width: 100
            height: 40
            color: "#4a99b5"
            radius: 10
            Text
            {
                anchors.centerIn: parent
                text: "Roll"
                font.pointSize: 16
                font.bold: true;
                color: "#1a1a1a"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    inputModel.rollDice(inputControlsRow.diceToRoll)
                }
            }
        }
        ComboBox
        {
            width: 130
            y: 6
            font.pointSize: 16
            font.bold: true;
            model: [ "x1", "x6", "x36" ]
            onCurrentIndexChanged:
            {
                if(currentIndex == 0)
                    inputControlsRow.diceToRoll = 1;
                else if(currentIndex == 1)
                    inputControlsRow.diceToRoll = 6;
                else
                    inputControlsRow.diceToRoll = 36;
            }
            background: Rectangle
            {
                width: parent.width
                height: 40
                y: -6
                color: "#4a99b5"
                radius: 10
            }
        }
    }

    GridView
    {
        model: inputModel;
        anchors.top: inputControlsRow.bottom
        anchors.topMargin: 20
        x: 10
        width: parent.width
        height: 500
        cellHeight: 42
        cellWidth: 42

        delegate: Image
        {
            width: 40
            height: 40
            opacity: model.used ? 1.0 : 0.3
            Component.onCompleted:
            {
                switch(model.value)
                {
                case 1:
                    source = "qrc:/DiceImages/6Sides1.png";
                    break;
                case 2:
                    source = "qrc:/DiceImages/6Sides2.png";
                    break;
                case 3:
                    source = "qrc:/DiceImages/6Sides3.png";
                    break;
                case 4:
                    source = "qrc:/DiceImages/6Sides4.png";
                    break;
                case 5:
                    source = "qrc:/DiceImages/6Sides5.png";
                    break;
                case 6:
                    source = "qrc:/DiceImages/6Sides6.png";
                    break;
                }
            }
        }
    }

    Row
    {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        Rectangle
        {
            width: 100
            height: 40
            color: "#4a99b5"
            radius: 10
            Text
            {
                anchors.centerIn: parent
                text: "Clear"
                font.pointSize: 16
                font.bold: true;
                color: "#1a1a1a"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    inputModel.clearDice();
                }
            }
        }
        Rectangle
        {
            width: 120
            height: 40
            color: "#86b2c2"
            radius: 6
            Text
            {
                anchors.centerIn: parent
                text: "Total: " + inputModel.totalDice;
                font.pointSize: 16
                font.bold: true;
                color: "#1a1a1a"
            }
        }


    }
}

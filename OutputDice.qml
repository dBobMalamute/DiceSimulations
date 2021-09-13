import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle
{
    id: displayArea
    width: 180

    gradient: Gradient
    {
        GradientStop{position: 0.05; color: "black"}
        GradientStop{position: 0.5; color: "#1b0423"}
        GradientStop{position: 0.95; color: "black"}
    }

    GridView
    {
        model: outputModel;
        y: 5
        x: 2
        width: parent.width
        height: 300
        cellHeight: 42
        cellWidth: 42

        delegate: Image
        {
            id: image
            width: 40
            height: 40
            opacity: 0.01;
            Component.onCompleted:
            {
                switch(model.value)
                {
                case 1:
                    source = "qrc:/DiceImages/8Sides1.png";
                    break;
                case 2:
                    source = "qrc:/DiceImages/8Sides2.png";
                    break;
                case 3:
                    source = "qrc:/DiceImages/8Sides3.png";
                    break;
                case 4:
                    source = "qrc:/DiceImages/8Sides4.png";
                    break;
                case 5:
                    source = "qrc:/DiceImages/8Sides5.png";
                    break;
                case 6:
                    source = "qrc:/DiceImages/8Sides6.png";
                    break;
                case 7:
                    source = "qrc:/DiceImages/8Sides7.png";
                    break;
                case 8:
                    source = "qrc:/DiceImages/8Sides8.png";
                    break;
                }
                animation.start();
            }
            SequentialAnimation
            {
                id: animation
                PauseAnimation
                {
                    duration: 2500
                }
                PropertyAction
                {
                    target: image
                    property: "opacity"
                    value: 1.0
                }
            }
        }
    }

    Rectangle
    {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        width: 120
        height: 40
        color: "#86b2c2"
        radius: 6
        Text
        {
            anchors.centerIn: parent
            text: "Total: " + outputModel.totalDice;
            font.pointSize: 16
            font.bold: true;
            color: "#1a1a1a"
        }
    }
}

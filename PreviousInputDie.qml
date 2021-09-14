import QtQuick 2.12

Rectangle
{
    id: previousInputDie
    height: 720
    width: 60
    gradient: Gradient
    {
        GradientStop{id: gradientTop; position: 0.0; color: "#84451b"}
        GradientStop{id: gradientMid; position: 0.5; color: "#b05c24"}
        GradientStop{id: gradientBot; position: 1.0; color: "#84451b"}
    }

    property int nextValue: 0

    Rectangle
    {
        anchors.top: parent.top
        height: 1
        width: parent.width
        color: "black"
    }

    Image
    {
        id: previousInputDieImage;
        source: ""
        anchors.centerIn: parent
        opacity: 1.0

        SequentialAnimation
        {
            id: animation

            NumberAnimation
            {
                target: previousInputDie
                property: "opacity"
                to: 0.01
                duration: 500
            }

            PauseAnimation
            {
                duration: 4000
            }
            ScriptAction
            {
                script: setSource();
            }
            PropertyAction
            {
                target: previousInputDie
                property: "opacity"
                value: 1.0
            }
        }
    }
    function animate()
    {
        animation.start();
    }

    function setSource()
    {
        switch(nextValue)
        {
        case 0:
            previousInputDieImage.source = "";
            break;
        case 1:
            previousInputDieImage.source = "DiceImages/6Sides1.png"
            break;
        case 2:
            previousInputDieImage.source = "DiceImages/6Sides2.png"
            break;
        case 3:
            previousInputDieImage.source = "DiceImages/6Sides3.png"
            break;
        case 4:
            previousInputDieImage.source = "DiceImages/6Sides4.png"
            break;
        case 5:
            previousInputDieImage.source = "DiceImages/6Sides5.png"
            break;
        case 6:
            previousInputDieImage.source = "DiceImages/6Sides6.png"
            break;
        }
    }

    Rectangle
    {
        anchors.bottom: parent.bottom
        height: 1
        width: parent.width
        color: "black"
    }
}

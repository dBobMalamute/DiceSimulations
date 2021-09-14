import QtQuick 2.0

Item
{
    id: root
    width: 42
    height: 42

    y: 163
    z: 100
    x: 10

    property int finalY: 0

    Image
    {
        id: image
        anchors.centerIn: parent
    }

    function setValue(value)
    {
        finalY = 120*(value-1) + 40;
        switch(value)
        {
        case 1:
            image.source = "qrc:/DiceImages/6Sides1.png";
            break;
        case 2:
            image.source = "qrc:/DiceImages/6Sides2.png";
            break;
        case 3:
            image.source = "qrc:/DiceImages/6Sides3.png";
            break;
        case 4:
            image.source = "qrc:/DiceImages/6Sides4.png";
            break;
        case 5:
            image.source = "qrc:/DiceImages/6Sides5.png";
            break;
        case 6:
            image.source = "qrc:/DiceImages/6Sides6.png";
            break;
        }
        animation.start();
    }

    SequentialAnimation
    {
        id: animation
        PauseAnimation
        {
            duration: 200
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "x"
                to: 416
                duration: 800
                easing.type: Easing.Linear

            }
            NumberAnimation
            {
                target: root
                property: "y"
                to: finalY
                duration: 800
                easing.type: Easing.InQuad
            }
        }
        PauseAnimation
        {
            duration: 200
        }

        ScriptAction
        {
            script: root.destroy();
        }
    }
}

import QtQuick 2.0

Item
{
    id: root
    width: 42
    height: 42

    y: 113
    z: 100
    x: 588

    property int finalY: 20
    property int finalX: 759

    Image
    {
        id: image
        anchors.centerIn: parent
    }

    function setValue(value)
    {
        switch(value)
        {
        case 1:
            image.source = "qrc:/DiceImages/8Sides1.png";
            break;
        case 2:
            image.source = "qrc:/DiceImages/8Sides2.png";
            break;
        case 3:
            image.source = "qrc:/DiceImages/8Sides3.png";
            break;
        case 4:
            image.source = "qrc:/DiceImages/8Sides4.png";
            break;
        case 5:
            image.source = "qrc:/DiceImages/8Sides5.png";
            break;
        case 6:
            image.source = "qrc:/DiceImages/8Sides6.png";
            break;
        case 7:
            image.source = "qrc:/DiceImages/8Sides7.png";
            break;
        case 8:
            image.source = "qrc:/DiceImages/8Sides8.png";
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
                to: finalX
                duration: 2000
                easing.type: Easing.Linear

            }
            NumberAnimation
            {
                target: root
                property: "y"
                to: finalY
                duration: 2000
                easing.type: Easing.InQuad
            }
        }
        PauseAnimation
        {
            duration: 2000
        }

        ScriptAction
        {
            script: root.destroy();
        }
    }
}

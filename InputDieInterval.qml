import QtQuick 2.0


Rectangle
{
    id: root
    height: 120
    color: "teal"
    width: 60
    x: 62

    states:
        [
        State {
            name: "NotChoosen"
            PropertyChanges
            {
                target: gradientTop
                color: "#1a1a1a"
            }
            PropertyChanges
            {
                target: gradientMid
                color: "#666666"
            }
            PropertyChanges
            {
                target: gradientBot
                color: "#1a1a1a"
            }
        },
        State {
            name: "Choosen"
            PropertyChanges
            {
                target: gradientTop
                color: "#84451b"
            }
            PropertyChanges
            {
                target: gradientMid
                color: "#b05c24"
            }
            PropertyChanges
            {
                target: gradientBot
                color: "#84451b"
            }
        }
    ]

    gradient: Gradient
    {
        GradientStop{id: gradientTop; position: 0.0; color: "#1a1a1a"}
        GradientStop{id: gradientMid; position: 0.5; color: "#666666"}
        GradientStop{id: gradientBot; position: 1.0; color: "#1a1a1a"}
    }

    property alias source: image.source
    property int dieValue: 0;
    property int valueForZoom: 0;
    property int nextDieValue: 0;
    property int nextIntervalHeight: 20
    property double nextIntervalOpacity: 0.0;

    Rectangle
    {
        anchors.top: parent.top
        height: 1
        width: parent.width
        color: "black"
    }

    Image
    {
        id: image
        y: 40;
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0.6
    }

    Rectangle
    {
        anchors.bottom: parent.bottom
        height: 1
        width: parent.width
        color: "black"
    }

    InputDieNextInterval
    {
        id: inputNextInterval1
        anchors.left: parent.right
        height: nextIntervalHeight
        opacity: nextIntervalOpacity
        anchors.leftMargin: 2;
        source: "qrc:/DiceImages/6Sides1.png"
    }
    InputDieNextInterval
    {
        id: inputNextInterval2
        y: nextIntervalHeight
        height: nextIntervalHeight
        opacity: nextIntervalOpacity
        anchors.left: parent.right
        anchors.leftMargin: 2;
        source: "qrc:/DiceImages/6Sides2.png"
    }
    InputDieNextInterval
    {
        id: inputNextInterval3
        y: 2*nextIntervalHeight
        height: nextIntervalHeight
        opacity: nextIntervalOpacity
        anchors.left: parent.right
        anchors.leftMargin: 2;
        source: "qrc:/DiceImages/6Sides3.png"
    }
    InputDieNextInterval
    {
        id: inputNextInterval4
        y: 3*nextIntervalHeight
        height: nextIntervalHeight
        opacity: nextIntervalOpacity
        anchors.left: parent.right
        anchors.leftMargin: 2;
        source: "qrc:/DiceImages/6Sides4.png"
    }
    InputDieNextInterval
    {
        id: inputNextInterval5
        y: 4*nextIntervalHeight
        height: nextIntervalHeight
        opacity: nextIntervalOpacity
        anchors.left: parent.right
        anchors.leftMargin: 2;
        source: "qrc:/DiceImages/6Sides5.png"
    }
    InputDieNextInterval
    {
        id: inputNextInterval6
        y: 5*nextIntervalHeight
        height: nextIntervalHeight
        opacity: nextIntervalOpacity
        anchors.left: parent.right
        anchors.leftMargin: 2;
        source: "qrc:/DiceImages/6Sides6.png"
    }

    function startZoomInAnimation(lastValue, thisValue)
    {
        valueForZoom = lastValue;
        nextDieValue = thisValue;
        if(image.opacity == 1.0)
            showAdditionalDieUsed(thisValue);
        zoomInAnimation.start();
    }

    function showFirstDieUsed(value)
    {
        if(dieValue === value)
        {
            image.opacity = 1.0;
            root.state = "Choosen"
        }
        else
        {
            image.opacity = 0.6;
            root.state = "NotChoosen"
        }
        showDieUsedAnimation.start();
    }

    function reset()
    {
        root.state = "NotChoosen"
        y = 120 * (dieValue - 1)
        x = 62;
        height = 120;
        image.opacity = 0.6;
        image.y = 40;
        nextIntervalHeight = 20;
        nextIntervalOpacity = 0.5;
    }

    function finishAnimation()
    {
        y = 120 * (dieValue - 1)
        x = 62;
        height = 120;
        if(dieValue === nextDieValue)
        {
            image.opacity = 1.0;
            state = "Choosen"
        }
        else
        {
            image.opacity = 0.6;
            state = "NotChoosen"
        }
        image.y = 40;
        nextIntervalHeight = 20;
        nextIntervalOpacity = 0.0;
        resetAdditionalDieUsed();
    }

    function showAdditionalDieUsed(value)
    {
        switch(value)
        {
        case 1:
            inputNextInterval1.imageOpacity = 1.0;
            inputNextInterval1.state = "Choosen"
            break;
        case 2:
            inputNextInterval2.imageOpacity = 1.0;
            inputNextInterval2.state = "Choosen"
            break;
        case 3:
            inputNextInterval3.imageOpacity = 1.0;
            inputNextInterval3.state = "Choosen"
            break;
        case 4:
            inputNextInterval4.imageOpacity = 1.0;
            inputNextInterval4.state = "Choosen"
            break;
        case 5:
            inputNextInterval5.imageOpacity = 1.0;
            inputNextInterval5.state = "Choosen"
            break;
        case 6:
            inputNextInterval6.imageOpacity = 1.0;
            inputNextInterval6.state = "Choosen"
            break;
        }
    }
    function resetAdditionalDieUsed()
    {
        inputNextInterval1.imageOpacity = 0.6;
        inputNextInterval2.imageOpacity = 0.6;
        inputNextInterval3.imageOpacity = 0.6;
        inputNextInterval4.imageOpacity = 0.6;
        inputNextInterval5.imageOpacity = 0.6;
        inputNextInterval6.imageOpacity = 0.6;
        inputNextInterval1.state = "NotChoosen"
        inputNextInterval2.state = "NotChoosen"
        inputNextInterval3.state = "NotChoosen"
        inputNextInterval4.state = "NotChoosen"
        inputNextInterval5.state = "NotChoosen"
        inputNextInterval6.state = "NotChoosen"
    }

    SequentialAnimation
    {
        id: showDieUsedAnimation
        NumberAnimation
        {
            target: root
            property: "nextIntervalOpacity"
            duration: 1000
            to: 0.5
        }
    }

    SequentialAnimation
    {
        id: zoomInAnimation;
        NumberAnimation
        {
            target: root
            property: "nextIntervalOpacity"
            duration: 2000
            to: 1.0
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "height"
                to: 2000
                duration: 1500
            }
            NumberAnimation
            {
                target: root
                property: "y"
                duration: 1500
                to: (root.y - (valueForZoom - 1) * 120) * 6;
            }
            NumberAnimation
            {
                target: image
                property: "y"
                duration: 1500
                to: 340
            }
            NumberAnimation
            {
                target: root
                property: "nextIntervalHeight"
                duration: 1500
                to: 120
            }
        }
        PauseAnimation
        {
            duration: 300
        }

        NumberAnimation
        {
            target: root
            property: "x"
            duration: 700
            to: 0
        }

        ScriptAction
        {
            script: finishAnimation();
        }
        NumberAnimation
        {
            target: root
            property: "nextIntervalOpacity"
            duration: 1000
            to: 0.3
        }
    }
}

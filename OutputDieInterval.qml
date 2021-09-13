import QtQuick 2.0

import "DieConversionFunctions.js" as DieConversionFunctions

Item
{
    id: root;
    height: 90;
    width: 60

    Rectangle
    {
        id: visibleRootFillingRectangle
        anchors.fill: parent
        states:
            [
            State {
                name: "NotChoosen"
                PropertyChanges
                {
                    target: gradientTop
                    color: "#042323"
                }
                PropertyChanges
                {
                    target: gradientMid
                    color: "#056767"
                }
                PropertyChanges
                {
                    target: gradientBot
                    color: "#042323"
                }
            },
            State {
                name: "Choosen"
                PropertyChanges
                {
                    target: gradientTop
                    color: "#1b0423"
                }
                PropertyChanges
                {
                    target: gradientMid
                    color: "#4d0567"
                }
                PropertyChanges
                {
                    target: gradientBot
                    color: "#1b0423"
                }
            }
        ]

        gradient: Gradient
        {
            GradientStop{id: gradientTop; position: 0.0; color: "#042323"}
            GradientStop{id: gradientMid; position: 0.5; color: "#056767"}
            GradientStop{id: gradientBot; position: 1.0; color: "#042323"}
        }
    }

    property alias source: image.source
    property int dieValue: 0;

    property double yFinal: 0
    property double heightFinal: 0
    property double nextIntervalOpacity: 1.0;

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
        width: Math.min(40, parent.height / 1.5)
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height/2 - height/2;
        opacity: 0.6
    }

    Rectangle
    {
        anchors.bottom: parent.bottom
        height: 1
        width: parent.width
        color: "black"
    }

    OutputDieNextInterval
    {
        anchors.top: parent.top
        height: parent.height / 8;
        anchors.left: parent.right
        anchors.leftMargin: 2
        opacity: nextIntervalOpacity
        source: "qrc:/DiceImages/8Sides1.png"
    }

    OutputDieNextInterval
    {
        anchors.top: parent.top
        anchors.topMargin: parent.height / 8
        height: parent.height / 8;
        anchors.left: parent.right
        anchors.leftMargin: 2
        opacity: nextIntervalOpacity
        source: "qrc:/DiceImages/8Sides2.png"
    }
    OutputDieNextInterval
    {
        anchors.top: parent.top
        anchors.topMargin: parent.height / 4
        height: parent.height / 8;
        anchors.left: parent.right
        anchors.leftMargin: 2
        opacity: nextIntervalOpacity
        source: "qrc:/DiceImages/8Sides3.png"
    }
    OutputDieNextInterval
    {
        anchors.top: parent.top
        anchors.topMargin: parent.height *3 / 8
        height: parent.height / 8;
        anchors.left: parent.right
        anchors.leftMargin: 2
        opacity: nextIntervalOpacity
        source: "qrc:/DiceImages/8Sides4.png"
    }
    OutputDieNextInterval
    {
        anchors.top: parent.top
        anchors.topMargin: parent.height / 2
        height: parent.height / 8;
        anchors.left: parent.right
        anchors.leftMargin: 2
        opacity: nextIntervalOpacity
        source: "qrc:/DiceImages/8Sides5.png"
    }
    OutputDieNextInterval
    {
        anchors.top: parent.top
        anchors.topMargin: parent.height *5/8
        height: parent.height / 8;
        anchors.left: parent.right
        anchors.leftMargin: 2
        opacity: nextIntervalOpacity
        source: "qrc:/DiceImages/8Sides6.png"
    }
    OutputDieNextInterval
    {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 8;
        height: parent.height / 8;
        anchors.left: parent.right
        anchors.leftMargin: 2
        opacity: nextIntervalOpacity
        source: "qrc:/DiceImages/8Sides7.png"
    }
    OutputDieNextInterval
    {
        anchors.bottom: parent.bottom
        height: parent.height / 8;
        anchors.left: parent.right
        anchors.leftMargin: 2
        opacity: nextIntervalOpacity
        source: "qrc:/DiceImages/8Sides8.png"
    }


    function reset()
    {
        height = 90;
        y = (dieValue - 1) * 90
    }

    function startZoomInAnimation(intervalTop, intervalBottom)
    {
        heightFinal = (intervalBottom - intervalTop) / 8.0;

        yFinal = intervalTop + (dieValue - 1) * heightFinal
        zoomInAnimation.start();
    }

    function startZoomOutAnimation(newDieValue, intervalTop, intervalBottom)
    {
        if(dieValue === newDieValue)
        {
            DieConversionFunctions.startOutputDieAnimation(root.y + image.y, dieValue);
            image.opacity = 0.0;
            visibleRootFillingRectangle.state = "Choosen";
        }

        heightFinal = (intervalBottom - intervalTop) / 8.0;

        yFinal = intervalTop + (dieValue - 1) * heightFinal
        shrinkoutAnimation.start();
    }

    SequentialAnimation
    {
        id: zoomInAnimation

        PauseAnimation
        {
            duration: 2000
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "height"
                to: heightFinal
                duration: 1500
            }
            NumberAnimation
            {
                target: root
                property: "y"
                to: yFinal
                duration: 1500
            }
        }
    }

    SequentialAnimation
    {
        id: shrinkoutAnimation
        PauseAnimation
        {
            duration: 2000
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "x"
                to: -62
                duration: 1000
            }
            NumberAnimation
            {
                target: visibleRootFillingRectangle
                property: "opacity"
                to: 0.0
                duration: 1000
            }
            NumberAnimation
            {
                target: image
                property: "opacity"
                to: 0.0
                duration: 1000
            }
        }
        PropertyAction
        {
            target: root
            property: "nextIntervalOpacity"
            value: 0.0;
        }
        PropertyAction
        {
            target: image
            property: "opacity"
            value: 0.6
        }

        PropertyAction
        {
            target: root
            property: "height"
            value: heightFinal
        }
        PropertyAction
        {
            target: root
            property: "y"
            value: yFinal
        }
        PropertyAction
        {
            target: visibleRootFillingRectangle
            property: "state"
            value: "NotChoosen"
        }

        PropertyAction
        {
            target: root
            property: "x"
            value: 0
        }
        PropertyAction
        {
            target: visibleRootFillingRectangle
            property: "opacity"
            value: 1.0
        }
        NumberAnimation
        {
            target: root
            property: "nextIntervalOpacity"
            duration: 2000
            to: 1.0;
        }
    }
}

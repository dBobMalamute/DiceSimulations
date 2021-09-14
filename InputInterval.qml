import QtQuick 2.0
import QtQuick.Shapes 1.12

Item
{
    id: root
    width: 500;
    height: 720;
    clip: true;

    property int inputIntervalTop : 0;
    property int inputIntervalBottom : 720;

    property int inputIntervalTopSubGoal: 0;
    property int inputIntervalBottomSubGoal: 0;

    property int inputIntervalTopGoal: 0;
    property int inputIntervalBottomGoal: 0;

    function reset()
    {
        inputIntervalTopGoal = 0;
        inputIntervalBottomGoal = 720;
        firstDieAnimation.stop();
        additionalDieAnimation.stop();
        resetAnimation.start();
    }

    SequentialAnimation
    {
        id: resetAnimation
        PauseAnimation
        {
            duration: 200
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "inputIntervalTop"
                to: inputIntervalTopGoal
                duration: 700
            }
            NumberAnimation
            {
                target: root
                property: "inputIntervalBottom"
                to: inputIntervalBottomGoal
                duration: 700
            }
        }
    }

    function firstDie(value)
    {
        inputIntervalTopGoal = 120*(value - 1)
        inputIntervalBottomGoal = 120*value;
        firstDieAnimation.start();
    }

    SequentialAnimation
    {
        id: firstDieAnimation
        PauseAnimation
        {
            duration: 1200
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "inputIntervalTop"
                to: inputIntervalTopGoal
                duration: 2000
            }
            NumberAnimation
            {
                target: root
                property: "inputIntervalBottom"
                to: inputIntervalBottomGoal
                duration: 2000
            }
        }
    }

    function additionalDie(value)
    {
        inputIntervalTopSubGoal = inputIntervalTopGoal + 20*(value - 1)
        inputIntervalBottomSubGoal = inputIntervalTopGoal + 20*value;
        inputIntervalTopGoal = 120*(value - 1)
        inputIntervalBottomGoal = 120*value;
        additionalDieAnimation.start();
    }

    SequentialAnimation
    {
        id: additionalDieAnimation
        PauseAnimation
        {
            duration: 1200
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "inputIntervalTop"
                to: inputIntervalTopSubGoal
                duration: 700
            }
            NumberAnimation
            {
                target: root
                property: "inputIntervalBottom"
                to: inputIntervalBottomSubGoal
                duration: 700
            }
        }
        PauseAnimation
        {
            duration: 100
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "inputIntervalTop"
                to: inputIntervalTopGoal
                duration: 1500
            }
            NumberAnimation
            {
                target: root
                property: "inputIntervalBottom"
                to: inputIntervalBottomGoal
                duration: 1500
            }
        }
    }

    Shape
    {
        anchors.fill: parent
        z: 10
        ShapePath
        {
            strokeColor: "#129d12"
            strokeWidth: 4
            strokeStyle: ShapePath.DashLine
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap;
            startX: 0
            startY: inputIntervalTop
            PathLine{x: 500; y: inputIntervalTop}
        }
        ShapePath
        {
            strokeColor: "#129d12"
            strokeWidth: 4
            strokeStyle: ShapePath.DashLine
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap;
            startX: 0
            startY: inputIntervalBottom

            PathLine{x: 500; y: inputIntervalBottom}
        }
    }

}

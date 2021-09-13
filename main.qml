import QtQuick 2.12
import QtQuick.Window 2.12

import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "DieConversionFunctions.js" as DieConversionFunctions

Window
{
    id: mainWindow
    width: 960
    height: 740
    visible: true
    title: qsTr("Dice Conversion")
    color: "black"

    InputDice
    {
        id: inputDice
    }

    Rectangle
    {
        id: conversionArea
        width: 360
        height: 720
        anchors.leftMargin: 75
        anchors.left: inputDice.right
        gradient: Gradient
        {
            GradientStop{position: 0.05; color: "black"}
            GradientStop{position: 0.5; color: "#252525"}
            GradientStop{position: 0.95; color: "black"}
        }

        PreviousInputDie
        {
            id: previousInputDie
        }

        Item
        {
            id: inputDieContainer
            x: 0
            width: 200
            height: 720;
            clip: true;
            Component.onCompleted:
            {
                DieConversionFunctions.createInputDice();
            }
        }

        InputInterval
        {
            id: inputInterval
            x: -70
            z: 10
        }

        Connections
        {
            target: DieConverter

            property int lastValue: 0

            function onShowFirstDieUsed(value)
            {
                inputInterval.firstDie(value)
                lastValue = value;
                DieConversionFunctions.showFirstDieUsed(value);
            }

            function onZoomIn(processedDice, value, intervalTop, intervalBottom)
            {
                DieConversionFunctions.startAdditionalDieAnimation(lastValue, value, processedDice);
                inputInterval.additionalDie(value)
                previousInputDie.nextValue = lastValue;
                DieConversionFunctions.zoomInOnDie(lastValue, value, 720 - 720*intervalTop, 720 - 720*intervalBottom);
                lastValue = value;
                previousInputDie.animate();

            }

            function onShrinkOutputInterval(newDieValue, intervalTop, intervalBottom)
            {
                DieConversionFunctions.shrinkOutputInterval(newDieValue,
                                                            (lastValue - intervalTop) / 6.0 * 720,
                                                            (lastValue - intervalBottom) / 6.0 * 720);
            }

            function onResetVisuals()
            {
                inputInterval.reset();

                previousInputDie.nextValue = 0.0;
                previousInputDie.setSource();
                DieConversionFunctions.resetDice();
            }
        }


        Item
        {
            id: outputDieContainer
            anchors.right: parent.right
            width: 122
            height: 720;
            clip: true;
            Component.onCompleted:
            {
                DieConversionFunctions.createOutputDice();
            }
        }
    }

    OutputDice
    {
        height: parent.height
        anchors.right: parent.right
    }
}

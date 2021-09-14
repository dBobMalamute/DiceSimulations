

function createInputDice()
{
    var inputDieComponent;
    var inputDieObject;



    inputDieComponent = Qt.createComponent("InputDieInterval.qml");
    inputDieObject = inputDieComponent.createObject(inputDieContainer,
                                                    {source: "qrc:/DiceImages/6Sides1.png",
                                                        y: 0, dieValue: 1})

    inputDieComponent = Qt.createComponent("InputDieInterval.qml");
    inputDieObject = inputDieComponent.createObject(inputDieContainer,
                                                    {source: "qrc:/DiceImages/6Sides2.png",
                                                        y: 120, dieValue: 2})

    inputDieComponent = Qt.createComponent("InputDieInterval.qml");
    inputDieObject = inputDieComponent.createObject(inputDieContainer,
                                                    {source: "qrc:/DiceImages/6Sides3.png",
                                                        y: 240, dieValue: 3})

    inputDieComponent = Qt.createComponent("InputDieInterval.qml");
    inputDieObject = inputDieComponent.createObject(inputDieContainer,
                                                    {source: "qrc:/DiceImages/6Sides4.png",
                                                        y: 360, dieValue: 4})

    inputDieComponent = Qt.createComponent("InputDieInterval.qml");
    inputDieObject = inputDieComponent.createObject(inputDieContainer,
                                                    {source: "qrc:/DiceImages/6Sides5.png",
                                                        y: 480, dieValue: 5})

    inputDieComponent = Qt.createComponent("InputDieInterval.qml");
    inputDieObject = inputDieComponent.createObject(inputDieContainer,
                                                    {source: "qrc:/DiceImages/6Sides6.png",
                                                        y: 600, dieValue: 6})
}

function createOutputDice()
{

    var outputDieComponent;
    var outputDieObject;

    outputDieComponent = Qt.createComponent("OutputDieInterval.qml");
    outputDieObject = outputDieComponent.createObject(outputDieContainer,
                                                      {source: "qrc:/DiceImages/8Sides1.png",
                                                          y: 0, dieValue: 1})

    outputDieComponent = Qt.createComponent("OutputDieInterval.qml");
    outputDieObject = outputDieComponent.createObject(outputDieContainer,
                                                      {source: "qrc:/DiceImages/8Sides2.png",
                                                          y: 90, dieValue: 2})

    outputDieComponent = Qt.createComponent("OutputDieInterval.qml");
    outputDieObject = outputDieComponent.createObject(outputDieContainer,
                                                      {source: "qrc:/DiceImages/8Sides3.png",
                                                          y: 180, dieValue: 3})

    outputDieComponent = Qt.createComponent("OutputDieInterval.qml");
    outputDieObject = outputDieComponent.createObject(outputDieContainer,
                                                      {source: "qrc:/DiceImages/8Sides4.png",
                                                          y: 270, dieValue: 4})

    outputDieComponent = Qt.createComponent("OutputDieInterval.qml");
    outputDieObject = outputDieComponent.createObject(outputDieContainer,
                                                      {source: "qrc:/DiceImages/8Sides5.png",
                                                          y: 360, dieValue: 5})

    outputDieComponent = Qt.createComponent("OutputDieInterval.qml");
    outputDieObject = outputDieComponent.createObject(outputDieContainer,
                                                      {source: "qrc:/DiceImages/8Sides6.png",
                                                          y: 450, dieValue: 6})

    outputDieComponent = Qt.createComponent("OutputDieInterval.qml");
    outputDieObject = outputDieComponent.createObject(outputDieContainer,
                                                      {source: "qrc:/DiceImages/8Sides7.png",
                                                          y: 540, dieValue: 7})

    outputDieComponent = Qt.createComponent("OutputDieInterval.qml");
    outputDieObject = outputDieComponent.createObject(outputDieContainer,
                                                      {source: "qrc:/DiceImages/8Sides8.png",
                                                          y: 630, dieValue: 8})
}

function resetDice()
{
    for(var i = 0; i < 6; i++)
    {
        inputDieContainer.children[i].reset();
    }
    for(i = 0; i < 8; i++)
    {
        outputDieContainer.children[i].reset();
    }
}

function showFirstDieUsed(value)
{
    for(var i = 0; i < 6; i++)
    {
        inputDieContainer.children[i].showFirstDieUsed(value)
    }
    var firstDieAnimationComponent = Qt.createComponent("AddFirstDieAnimatedImage.qml")
    var firstDieAnimationObject = firstDieAnimationComponent.createObject(mainWindow);
    firstDieAnimationObject.setValue(value)
}

function zoomInOnDie(lastValue, thisValue, intervalTop, intervalBottom)
{


    for(var i = 0; i < 6; i++)
    {
        inputDieContainer.children[i].startZoomInAnimation(lastValue, thisValue)
    }
    for(i = 0; i < 8; i++)
    {
        outputDieContainer.children[i].startZoomInAnimation(intervalTop, intervalBottom);
    }
}

function startAdditionalDieAnimation(lastValue, thisValue, processedDice)
{
    var additionalDieAnimationComponent = Qt.createComponent("AddAdditionalDieAnimatedImage.qml")
    var additionalDieAnimationObject = additionalDieAnimationComponent.createObject(mainWindow, //163
                                                                                    {y: 163 + 42*Math.floor(processedDice / 6),
                                                                                     x: 8 + 42 * (processedDice % 6),
                                                                                    finalY: 120*(lastValue-1) + 20*(thisValue-1) - 10});
    additionalDieAnimationObject.setValue(thisValue);
}

function shrinkOutputInterval(newDieValue, intervalTop, intervalBottom)
{
    for(var i = 0; i < 8; i++)
    {
        outputDieContainer.children[i].startZoomOutAnimation(newDieValue, intervalTop, intervalBottom);
    }
}

function startOutputDieAnimation(yValue, dieValue)
{
    var initialY;
    if(yValue < 0)
        initialY = 0;
    else if(yValue > 680)
        initialY = 680;
    else
        initialY = yValue;

    var finalYJS = 5 + 42*Math.floor((outputModel.totalDice - 1) / 4)
    var finalXJS = 782 + 42*((outputModel.totalDice - 1) % 4)

    var outputDieAnimationComponent = Qt.createComponent("OutputDieAnimatedImage.qml")
    var outputDieAnimationObject = outputDieAnimationComponent.createObject(mainWindow,
                                                                            {y: initialY,
                                                                            finalY: finalYJS,
                                                                            finalX: finalXJS});
    outputDieAnimationObject.setValue(dieValue)
}

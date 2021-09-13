import QtQuick 2.0

Rectangle
{
    width: 60
    height: 20

    property alias source: image.source;
    property alias imageOpacity: image.opacity;

    Image
    {
        id: image
        anchors.centerIn: parent
        width: parent.height / 3.0
        height: width
        opacity: 0.3;
    }

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
                color: "#230f04"
            }
            PropertyChanges
            {
                target: gradientMid
                color: "#673405"
            }
            PropertyChanges
            {
                target: gradientBot
                color: "#230f04"
            }
        }
    ]

    gradient: Gradient
    {
        GradientStop{id: gradientTop; position: 0.0; color: "#042323"}
        GradientStop{id: gradientMid; position: 0.5; color: "#056767"}
        GradientStop{id: gradientBot; position: 1.0; color: "#042323"}
    }

    Rectangle
    {
        width: parent.width
        height: 1
        color: "black"
    }
    Rectangle
    {
        width: parent.width
        height: 1
        anchors.bottom: parent.bottom
        color: "black"
    }
}

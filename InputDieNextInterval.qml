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

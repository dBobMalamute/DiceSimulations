import QtQuick 2.0

Rectangle
{
    width: 60
    gradient: Gradient
    {
        GradientStop{id: gradientTop; position: 0.0; color: "#1a1a1a"}
        GradientStop{id: gradientMid; position: 0.5; color: "#666666"}
        GradientStop{id: gradientBot; position: 1.0; color: "#1a1a1a"}
    }

    property alias source: image.source;
    property alias imageOpacity: image.opacity;

    Image
    {
        id: image
        anchors.centerIn: parent
        width: Math.min(40, parent.height / 1.5)
        height: width
        opacity: 0.3;
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

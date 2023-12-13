import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root
    minimumWidth: 1280
    maximumWidth: 1280
    minimumHeight: 720
    maximumHeight: 720
    visible: true
    title: qsTr("Day4App")

    property int score: 0
    property int lifePoints: 5

    function generateRandomColor() {
        var colors = ["yellow", "blue", "green", "red", "black", "purple", "pink", "brown", "gray", "orange"];
        return colors[Math.floor(Math.random() * colors.length)];
    }

    function generateRandomSize() {
        return Math.random() * 50 + 50;
    }

    Rectangle {
        id: rootRectangle
        width: parent.width
        height: parent.height

        MouseArea   {
            anchors.fill: parent
            onClicked: {
                root.lifePoints--;
            }
        }

        Repeater {
            model: 10

            Rectangle {
                id: spawnRectangle
                width: generateRandomSize()
                height: generateRandomSize()
                color: generateRandomColor()
                border.color: "black"
                border.width: 2

                property real xPosition: Math.random() * (rootRectangle.width - width)
                property real yPosition: Math.random() * (rootRectangle.height - height)

                property real xVelocity: Math.random() * 200 - 100
                property real yVelocity: Math.random() * 200 - 100

                x: xPosition
                y: yPosition

                SequentialAnimation {
                    id: redDisappear
                    running: false

                    PropertyAnimation {
                        id: colorRect
                        target: redDisappear
                        to: 0
                        duration: 100
                    }

                    onStopped: {
                        spawnRectangle.color = generateRandomColor();
                        width = generateRandomSize();
                        height = generateRandomSize();
                        xPosition = Math.random() * (rootRectangle.width - width);
                        yPosition = Math.random() * (rootRectangle.height - height);
                        xVelocity = xVelocity * 2;
                        yVelocity = yVelocity * 2;
                        opacity = 1;
                    }
                }

                Timer {
                    interval: 16
                    running: true
                    repeat: true
                    onTriggered: {
                        xPosition += xVelocity * 0.016;
                        yPosition += yVelocity * 0.016;

                        if (xPosition < 0 || xPosition + width > rootRectangle.width) {
                            xVelocity = -xVelocity;
                        }

                        if (yPosition < 0 || yPosition + height > rootRectangle.height) {
                            yVelocity = -yVelocity;
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                            root.score++;
                            redDisappear.start();

                    }
                }
            }
        }
    }

    Text {
        id: scoreLabel
        text: "Score: " + root.score
        font.pixelSize: 40
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: lifeLabel
        text: "Lives: " + root.lifePoints
        font.pixelSize: 40
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

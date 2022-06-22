//author:wang zijing
//time:2022/6/22
import QtQuick 2.0
import QtQuick.Layouts 1.12

Rectangle {
    id: finishWind
    property int score: 1200
    color: "#80000000"
    z: 501

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40

        Row {
            spacing: 20
            Layout.alignment: Qt.AlignCenter
            Image {
                source: "qrc:/icon/finish.png"  //图片来源
                width: 58
                height: 58
            }
            ScoreNumber {
                id: scoreNumber
                height: 58
                value: finishWind.score
            }
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            color: "#FFFFFF"
            font.pixelSize: 40
            font.family: "Microsoft Yahei"
            font.letterSpacing: 28
            text: "游戏结束"
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            color: "#FFFFFF" //颜色设置为白色
            font.pixelSize: 17
            font.family: "Microsoft Yahei"
            font.letterSpacing: 5
            text: "点击重新开始"
            horizontalAlignment: Text.AlignHCenter   //将文本文字置于中央
        }

    }


    NumberAnimation on opacity {
        from: 0; to: 1.0; duration: 600; running: finishWind.visible
    }

}

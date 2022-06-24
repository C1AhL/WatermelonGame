import QtQuick 2.0
import QtQuick.Particles
import QtMultimedia
//author:chenhailin
//edition:1.0/2022/6/23

//小球合并时的动画效果控制
Item {
    property int modelSize: 5
    property string mergeSrc:""


    id: merge

    Repeater
    {
        model: modelSize
        Image {
            fillMode: Image.Stretch
            anchors.fill: parent
            source: mergeSrc
            rotation: Math.random()*90
            opacity: (modelSize - index) / modelSize    // 0 -> 1
            scale:  (modelSize - index) / modelSize     // 0 -> 1

            NumberAnimation on opacity {
                id: mergeAnimation
                running: true
                to: 1.0; duration: 200
                // @disable-check M16
                Finished: merge.animationFinished()
            }
        }
    }




    function animationFinished() {
        this.destroy(100);
    }
    Timer {

        running: true
        interval: 300
        onTriggered: merge.destroy()
    }

    Component.onCompleted: {}
}

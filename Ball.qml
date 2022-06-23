/****************************************************************************
**  小球控件
** Author   :wang zijing
** Create   : 2022/6/23
****************************************************************************/

import QtQuick 2.12
Image {
    id: img

    property var pointX: 0
    property var pointY: 0
    property var  preX: 0
    property var preY: 0
    property var vx: 0
    property var vy: 0
    property var r: 0
    property var cor: 0
    property var mass: 0
    property var rotate: 0
    property var ballType: 0
    property var shapeChange: false
    property var mergeSrc: ""
    property var mergeStart: false
    property var endPointX: 0
    property var endPointY: 0

    Behavior on width {
        NumberAnimation {
            id: widthAnima; duration: 300;
            onRunningChanged:  shapeChange = running;//动画执行300ms结束
        }
    }

    Behavior on height { NumberAnimation { duration: 300; } }

    fillMode: Image.Stretch //动画开始的位置  
    mipmap: true //多级渐远纹理技术
    y: pointY - height/2
    width: 0
    height: 0
    
    NumberAnimation on pointX {
        id: enPointXAnimation
        running: mergeStart == true
        to: endPointX; duration: 300
    }
    NumberAnimation on pointY {
        id: enPointYAnimation
        running: mergeStart == true
        to: endPointY; duration: 300
    }

    NumberAnimation on rotate {
        to: calcEndRotate()
        id: rotateAnimation
        running: mergeStart == true
        duration: 300
        onFinished: {
            preX = pointX
            preY = pointY
            mergeStart = false
        }
    }

    function calcEndRotate() {

        let distance = Math.sqrt(Math.pow((endPointX - pointX),2) + Math.pow((endPointY - pointY),2)); //小球移动距离

        if (endPointX > pointX)
            return rotation +  360/(2 * r * 3.14) * distance * 0.5;
        else
            return rotation -  360/(2 * r * 3.14) * distance * 0.5;

        }


}

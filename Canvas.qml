import QtQuick 2.0
import QtQuick.Controls
import QtMultimedia

//author:chenhailin
//edition:1.0/2022/6/22
    Canvas{
/*  自学小课堂（来源csdn）
    Canvas元素提供了一种与分辨率无关的位图绘制机制。
    通过Canvas，可以使用 JavaScript 代码进行绘制。
    Canvas元素的基本思想是，使用一个2D上下文对象渲染路径。
    2D上下文对象包含所必须的绘制函数，从而使Canvas元素看起来就像一个画板。
    2D上下文对象支持画笔、填充、渐变、文本以及其它一系列路径创建函数*/

    id: canvas

    visible: true
    property int score: 0
    property int lineDashY: 100
    property int finish: 0              //控制界面进程： 0 : 未结束  1: 结束动画  2: 结束界面
    property var preBallLeaveDate: new Date
    onPaint: {                          // 绘制API
        var context = getContext('2d')  // 获取2d上下文对象
        var preDate = new Date;

        function draw() {

          requestAnimationFrame(draw);
       }

        drawLineDash();
        draw();
    }



   //绘制虚线
    function drawLineDash() {
        context.setLineDash( [ 6, 6, 3] );
        context.lineWidth = 4;
        context.clearRect(0, lineDashY - 4, canvas.width, lineDashY + 4);
        context.strokeStyle = "#91431E"         //描边绘制
        context.lineCap = "round"
        context.moveTo(0, lineDashY);
        context.lineTo(canvas.width, lineDashY);
        context.stroke();
    }
    
     SoundEffect {
        id: downSound
        source: "../audio/down.wav"
    }

    SoundEffect {
        id: mergeSound1
        volume: 0.6
        source: "../audio/merge1.wav"
    }

    SoundEffect {
        id: mergeSound2
        source: "../audio/merge2.wav"
    }

    SoundEffect {
        id: finishSound
        source: "../audio/finish.wav"
    }

    ScoreNumber {
        id: scoreNumber
        x: 10
        y: 20
        value: score
    }
}

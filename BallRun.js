.import QtQuick 2.0 as QQ
//水果的集合

//读取水果图片并添加效果
var ballData = [
            {
                "radius" : 125,
                "cor" : 0.2,
                "image" : "qrc:/pics/ball1.png",
                "mergeImage" : "qrc:/pics/merge2.png",
            },
            {
                "radius" : 115,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball2.png",
                "mergeImage" : "qrc:/pics/merge3.png",
            },
            {
                "radius" : 105,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball3.png",
                "mergeImage" : "qrc:/pics/merge4.png",
            },
            {
                "radius" : 95,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball4.png",
                "mergeImage" : "qrc:/pics/merge5.png",
            },
            {
                "radius" : 80,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball5.png",
                "mergeImage" : "qrc:/pics/merge6.png",
            },
            {
                "radius" : 70,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball6.png",
                "mergeImage" : "qrc:/pics/merge7.png",
            },
            {
                "radius" : 60,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball7.png",
                "mergeImage" : "qrc:/pics/merge8.png",
            },
            {
                "radius" : 50,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball8.png",
                "mergeImage" : "qrc:/pics/merge9.png",
            },
            {
                "radius" : 40,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball9.png",
                "mergeImage" : "qrc:/pics/merge10.png",
            },
            {
                "radius" : 30,
                "cor" : 0.3,
                "image" : "qrc:/pics/ball10.png",
                "mergeImage" : "qrc:/pics/merge11.png",
            },
            {
                "radius" : 20,
                "cor" : 0.1,
                "image" : "qrc:/pics/ball11.png",
                "mergeImage" : "qrc:/pics/merge11.png",
            },
];

var component;
var mergeComponent;
var balls = new Array(0);               //添加length属性，表示数组所占内存空间的数目
var currentBall = null;

//随机生成6种水果,其他5种水果需靠合成
function getBallData() {

   if (balls.length < 3)                 // 控制开场前3个都为葡萄
       return ballData.length - 1;

   else if (balls.length < 6)
                                        //大概控制每种水果生成的概率
       return Math.random() < 0.55 ? ballData.length - 1 :
              Math.random() < 0.55 ? ballData.length - 2 :
              Math.random() < 0.88 ? ballData.length - 3 :
              Math.random() < 0.77 ? ballData.length - 4 :
              Math.random() < 0.66 ? ballData.length - 5 : ballData.length - 6;

   else
       return Math.random() < 0.35 ? ballData.length - 1 :
              Math.random() < 0.25 ? ballData.length - 2 :
              Math.random() < 0.36 ? ballData.length - 3 :
              Math.random() < 0.40 ? ballData.length - 4 : ballData.length - 5;
}

//获取新球
function newBall(x) {
    if (component === null)
        component = Qt.createComponent("Ball.qml");

    if (component.status === QQ.Component.Ready) {
        let index = getBallData();

        if (x < ballData[index].radius) {
            x = ballData[index].radius
        } else if (x + ballData[index].radius > width) {
            x = width - ballData[index].radius
        }

        var dynamicObject = component.createObject(canvas,
                   { pointX: x,
                     pointY: ballData[index].radius,
                     r: ballData[index].radius,
                     cor: ballData[index].cor,
                     source: ballData[index].image,
                     mass: ballData[index].radius * ballData[index].radius,
                     ballType: index,
                     mergeSrc : ballData[index].mergeImage,
                   });
        dynamicObject.width = ballData[index].radius * 2;
        dynamicObject.height = ballData[index].radius * 2;
        currentBall = dynamicObject

    }
}

//判断小球基本的移动以及游戏结束临界点
function currentBallMove(x) {
    if (currentBall == null) {
        return false;
    }
    if (x < currentBall.r || x + currentBall.r > width) {
        return false;
    }

    currentBall.pointX = x ;
    return true;
}

function currentBallStartDown() {
    if (currentBall == null) {
        return false;
    }

    if ( currentBall.shapeChange === true) {
        return false;
    }

    currentBall.vy = 10;
    balls[balls.length] = currentBall
    currentBall = null
    return true;
}

const edgeCorX = 0.2;                    // 边界弹力
const edgeCorY = 0.2;                    // 边界弹力
const ballAy = 1;                        // 重力加速度

//确定小球运动时的位置
function ballsMove() {
    for (var i in balls)
    {
        var ball =  balls[i];
        ball.vy += ballAy;

        ball.preX  = ball.pointX
        ball.preY  = ball.pointY
        ball.pointX += ball.vx;
        ball.pointY += ball.vy;

        if (ball.pointX < ball.r) {
            ball.pointX = ball.r
            ball.vx = -ball.vx * edgeCorX
            if (Math.abs(ball.vx)<0.1)  ball.vx = 0

        } else if (ball.pointX + ball.r > width) {
            ball.pointX = width - ball.r
            ball.vx = -ball.vx * edgeCorX
            if (Math.abs(ball.vx)<0.1)  ball.vx = 0

        }

        if (ball.pointY < ball.r) {
            ball.pointY = ball.r
            ball.vy = -ball.vy * edgeCorY
        } else if (ball.pointY + ball.r > height) {
            ballIsDown(ball);
            ball.pointY = height - ball.r
            ball.vy = -ball.vy * edgeCorY
        }

    }
}


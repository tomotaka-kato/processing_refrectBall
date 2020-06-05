ArrayList<Ball> balls;


void setup() {
  background(255);
  noStroke();
  
  size(500, 500);
  
  // ボールデータ作成（適当に25個）
  // TODO: 初期ボールが表示されない原因を調査
  balls = new ArrayList<Ball>();
  for (int i = 0; i < 25; i++) {
    balls.add(i, new Ball());
  }
  println(balls.size());
  
}

void draw() {
  // background(255);

  // 残像
  fill(255, 255, 255, 70);
  rect(0, 0, width, height);

  for(int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    ball.move();
    ball.draw();
  }
  
}

/**
 * 画面クリックで新たなボールを作成
 */
void mouseClicked() {
  int posX = mouseX;
  int posY = mouseY;
  balls.add(new Ball(posX, posY));
}


class Ball {
 float posX;
 float posY;
 float diameter;
 float directionX;
 float directionY;
 color ballColor;
 
 /**
  * コンストラクタ
  */
 public Ball() {
   this.diameter = random(25) + 20;
   // 壁にめり込まない位置に初期配置する。
   posX = diameter/2 + random(width - diameter/2);
   posY = diameter/2 + random(height - diameter/2);
   // 最低でも動くこと。
   directionX = random(5) + 1;
   directionY = random(5) + 1;
   // TODO: 白系の色が生成されないようにする。
   this.ballColor = color(100 + random(156), 100 + random(156), 100 + random(156));
   draw();
 }

 public Ball(int posX, int posY) {
   this.diameter = random(25) + 20;
   // 壁にめり込まない位置に初期配置する。
   this.posX = posX;
   this.posY = posY;
   // 最低でも動くこと。
   directionX = random(5) + 1;
   directionY = random(5) + 1;
   this.ballColor = color(random(256), random(256), random(256));
   draw();
 }
 
 /**
  * ボールの座標移動
  */
 public void move() {
   // ぶつかったら向きだけでなく色も変える。
   if(isCollision(posX, directionX, width)) {
     this.ballColor = color(random(256), random(256), random(256));
     directionX *= -1;
   }
   if(isCollision(posY, directionY, height)) {
      this.ballColor = color(random(256), random(256), random(256));
      directionY *= -1; 
   }
   posX += directionX;
   posY += directionY;
 }
 
 /**
  * 壁との衝突判定
  */
 private boolean isCollision(float position, float direction, float wallPosition) {
   if(direction > 0) {
     // 右向き、下向きに移動していたらサイズの最大値と比較して衝突判定
     return position + diameter/2 > wallPosition;
   }else if(direction < 0) {
     // 左向き、上向きに移動していたらサイズの最小値と比較して衝突判定
     return position - diameter/2 < 0;
   }
  return false; 
 }
 
 /**
  * ボールの描画処理
  */
 public void draw() {
   fill(this.ballColor);
   ellipse(posX, posY, diameter, diameter);
 }

}

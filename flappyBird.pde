
// initial default values
int groundLevel=400;
int ceilLevel=80;
float velocity=5;
float g=9.81/9;
float X=100, Y=100;
float time=0.2;
int size=26;
int score=0;

// event properties
boolean pressed=false;
boolean velocityChange=true;
boolean wallChange=true;
boolean scoreChange=true;

// cWall properties
int cx=430, cy=0, cd=0;

// gWall properties
int gx=430, gy=0, gd=0;

void setup() {
  size(480, 480);
}

void draw() {
  clear();
  background(255);
  line(0, groundLevel, 480, groundLevel);
  line(0, ceilLevel, 480, ceilLevel);
  wall();
  
  if(!pressed) {
    Y+=velocity*time/2;
    velocity+=g*time;
    velocityChange=true;
  } else {
    if(velocityChange) {
      velocity=16;
      velocityChange=false;
    }
    Y-=velocity*time/2;
    velocity+=g*time/2;
  }
  if(Y+size/2>=groundLevel || Y-size/2<=ceilLevel || crashed()) {
    println("Lost!");
    println("Score : "+score);
    stop();
  } else if(passed() && scoreChange) {
    ++score;
    scoreChange=false;
  }
  if(cx+cd<0 && gx+gd<0) {
    cx=gx=430;
    wallChange=true;
    scoreChange=true;
  } else {
    cx-=1;
    gx-=1;
  }
  
  //line(X-size/2, ceilLevel, X-size/2, groundLevel);
  //line(X+size/2, ceilLevel, X+size/2, groundLevel);
  //line(X-size/2, Y-size/2, 470, Y-size/2);
  //line(X-size/2, Y+size/2, 470, Y+size/2);
  
  fill(0, 255, 0);
  ellipse(X, Y, size, size);
}

void mousePressed() {
  pressed=true;
}

void mouseReleased() {
  pressed=false;
}

boolean crashed() {
  if(X+size/2>cx && X-size/2<cx+cd && Y-size/2<=ceilLevel+cy) {
    return true;
  }
  if(X+size/2>gx && X-size/2<gx+gd && Y+size/2>=groundLevel-gy) {
    return true;
  }
  return false;
}

boolean passed() {
  if(X-size/2>cx+cd || X-size/2>gx+gd) {
    return true;
  }
  return false;
}

void wall() {
  if(wallChange) {
    cWall();
    gWall();
    wallChange=false;
  }
  
  fill(100);
  rect(cx, ceilLevel, cd, cy);
  rect(gx, groundLevel-gy, gd, gy);
}

void cWall() {
  cd=(int)random(30,60);
  cy=(int)random(100, 150);
}

void gWall() {
  gd=(int)random(30,60);
  gy=(int)random(80,130);
}

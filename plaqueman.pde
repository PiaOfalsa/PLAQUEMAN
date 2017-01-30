class Plaqueman
{
  PImage pacpic;
  int radius, directionX, directionY;
  float x, y, speed;
  Plaqueman()
  {
    pacpic=loadImage("pac.png");
    radius = 10;
    directionX = 1;
    directionY = 0;
    x = 20;
    y = 20;
    speed = 0.5;
    //plaquemanX = 250;
    //plaquemanY = 250;
    //speed = 5;
  }//end plaqueman


  void display() {
    
    x=x+speed*directionX;
    y=y+speed*directionY; 
    // check boundaries
    if ((x>width-radius) || (x<radius))
    {   
      directionX=-directionX;
    }
    if ((y>height-radius) || (y<radius))
    {   
      directionY=-directionY;
    } 
    // draw
    noFill();
   
    //fill (color(222, 22, 22)); 
    ellipse (x, y, radius, radius);    // body
    //fill (color(22, 82, 22)); 
    ellipse (x-4, y-4, 2, 2);  // the eye
    //image(pacpic, directionX, directionY);
  }

  void update()
  {
    if (keyPressed) {
      if (key == CODED)
      {
        if (keyCode == LEFT)
        {
          //if (directionX>0) { 
          directionX=-1;
          directionY=0;
          //}
        } else if (keyCode == RIGHT)
        {
          //if (directionX<0) {  
          directionX=1;
          directionY=0;
          //}
        } else if (keyCode == UP)
        {
          //if (directionY<0) {
          directionY=-1;
          directionX=0;
          //}
        } else if (keyCode == DOWN)
        {
          //if (directionY<0) { 
          directionY=1;
          directionX=0;
          //}
        }
      }
    }
  }
}//endclass
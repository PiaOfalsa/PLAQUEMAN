/*
    TARTAR WARS- EPISODE PLAQUEMAN
    
    This game is HIGHLY inspired by starwars and pac-man.
    Fun and exciting to play.
    
    Controls:
    KEY BOARD
      PLAQUEMAN'S MOVEMENT
        -W = UP
        -A = LEFT
        -S = DOWN
        -D = RIGHT
        
    OBJECTIVES
    EAT AS MUCH SWEETS (SMALL LITTLE CIRCLES,BIGGER ONES ARE BONUSES) AS MUCH AS POSSIBLE.
      - 1 SMALL SWEET = 1 SCORE
      - 1 BIG SWEET   = 5 SCORE
    AVOID THE STRONG MOLAR GHOSTS!!!
    THEY ARE STRONG HEALTHY AND FILLED WITH FLUORIDE!
    BECAREFUL!! WHY??
    --IF YOU HIT ONE OF THE MOLAR GHOST (RED,BLUE OR ORANGE)
    -- FROM YOUR 3 LIVES ONE WILL BE DEDUCTED.
    
    ENJOY!
*/

Menu menu;
Menu[] menus = new Menu[50];
plaqueman player;
wall[] walls; 

import ddf.minim.*;
Minim minim;
AudioPlayer hello;
AudioPlayer chomp;
AudioPlayer swars;
AudioPlayer bonus;
AudioPlayer DOH;
AudioPlayer DEAD;

int mode=0;// intro screen 1 normal play 2 game end
int INTRO=0;//INTRO TARTAR WARS
int INTRO_P=1;//INTRO OF PACMAN
int PLAY=2;//GAME SCREEN
int GOVER=3;//GAME OVER MAY THE FLOSS BE WITH YOU
int scoreboard=4;
int controls=5;


GhostR gr;
GhostO go;
GhostB gb;

PImage tartar;
PImage orange, red, blue;
PImage end, control;


void setup() {

  size(600, 600);


  menu=new Menu();

  for (int i = 0; i < menus.length; i++) {
    menus[i] = new Menu();
  }

  tartar =loadImage("intro.jpg");
  red =loadImage("red.gif");
  orange =loadImage("orange.gif");
  blue =loadImage("blue.gif");
  end =loadImage("game_over.jpg");
  control =loadImage("controls.jpg");


  player = new plaqueman(20, 300);
  minim=new Minim(this);
  hello = minim.loadFile("pacman_beginning.wav"); 
  chomp = minim.loadFile("Waka Flocka Pacman.mp3");
  swars =  minim.loadFile("Star Wars.mp3");
  bonus =  minim.loadFile("Yum Yum Yum Yum delicioso.mp3");
  DOH =  minim.loadFile("hit.mp3");
  DEAD =  minim.loadFile("pacman-die.mp3");
  

  loadData();
  minmax();
  margin = width * 0.1f;
} 
void draw() {

  background(0);

  if (mode==INTRO)
  {
    displayIntro();
  } else if (mode==INTRO_P)
  {
    menu.menuback();

    for (int i = 0; i < menus.length; i++) {
      menus[i].fall();
      menus[i].show();
      hello.play();
    }
    //game screen
  }//end if modem 

  else if (mode==PLAY)
  {//hello.pause();


    printWall();

    player.draw();

    player.move(walls);

    for (int i = 0; i < walls.length; i++) {
      walls[i].draw();
    }
  }//end else if 1
  else if (mode==scoreboard)
  {
    background(172, 247, 249);
    drawLineGraph();
    drawSCOREShighestScores();
  }//end else if 2
  else if (mode==GOVER)
  {
    background(end);
    DEAD.play();
  } else if (mode==controls)
  {
    background(control);
  }
}


void displayIntro()
{
  background(tartar);
  
  swars.play();
  if (keyPressed)
  {
    if (key == ENTER)
    {swars.pause();
 
      mode=1;
    }
  }
}

void printWall() {
  walls = new wall[24];
  walls[0] = new wall(50, 10, 500, 10);//top
  walls[1] = new wall(50, 500, 500, 10);//bottom end horizontal
  walls[2] = new wall(540, 20, 10, 100);//right pillar vertical
  walls[3] = new wall(50, 120, 90, 10);//left hor
  walls[4] = new wall(50, 400, 10, 100);//bottom left vert
  walls[5] = new wall(540, 400, 10, 100);//bottom right vert
  walls[6] = new wall(50, 20, 10, 100);//left vert pillar
  walls[7] = new wall(460, 120, 90, 10);//right horz
  walls[8] = new wall(60, 180, 140, 140);//first o
  walls[9] = new wall(240, 180, 140, 140);//2nd o
  walls[10] = new wall(422, 180, 20, 140);//pillar p
  walls[11] = new wall(442, 180, 105, 130);//box p
  walls[12] = new wall(50, 390, 90, 10);//bottom left hor
  walls[13] = new wall(460, 390, 90, 10);//bottom right hor
  walls[14] = new wall(100, 60, 80, 10);//top left hor bar
  walls[15] = new wall(230, 20, 10, 80);//top left vert
  walls[16] = new wall(280, 60, 80, 10);//top 2nd hor bar
  walls[17] = new wall(400, 20, 10, 80);//top 2nd vert
  walls[18] = new wall(460, 60, 40, 10);//top right bar 3rd
  walls[19] = new wall(100, 440, 80, 10);//bottom left hor
  walls[20] = new wall(230, 420, 10, 80);//bot vert left
  walls[21] = new wall(280, 440, 80, 10);//bot
  walls[22] = new wall(400, 420, 10, 80);//top 2
  walls[23] = new wall(460, 440, 40, 10);//bot right
}

ArrayList<SCORES> data = new ArrayList<SCORES>();

float margin;
float min, max;


void loadData()
{
  Table t = loadTable("HSCORE.csv");
  for (int i = 0; i < t.getRowCount(); i ++)
  {
    TableRow row = t.getRow(i);
    SCORES scores = new SCORES(row);
    data.add(scores);
  }
}


void minmax()
{
  min = max = data.get(0).highestScores; 
  for (SCORES scores : data)
  {
    if (scores.highestScores < min)
    {
      min = scores.highestScores;
    }
    if (scores.highestScores > max)
    {
      max = scores.highestScores;
    }
  }
}


void drawLineGraph()
{

  stroke(255, 0, 0);  //L of the graph

  line(margin - 5, height - margin, width - margin, height - margin);
  line(margin, margin, margin, height - margin + 5);
  textSize(30);
  text(" LEADERBOARD ", 150, 40);
  for (int i = 1; i < data.size(); i ++)
  {


    stroke(0, 0, 255);
    float x1 = map(i - 1, 0, data.size() - 1, margin, width - margin);
    float y1 = map(data.get(i - 1).highestScores, min, max, height - margin, margin);
    float x2 = map(i, 0, data.size() - 1, margin, width - margin);
    float y2 = map(data.get(i).highestScores, min, max, height - margin, margin);

    fill(0);
    line(x1, y1, x2, y2);
  }
}


void drawSCOREShighestScores()
{

  fill(255, 0, 0);
  if (mouseX >= margin && mouseX <= width - margin)
  {
    //vertical line
    strokeWeight(2);
    fill(255, 200, 0);

    line(mouseX, margin, mouseX, height - margin);
    int i = (int) map(mouseX, margin, width - margin, 0, data.size() - 1);
    float y = map(data.get(i).highestScores, min, max, height - margin, margin);


    ellipse(mouseX, y, 10, 10);


    fill(0);
    textSize(10);
    text("Year: " + data.get(i).year, mouseX, y);
    text("HIGHEST_SCORES: " + data.get(i).highestScores, mouseX, y + 30);
    text("Player ID " + data.get(i).highestScores, mouseX, y + 50);
  }
}
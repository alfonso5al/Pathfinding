Grid grid;
Entorno entorno;
boolean reto = false;
int modo = 1;

void setup() {
  size(1375,950);
  int tam = 30;
  if(!reto)
  {
    grid = new Grid(30,30, tam);
    entorno = new Entorno(grid, tam);
  }
  else
  {
    grid = new Grid("Pathfinding.txt", 25);
    entorno = new Entorno(grid, 25);
  }
}

void draw() {
  background(255);
  
  entorno.draw();
  
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    loop();
    setup();
  }
  if (key == 'a' || key == 'A') {
    loop();
    reto = false; 
    setup();
  }
  if (key == 'b' || key == 'B') {
    loop();
    reto = true; 
    setup();
  }
  if(key == '1')
  {
    modo = 1;
    setup();
  }
  if(key == '2')
  {
    modo = 2;
    setup();
  }
}

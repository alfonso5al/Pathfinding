class Entorno {
  Grid grid;
  float tam_celda;
  boolean stop = false;
  Vehicle v;
  List<Vehicle> vehicles = new ArrayList<Vehicle>();
  List<List<Node>> caminos = new ArrayList<List<Node>>();
  int cont;
  int[] c;
  int aux = 0;
  float w;
  
  Entorno(Grid grid, float tam_celda) {
    this.grid = grid;
    this.tam_celda = tam_celda;
    for (int i = 0; i < grid.rows; i++)
    {
       for (int j = 0; j < grid.cols; j++)
       {
         grid.nodos[i][j].addVecinos(grid.nodos, i, j, grid.rows,grid.cols);
       }
    }
    
    if(modo == 1)
    {
      cont = 0;
      w = 1;
    }
    else if(modo == 2)
    {
      cont = 2;
      w = 5;
    }
    c = new int[cont+1];
    c[0]=0;
  }
  
  float heuristic(Node a, Node b) {
    float d = dist(a.x, a.y, b.x, b.y);
    return d;
  }
  
  void Aalgorithm()
  {
  if (!stop)
    {
      
      if ( grid.abiertos.size() > 0) {
        grid.abiertos.get(0).f = grid.abiertos.get(0).g+ w * heuristic(grid.abiertos.get(0), grid.fin);
        int win = 0;
        for (int i = 0; i < grid.abiertos.size(); i++) {
          if (grid.abiertos.get(i).f < grid.abiertos.get(win).f) {
            win = i;
          }
        }
        
        grid.actual = grid.abiertos.get(win);
        
        if (grid.actual == grid.fin) {
          if(cont >= 0)
          {
            cont--;
            grid.camino= new ArrayList<Node>();
            Node temp = grid.actual;
            grid.camino.add(temp);
            while (temp.previous != null) {
              grid.camino.add(temp.previous);
              temp = temp.previous;
               
            }
              caminos.add(grid.camino);
              if(modo == 2)
                w -= 1.5;
              return;
          }
           else
           {
              stop = true;
              for(int i = 0; i< 7; i++)
              {
                v = new Vehicle(grid.ini.y*tam_celda+(tam_celda/2), grid.ini.x*tam_celda+(tam_celda/2), aux);
                vehicles.add(v);
                if(modo == 2)
                {
                  if(aux < 2)
                    aux++;
                  else
                    aux = 0;
                }
              }
           }
          
        }
          grid.abiertos.remove(grid.actual);
          grid.comprobados.add(grid.actual);
        
          List<Node> vec = grid.actual.vecinos;
          for (int i = 0; i < vec.size(); i++) {
            Node vecino = vec.get(i);
      
              if (!grid.comprobados.contains(vecino) && vecino.num != 1) {
                float tempG = grid.actual.g + heuristic(vecino, grid.actual) * w;
        
                boolean newPath = false;
                if (grid.abiertos.contains(vecino)) {
                  if (tempG < vecino.g) {   
                    newPath = true;
                    }
                  } 
                else {
                  
                  newPath = true;
                  grid.abiertos.add(vecino);
                  }
                if (newPath) { 
                  vecino.g = tempG;
                  vecino.h = heuristic(vecino,grid.fin);
                  vecino.f = vecino.g + vecino.h*w;
                  vecino.previous = grid.actual;
                  }
              }
            }
      }
      else {
          stop = true;
          return;
        }
    }     
}
  
  void draw() {
    
      Aalgorithm();
      
      for (int i = 0; i < grid.rows; i++) {
        for (int j = 0; j < grid.cols; j++) {
          if (grid.nodos[i][j].num == 2) {
            noStroke();
            fill(230,230,255);
          } else if (grid.nodos[i][j].num == 3) {
            noStroke();
            fill(255,230,230);
          } else if (grid.nodos[i][j].num == 1) {
            noStroke();
            fill(0);
          } else {
            stroke(200);
            fill(255);
          }
          
          Node aux = grid.nodos[i][j];
          
          for (int k = 0; k < grid.comprobados.size(); k++) {
            if(aux == grid.comprobados.get(k))
            {
              
              fill(255, 0, 100);
            }
          }
          
          for (int l = 0; l < grid.abiertos.size(); l++) {
            if(grid.nodos[i][j] == grid.abiertos.get(l))
            {
              fill(100, 255, 0);
            }
          }
  
          if(grid.nodos[i][j].id == grid.ini.id)
          {
            fill(180,255,200);
          }
          else if (grid.nodos[i][j].id == grid.fin.id)
          {
            fill(255,167,201);
          }
  
          
          rect(j * tam_celda, i * tam_celda, tam_celda, tam_celda);
        }
      }
      
      
      if(stop == true && caminos.size() > 0)
      {
        if(modo == 2)
        {
          for (int i = 0; i < 3; i++)
          {
            
            drawCamino(caminos.get(i));
          }
          for(int j = 0; j < cont; j++)
            c[j]=0;
        }
        else if (modo == 1)
        {
          drawCamino(caminos.get(0));
          
        }
      }
      
      if (stop && caminos.size() > 0)
      {
       if(modo == 2)
       {
        for(int i = 0; i < 7; i++)
        {
         int id = vehicles.get(i).id;
         vehicles.get(i).arrive(new PVector(caminos.get(id).get(caminos.get(id).size()-c[id]-1).y*tam_celda+(tam_celda/2),caminos.get(id).get(caminos.get(id).size()-c[id]-1).x*tam_celda+(tam_celda/2))); 
         vehicles.get(i).run();
         if(c[id]< caminos.get(id).size()-1)
         {
           float d = PVector.dist(vehicles.get(i).location,new PVector(caminos.get(id).get(caminos.get(id).size()-1-c[id]).y*tam_celda+(tam_celda/2), caminos.get(id).get(caminos.get(id).size()-1-c[id]).x*tam_celda+(tam_celda/2)));
           if(d < tam_celda/2)
             c[id]++;
         }
        }
       }
       else if(modo == 1)
       {
        for(int i = 0; i < 7; i++)
        {
         vehicles.get(i).arrive(new PVector(caminos.get(0).get(caminos.get(0).size()-c[0]-1).y*tam_celda+(tam_celda/2),caminos.get(0).get(caminos.get(0).size()-c[0]-1).x*tam_celda+(tam_celda/2))); 
         vehicles.get(i).run();
         if(c[0]< caminos.get(0).size()-1)
         {
           float d = PVector.dist(vehicles.get(i).location,new PVector(caminos.get(0).get(caminos.get(0).size()-1-c[0]).y*tam_celda+(tam_celda/2), caminos.get(0).get(caminos.get(0).size()-1-c[0]).x*tam_celda+(tam_celda/2)));
           if(d < tam_celda/2)
             c[0]++;
         }
        }
       }
      }
  }
   
  void drawCamino(List<Node> L_cam) {
    stroke(0,0,255);
    strokeWeight(3);
    noFill();
    beginShape();
    for (Node N : L_cam) {
      vertex(N.y * tam_celda + tam_celda * 0.5, N.x * tam_celda + tam_celda * 0.5);
    }
    endShape();
    strokeWeight(1);
  }
}

import java.util.*;

class Grid {
  int rows, cols, num_nodos;
  float tam_celda;
  
  Node[][] nodos;
  List<Node> abiertos;
  List<Node> comprobados;
  List<Node> camino;
  
  Node ini;
  int listaIni[] = {};
  Node fin;
  int listaFin[] = {};
  Node actual;
  int id = 0;
  boolean inipuesto= false;
  boolean finpuesto = false;
     
  Grid(int rows, int cols, float tam_celda) {
    this.rows = rows;
    this.cols = cols;
    this.tam_celda = tam_celda;
    num_nodos = rows * cols;
    abiertos = new ArrayList<Node>();
    comprobados = new ArrayList<Node>();
    camino = new ArrayList<Node>();
    nodos = new Node[rows][cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        float r = random(1);
        if(r >= 0.8)
          nodos[i][j] = new Node(1, id, i, j);
        else
        nodos[i][j] = new Node(0, id, i, j);
        id++;
      }
    }
    while(!inipuesto)
    {
       ini = nodos[(int)random(rows)][(int)random(cols)];
       if (ini.num != 1)
         inipuesto = true;
    }
    
    while(!finpuesto)
    {
       fin = nodos[(int)random(rows)][(int)random(cols)];
       if (fin.num != 1)
         finpuesto = true;
    }
    abiertos.add(ini); 
  }
  
  Grid(String filename, float tam_celda) {
    BufferedReader reader = createReader(filename);
    String line = "";
    boolean configurado = false;
    IntList lista = new IntList();
    int rows = 0;
    int cols = 0;
    while (line != null) {
      try {
        line = reader.readLine();
      } catch (IOException e) {
        e.printStackTrace();
        line = null;
      }
      if (line != null) {
        if (!configurado) {
          cols = line.length();
          configurado = true;
        }
        for (int j = 0; j < cols; j++) {
          lista.append(Character.getNumericValue(line.charAt(j)));
        }
        rows++;
      }
    }
    this.rows = rows;
    this.cols = cols;
    this.tam_celda = tam_celda;
    num_nodos = rows * cols;
    nodos = new Node[rows][cols];
    abiertos = new ArrayList<Node>();
    comprobados = new ArrayList<Node>();
    camino = new ArrayList<Node>();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
          nodos[i][j] = new Node(lista.get(i * cols + j),id, i ,j);
          if(nodos[i][j].num == 2)
          {
            listaIni = append(listaIni,id);
          }
          else if (nodos[i][j].num == 3)
          {
            listaFin = append(listaFin,id);
          }
          id++;   
      }
    }
    int inirand = (int)listaIni[(int)random(listaIni.length)];
    int finrand = (int)listaFin[(int)random(listaFin.length)];
    
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
            if(nodos[i][j].id == inirand)
            {
              ini = nodos[i][j];
            }
            else if(nodos[i][j].id == finrand)
            {
              fin = nodos[i][j];
            }
      }
    }
    
    abiertos.add(ini);
  }
  

  
}

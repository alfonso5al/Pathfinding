import java.util.*;

class Node {
  int x, y;
  float f = 0;
  float g = 0;
  float h = 0;
  List<Node> vecinos;
  int num;
  Node previous = null;
  int id;
  
  Node (int num, int id, int x, int y)
  {
    this.num = num; 
    this.id = id;
    this.x = x;
    this.y = y;
    vecinos = new ArrayList<Node>();
  }

  void addVecinos(Node[][] nodos, int i, int j, int rows, int cols) {
    if (i < rows - 1) {
      vecinos.add(nodos[i + 1][j]);
    }
    if (i > 0) {
      vecinos.add(nodos[i - 1][j]);
    }
    if (j < cols - 1) {
      vecinos.add(nodos[i][j + 1]);
    }
    if (j > 0) {
      vecinos.add(nodos[i][j - 1]);
    }
    
    if (i > 0 && j > 0) {
      vecinos.add(nodos[i - 1][j - 1]);
    }
    if (i < rows - 1 && j > 0) {
      vecinos.add(nodos[i + 1][j - 1]);
    }
    if (i > 0 && j < cols - 1) {
      vecinos.add(nodos[i - 1][j + 1]);
    }
    if (i < rows - 1 && j < cols - 1) {
      vecinos.add(nodos[i + 1][j + 1]);
    }
  }
   
}

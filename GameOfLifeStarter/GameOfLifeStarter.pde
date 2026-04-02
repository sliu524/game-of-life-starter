import java.util.Arrays;

final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's

void setup() {
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(1); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];
  int row = grid.length;
  int col = grid[0].length;

  // STEP 1 - Populate initial grid (you may want to use Arrays.toString to check it)
  for (int i = 0; i < row; i ++){
    for (int j = 0; j < col; j++){
      int aliveOrDead = (int)(Math.random()*10)+1;
      //Density random
      if (aliveOrDead <= 10 * DENSITY){
        grid[i][j] = 1;
      }
    }
    
  }

}

void draw() {
  showGrid(); // STEP 2 - Implement this method so you can see your 2D array
  grid = calcNextGrid(); // uncomment this after you get showGrid() working
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  // your code here
  int rows = grid.length;
  int cols = grid[0].length;
  int n = 0;
  for (int y = 0; y < rows; y++){
    for (int x = 0; x < cols; x++){
      n = countNeighbors(y, x, rows, cols);
      if (grid[y][x] == 1){
        if ((n <= 1)||(n >= 4)){
          grid[y][x] = 0;
        }
      }
      else{
        if (n == 3){
          grid[y][x] = 1;
        }
      }
    }
  }
  return nextGrid;
}

int countNeighbors(int y, int x, int rows, int cols) {
  int n = 0; // don't count yourself!
  int left = 0;
  int right = 0;
  int top = 0;
  int bottom = 0;
  int topLeft = 0;
  int topRight = 0;
  int bottomLeft = 0;
  int bottomRight = 0;
  //top
  if (y > 0){
    if (grid[y-1][x] == 1){
      top = 1;
    }
  }
  //bottom
  if (y < rows - 1){
    if (grid[y+1][x] == 1){
      bottom = 1;
    }
  }
  //three left cells
  if (x > 0){
    if (grid[y][x-1] == 1){
      left = 1;
    }
    if (y > 0){
      if (grid[y-1][x-1] == 1){
        topLeft = 1;
      }
    }
    if (y < rows - 1){
      if (grid[y+1][x-1] == 1){
        bottomLeft = 1;
      }
    }
  }
  //three right cells
  if (x < cols - 1){
    if (grid[y][x+1] == 1){
      right = 1;
    }
    if (y > 0){
      if (grid[y-1][x+1] == 1){
        topRight = 1;
      }
    }
    if (y < rows - 1){
      if (grid[y+1][x+1] == 1){
        bottomRight = 1;
      }
    }
  }

  n = left + right + top + bottom + topLeft + topRight + bottomLeft + bottomRight;


  return n;
}

void showGrid() {
  // your code here
  // use square() to represent each cell
  for (int y = 0; y < height; y += SPACING){
    for (int x = 0; x < width; x += SPACING){
      square(x, y, SPACING);
      int row = y / SPACING;
      int col = x / SPACING;
      if (grid[row][col] == 1){
        fill(0, 255, 0);
      }
      else{
        fill(0, 0, 0);
      }
    }
  }
  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
  // each square (cell) has a width and height of SPACING. 
  // you will need to calculate the x and y position as you loop through the grid

}

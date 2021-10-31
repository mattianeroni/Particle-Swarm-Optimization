// PARAMETERS OF THE ALGORITHM
ArrayList<Particle> swarm;    // The swarm
int swarmSize = 10;           // The size of the swarm
float w = 1.0;                // The inertia
float C1 = 2.0;               // The weight of the personal best
float C2 = 2.0;               // The weight of the global best

// REPRESENTATION OF PARTICLES
int particleSize = 5;        // The size of the particles in the representation
float step = 0.05;           // The step of particles in the representation expressed as a percentage on the speed.
int translationX = - 500;    // How much the coordinates are translated on the right (left if negative) to make them fit inside the window.
int translationY = - 300;    // How much the coordinates are translated on the bottom (top if negative) to make them fit inside the window.

// BEST SOLUTION
PVector gbest;                // The global best
float bestCost;               // The cost of the global best


void setup() {
  size(1000, 600);
  
  // Initalise the swarm
  swarm = new ArrayList<Particle>(swarmSize);
  PVector middle = new PVector(width/2, height/2);
  for (int i = 0; i < swarmSize; i++){
    PVector v = new PVector(random(0, width), random(0, height));
    swarm.add(new Particle(middle, v));
  }
  
  // Initialise the global best solution
  gbest = middle.copy();
  bestCost = cost(gbest);
}



void draw () {
  background(180);
  
  // Draw the actual global bests
  //stroke(250, 0, 0);
  //fill(250, 0, 0);
  //circle(3.0 + translationX, 2.0 + translationY, 5);
  //circle(-2.805118 + translationX, 3.131312 + translationY, 5);
  //circle(-3.779310 + translationX, 2-3.283186 + translationY, 5);
  //circle(3.584428 + translationX, -1.848126 + translationY, 5);
  
  // Execute a step of the algorithm
  psoStep();
  
  // Draw the swarm 
  for (Particle p : swarm) 
    p.draw();
  
  // Draw the global best found so far
  fill(250, 0, 0);
  circle(gbest.x, gbest.y, 5);
  
  delay(100);
}


void psoStep () {
  PVector newBest = gbest;
  float newCost = bestCost;
  float currentCost;
  
  for (Particle p : swarm) {
    // Move particle
     p.move(gbest);
     
     // Eventually update the best solution found by the swarm
     currentCost = cost(p.current);
     if (currentCost < newCost){
         newCost = currentCost;
         newBest = p.current.copy();
     }
  }
  
  // Update the global best solution
  gbest = newBest; bestCost = newCost;
  print(bestCost, "\n");
}




float cost (PVector sol) {
   // Cost of the solution using Himmelblau's function
   float x = sol.x + translationX, y = sol.y + translationY; 
   return pow(pow(x,2) + y - 11, 2) + pow(x + pow(y, 2) - 7, 2); 
}

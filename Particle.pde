
class Particle {
  
  PVector current, pbest, gbest;  // The positions the particle knows
  PVector v;                      // The speed of the particle
  
  Particle (PVector current, PVector v) {
    this.current = current.copy(); 
    this.pbest = current.copy(); 
    this.gbest = current;
    this.v = v;
  }
  
  void draw () {
    // Draw a triangle rotated in the direction of velocity
    float theta = v.heading() + radians(90);
    fill(0, 0, 255);
    stroke(255);
    pushMatrix();
    translate(current.x, current.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -particleSize * 2);
    vertex(-particleSize, particleSize * 2);
    vertex(particleSize, particleSize * 2);
    endShape();
    popMatrix();
    
    // Draw the personal best
    fill(0, 120, 0);
    circle(pbest.x, pbest.y, 5);
  }
  
  void move (PVector gbest) {
    // Update the global best
    this.gbest = gbest;
   
    // Update the current position
    this.current.x += v.x * step;
    this.current.y += v.y * step;
    //this.current = PVector.add(this.current, this.v * step);
    
    // Update th personal best solution
    if (cost(current) < cost(pbest))
        this.pbest = current.copy();
    
    // Update the speed
    this.v.x = w * v.x + C1 * random(0, 1) * (pbest.x - current.x) + C2 * random(0, 1) * (gbest.x - current.x);
    this.v.y = w * v.y + C1 * random(0, 1) * (pbest.y - current.y) + C2 * random(0, 1) * (gbest.y - current.y);
  }
  
}

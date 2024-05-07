class Vehicle {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int id;
 
  Vehicle(float x, float y, int i) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 7.0;
    maxspeed = random(3,10);
    maxforce = random(0.1,0.5);
    id = i;
  }
  
  void run() {

    update();
    borders();
    display();
  }
  
  void update() {//bien
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {//bien
    acceleration.add(force);
  }
  
  
  void arrive(PVector target) {//bien
    PVector desired = PVector.sub(target,location);

    float d = desired.mag();
    desired.normalize();

    if (d < 100) {
      float m = map(d,0,100,0,maxspeed);
      desired.mult(m);
    } else {
      desired.mult(maxspeed);
    }
 
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    steer.mult(1.5);
    applyForce(steer);
  }
 
  
  void borders() {

  }
 
  void display() {
    float theta = velocity.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}

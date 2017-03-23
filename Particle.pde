class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean need_reborn;
  int lifespan;
  
  Particle(PVector l) {
    location = l;
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    need_reborn=true;
    lifespan=200*floor(particle_life_span.value);
  }

  void update() {
    lifespan--;
    velocity.add(acceleration);
    velocity.limit(0.5*particles_max_vel.value);
    location.add(velocity);
    acceleration.mult(0);
    
    if(location.x<0 || location.x>width || location.y<0 || location.y>height || lifespan<=0 || refresh_canvas){
      need_reborn=true;
    }
  }
 
  void display() {
    // prevent drawing at first frame
    if(lifespan>200*floor(particle_life_span.value)-1)return;
    
    stroke(0,20);
    colorMode(HSB, 100);
    color c;
    if(color_mode){
      // color_mode: direction
      
      float angle = abs(atan(velocity.y/velocity.x));
      if(angle>PI/4){
        angle=map(angle,PI/4,PI/2,3*PI/8,PI/2);
      }else{
        angle=map(angle,0,PI/4,0,PI/8);
      } 
      c=color(map(angle,0,PI/2,0,75),100,100,50);
    }else{
      // color_mode: location
      
      c=color(map(location.x,0,width,0,100),map(location.y,0,height,30,100) ,100,50);
    }
    fill(c);
   
    
    //ellipse(location.x,location.y,particle_radius.value,particle_radius.value);
    float r = -particle_radius.value*log(map(lifespan,0,200*particle_life_span.value,0.6,0.001));
    ellipse(location.x,location.y,r,r);
    colorMode(RGB,256);
    stroke(0);
  }
  
  void reborn(PVector new_seed){
    lifespan=200*floor(particle_life_span.value);
    location=new_seed;
    velocity=new PVector(0,0);
    need_reborn=false;
  }
  
  void applyForce(PVector f){
    acceleration.add(f);
  };
  
}
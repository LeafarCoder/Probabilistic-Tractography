Particle[] particles;
int n_particles=1000;
int n_cols=100;
int n_rows=100;
int cols;
int rows;
int vector_scale=40;
float x_unif;
float y_unif;
int n_seed_blocks;
float x_off, y_off;
boolean[][] seed = new boolean[n_cols][n_rows]; 
boolean update_reborn;
boolean menu_on=true;
boolean refresh_canvas=true;
boolean pause=false;

void setup() {
  //size(1000,600);
  fullScreen();

  cols=width/n_cols;
  rows=height/n_rows;
  n_seed_blocks=0;
  x_off=random(1000);
  y_off=random(1000);
  x_unif=0.4*field_anisotropy.value/100;
  y_unif=0.4*field_anisotropy.value/100;

  particles=new Particle[n_particles];
  for (int i=0; i<n_particles; i++)
    particles[i]=new Particle(new PVector(0, 0));
}

void draw() {
  if(pause){
    if (menu_on || menu_width>0)
      draw_menu();
    return;
  }
  
  if (refresh_canvas) {
    background(255);

    // REBORN PARTICLES
    if (n_seed_blocks>0) {
      for (int i=0; i<num_particles.value; i++) {
        PVector new_seed=new PVector(0, 0);
        int rand=floor(random(n_seed_blocks))+1;

        for (int k=0; k<n_cols && rand>0; k++)
          for (int j=0; j<n_rows; j++) {
            if (seed[k][j])rand--;
            if (rand<=0) {
              new_seed.x=random(k, k+1)*cols;
              new_seed.y=random(j, j+1)*rows;
              break;
            }
          }
        particles[i].reborn(new_seed);
      }
    }
    // UPDATE VARIABLES
    x_unif=0.5*(100-field_anisotropy.value)/100;
    y_unif=0.5*(100-field_anisotropy.value)/100;
    n_cols=floor(map(grid_zoom.value, 0, 100, 70, 10));
    n_rows=floor(map(grid_zoom.value, 0, 100, 70*height/width, 10*height/width));
    cols=width/n_cols;
    rows=height/n_rows;

    // SEED REGION
    for (int i=0; i<n_cols; i++)
      for (int j=0; j<n_rows; j++)
        if (seed[i][j]) {
          fill(250, 0, 0, 100);
          strokeWeight(1.5);
          rect(i*cols, j*rows, cols, rows);
          strokeWeight(1);
        }

    // GRID
    if (grid_on) {
      for (int i=0; i<=n_cols; i++)
        line(i*cols, 0, i*cols, height);
      for (int i=0; i<=n_rows; i++)
        line(0, i*rows, width, i*rows);
    }

    // GRADIENT VECTORS
    for (int i=0; i<n_cols; i++) {
      float mid_x=(i+.5)*cols;
      for (int j=0; j<n_rows; j++) {
        float mid_y=(j+.5)*rows;

        if (draw_dif_vectors) {
          float x_noise=noise_x((i+.5)*x_unif)*vector_scale;
          float y_noise=noise_y((j+.5)*y_unif)*vector_scale;
          arrowLine(mid_x-.5*x_noise, mid_y-.5*y_noise, mid_x+.5*x_noise, mid_y+0.5*y_noise, true);
          //fill(0);
          //text(x_noise,i*cols,j*rows+10);
          //text(y_noise,i*cols,j*rows+20);
        }
        if (!vectors_render)j++;
      }
      if (!vectors_render)i++;
    }

    refresh_canvas=false;
  }

  // Particles
  if(run_tractography)
  for (int i=0; i<num_particles.value; i++) {
    int x_loc=floor(particles[i].location.x/cols);
    int y_loc=floor(particles[i].location.y/rows);
    PVector force = new PVector(noise_x((x_loc+.5)*x_unif), noise_y((y_loc+.5)*y_unif));
    force.mult(0.5);

    particles[i].applyForce(force);
    particles[i].update();

    if (particles[i].need_reborn && n_seed_blocks>0) {
      PVector new_seed=new PVector(0, 0);
      int rand=floor(random(n_seed_blocks))+1;

      for (int k=0; k<n_cols && rand>0; k++)
        for (int j=0; j<n_rows; j++) {
          if (seed[k][j])rand--;
          if (rand<=0) {
            new_seed.x=random(k, k+1)*cols;
            new_seed.y=random(j, j+1)*rows;
            break;
          }
        }
      particles[i].reborn(new_seed);
    }

    if (n_seed_blocks>0) {
      particles[i].display();
      update_reborn=true;
    } else {
      if (update_reborn) {
        for (int k=0; k<n_particles; k++)
          particles[k].need_reborn=true;
        update_reborn=false;
      }
    }
  }
  

  if(!menu_on && menu_width>0){
    menu_width-=20;
    refresh_canvas=true;
  }
  if(menu_on && menu_width<fixed_menu_width){
    menu_width+=20;
    refresh_canvas=true;
  }
  if (menu_on || menu_width>0)
    draw_menu();
}


float noise_x(float x) {
  return map(noise(x_off+x), 0, 1, -1, 1);
}


float noise_y(float y) {
  return map(noise(y_off+y), 0, 1, -1, 1);
}



// MOUSE FUNCTIONS
void mouseClicked() {
  int x_seed=floor(mouseX/cols);
  int y_seed=floor(mouseY/rows);

  if (mouseButton==LEFT && x_seed<n_cols && y_seed<n_rows) {
    run_tractography=false;
    refresh_canvas=true;
    if (seed[x_seed][y_seed]) {
      seed[x_seed][y_seed]=false;
      n_seed_blocks--;
    } else {
      seed[x_seed][y_seed]=true;
      n_seed_blocks++;
    }
  }
}

void mouseDragged() {
  if ((menu_on && i_mouseX>menu_width) || !menu_on) {
    run_tractography=false;
    if (mouseX<cols*n_cols && mouseY<rows*n_rows && mouseX>0 && mouseY>0) {
      refresh_canvas=true;
      if (mouseButton==LEFT) {
        seed[floor(mouseX/cols)][floor(mouseY/rows)]=true;
      } else if (mouseButton==RIGHT) {
        seed[floor(mouseX/cols)][floor(mouseY/rows)]=false;
      }
    }
  }
}

void mousePressed() {
  left_mouse_pressed=(mouseButton==LEFT);
  i_mouseX=mouseX;
  i_mouseY=mouseY;
}


void mouseReleased() {
  left_mouse_pressed=false;

  // recount n_seed_blocks
  n_seed_blocks=0;
  for (int i=0; i<n_cols; i++)
    for (int j=0; j<n_rows; j++)
      if (seed[i][j])n_seed_blocks++;
}



void keyPressed() {
  refresh_canvas=true;

  if (key==CODED) {

    // if any arrow

    if (keyCode==UP)y_off-=0.5;
    if (keyCode==DOWN)y_off+=0.5;
    if (keyCode==LEFT)x_off-=0.5;
    if (keyCode==RIGHT)x_off+=0.5;
  } else {
    if (key=='V' || key=='v')
      if(!pause)
        draw_dif_vectors=!draw_dif_vectors;

    if (key=='C' || key=='c') {
      run_tractography=false;
      refresh_canvas=true;
      n_seed_blocks=0;
      for (int i=0; i<n_cols; i++)
        for (int j=0; j<n_rows; j++)
          seed[i][j]=false;
    }

    if (key=='R' || key=='r')
      vectors_render=!vectors_render;

    if (key=='G' || key=='g')
      if(!pause)
        grid_on=!grid_on;

    if (key=='M' || key=='m') {
      menu_on=!menu_on; 
    }
    
    if (key=='X' || key=='x') {
      color_mode=!color_mode;
      refresh_canvas=true;
    }
    
    if (key==ENTER) {
      run_tractography=!run_tractography;
    }
    
    if (key==' ') {
      refresh_canvas=false;
      pause=!pause;
    }
  }
}
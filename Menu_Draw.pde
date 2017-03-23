int fixed_menu_width=210;
int menu_width=fixed_menu_width;
int status_coord=70;
int part_coord=120;
int disp_dif_coord=280;
int options_coord=390;
int infos_coord=490;
int credits_coord=700;
boolean draw_dif_vectors=true;
boolean vectors_render=true;
boolean grid_on=true;
boolean run_tractography=false;
boolean color_mode=true;

Drag_Bar particle_radius = new Drag_Bar("Radius", "", 2, 20, 20, part_coord+40, 160, 8, true);
Drag_Bar num_particles = new Drag_Bar("Particles number", "", 1, 1000, 20, part_coord+70, 160, 200, true);
Drag_Bar particles_max_vel = new Drag_Bar("Maximum Velocity", "", 1, 10, 20, part_coord+100, 160, 5, true);
Drag_Bar particle_life_span = new Drag_Bar("Life_span", "", 1, 10, 20, part_coord+130, 160, 3, true);

Drag_Bar field_anisotropy = new Drag_Bar("Field Anisotropy", "%", 0, 100, 20, disp_dif_coord+100, 160, 80, true);

Drag_Bar grid_zoom = new Drag_Bar("Grid zoom", "%", 0, 100, 20, options_coord+50, 160, 10, true);

int min_menu(int x){
  return min(x,menu_width);
}

int map_x(int x){
  return floor(map(menu_width,0,fixed_menu_width,x-fixed_menu_width,x));
}

void draw_menu() {

  // UPDATE X_VALUES OF SLIDERS:
  particle_radius.x=map_x(20);
  num_particles.x=map_x(20);
  particles_max_vel.x=map_x(20);
  particle_life_span.x=map_x(20);
  field_anisotropy.x=map_x(20);
  grid_zoom.x=map_x(20);
  
  //particle_radius.enabled=!pause;
  //num_particles.enabled=!pause;
  //particles_max_vel.enabled=!pause;
  //particle_life_span.enabled=!pause;
  field_anisotropy.enabled=!pause;
  grid_zoom.enabled=!pause;
  
  // MENU
  strokeWeight(2);
  fill(255);
  rect(0, 0, menu_width, height);
  fill(0);
  textSize(32);
  text("Menu", map_x(55), 40);

  fill(255);
  strokeWeight(2);
  line(0, 50, map_x(fixed_menu_width), 50);
  strokeWeight(1);


  // STATUS
  fill(0);
  textSize(15);
  text("Status:", map_x(15), status_coord);
  textSize(12);
  if(pause){
    text("Simulation paused.", map_x(20), status_coord+15);
    textSize(10);
    text("Press SPACE to resume simulation.", map_x(25), status_coord+30);
  }else if (n_seed_blocks==0) {
    text("Select seed.", map_x(20), status_coord+15);
    textSize(10);
    text("Click or drag the mouse over", map_x(25), status_coord+30);
    text("the voxels to select them.", map_x(25), status_coord+40);
  } else {
    if (run_tractography) {
      text("Tractography running...", map_x(20), status_coord+15);
      textSize(10);
      text("Computing main fibers...", map_x(25), status_coord+30);
    } else {
      text("Seed selected. Waiting to run...", map_x(20), status_coord+15);
      textSize(10);
      text("Press [ENTER] to run tractography.", map_x(25), status_coord+30);
    }
  }



  // PARTICLES
  fill(0);
  line(0, part_coord-5, map_x(fixed_menu_width), part_coord-5);

  fill(0);
  textSize(15);
  text("Particles:", map_x(15), part_coord+10);

  num_particles.display();
  particle_radius.display();
  particles_max_vel.display();
  particle_life_span.display();

  // DISPLAY DIFUSION VECTORS

  fill(0);
  line(0, disp_dif_coord-20, map_x(fixed_menu_width), disp_dif_coord-20);

  fill(0);
  textSize(15);
  text("Difusion Map", map_x(10), disp_dif_coord);
  textSize(13);

  if(pause){fill(200);stroke(200);}else{fill(0);stroke(0);}
  text("Display difusion vectors:", map_x(20), disp_dif_coord+20);
  textSize(12);
  if (draw_dif_vectors) {
    text("Enabled (V)", map_x(40), disp_dif_coord+40);
    if(pause){fill(200);stroke(200);}else{fill(0);stroke(0);}
    rect(map_x(20), disp_dif_coord+30, 10, 10);
  } else {
    text("Disabled (V)", map_x(40), disp_dif_coord+40);
    if(pause){fill(255);stroke(200);}else{fill(255);stroke(0);}
    rect(map_x(20), disp_dif_coord+30, 10, 10);
  }

  fill(0);
  textSize(13);
  text("Render mode (R):", map_x(20), disp_dif_coord+60);
  textSize(12);
  if (vectors_render) {
    text("Quality", map_x(140), disp_dif_coord+60);
  } else {
    text("Fast", map_x(140), disp_dif_coord+60);
  }
  field_anisotropy.display();

  // OPTIONS
  fill(0);
  stroke(0);
  line(0, options_coord, map_x(fixed_menu_width), options_coord);

  textSize(15);
  text("Options", map_x(10), options_coord+20);
  grid_zoom.display();
  
  if(pause){fill(200);stroke(200);}else{fill(0);stroke(0);}
  text("Voxels' grid (G):", map_x(20), options_coord+70);
  textSize(12);
  if (grid_on) {
    text("ON", map_x(140), options_coord+70);
    if(pause){fill(200);stroke(200);}else{fill(0);stroke(0);}
    rect(map_x(120), options_coord+60, 10, 10);
  } else {
    text("OFF", map_x(140), options_coord+70);
   if(pause){fill(255);stroke(200);}else{fill(255);stroke(0);}
    rect(map_x(120), options_coord+60, 10, 10);
  }


  if(pause){fill(200);stroke(200);}else{fill(0);stroke(0);}
  text("Color mode (X):", map_x(20), options_coord+90);
  textSize(12);
  if (color_mode) {
    text("Direction", map_x(120), options_coord+90);
  } else {
    text("Location", map_x(120), options_coord+90);
  }
  
  
  // INFOS
  fill(0);
  stroke(0);
  line(0, infos_coord, map_x(fixed_menu_width), infos_coord);

  textSize(15);
  text("Commands", map_x(10), infos_coord+20);

  fill(0);
  textSize(12);

  text("ENTER: Run/stop tractography.", map_x(10), infos_coord+40);
  text("Left click: toggle voxel.", map_x(10), infos_coord+60);
  text("Left+Drag: add seed voxels.", map_x(10), infos_coord+80);
  text("Right+Drag: remove seed voxels.", map_x(10), infos_coord+100);
  text("Arrows: move around.", map_x(10), infos_coord+120);
  text("C: clear seed voxels.", map_x(10), infos_coord+140);
  text("SPACE: stop/resume tratography.", map_x(10), infos_coord+160);
  text("M: show/hide menu.", map_x(10), infos_coord+180);
  text("ESC: leave.", map_x(10), infos_coord+200);

  // CREDITOS
  fill(0);
  stroke(0);
  line(0, credits_coord, map_x(fixed_menu_width), credits_coord);


  fill(0);
  textSize(12);
  text("Simulation built in the scope of", map_x(10), credits_coord+20);
  text("the Physiology project (2016).", map_x(10), credits_coord+35);
  text("Institutions: IST / FML", map_x(10), credits_coord+50);
  text("Last version: December 2016", map_x(10), credits_coord+65);
}
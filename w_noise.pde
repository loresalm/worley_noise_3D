
int nb_points = 3;
int side_cube = 15;
int walk_speed = 50;

int select_close = 0;
float xoff = 0;
float xincrement = 0.01;

PVector [] points = new PVector[nb_points];
PVector [] point_cube = new PVector[side_cube*side_cube*side_cube];

void setup(){
  size(700,700,P3D);

  for(int i = 0; i<points.length; i++){
    points[i] = new PVector(width/2. , height/2,-side_cube/2*100);
    
  }
  int count = 0;
 for(int x = 0; x<side_cube; x++){
    for(int y = 0; y<side_cube; y++){
      for(int z = 0; z<side_cube; z++){
      
       //pushMatrix();
       //translate(x*100,y*100,-z*100);
       
        //popMatrix();     
        point_cube[count] = new PVector(x*100,y*100,-z*100);
        count++;
            
      }
    }
  }
  
}
void draw(){
  background(0);
   
   //translate((width-side_cube*100)/2.,(height-side_cube*100/2.),10);
  
  
  for(PVector v : points){
    v.x+=random(-walk_speed,walk_speed);
    v.y+=random(-walk_speed,walk_speed);
    v.z+=random(-walk_speed,walk_speed);
    if (mousePressed) {
           lights();
        }
    pushMatrix();
        translate(v.x,  v.y,  v.z);
        noStroke();
        fill(200,20,200);
       
         sphere(20);
        popMatrix();
    //stroke(200,20,200);
    //strokeWeight(8);
    //point(v.x,v.y,v.z);
   
  }
    
       
  
  
  
  //draw_cube();
  
  camera(mouseX*10, -mouseY*10, 1700,
           width/2., height/2., 0,
           0.0, 1.0, 0.0);
        textSize(40);
 for(int i=0; i < point_cube.length; i++ ){
   float[] dist_now = generate_distances(point_cube[i].x,point_cube[i].y,point_cube[i].z); 
   if (mousePressed) {
           lights();
        }
        pushMatrix();
        translate(point_cube[i].x,  point_cube[i].y,  point_cube[i].z);
        noStroke();
        
        fill(map(dist_now[select_close],100,1000,100,200),map(dist_now[select_close+1],100,1000,0,200),map(dist_now[select_close+2],100,1000,200,0));
       
         sphere(map(dist_now[select_close],100,1000,5,100));
        popMatrix();
        //stroke(dist_now[select_close],dist_now[select_close],dist_now[select_close]);
        //strokeWeight(8);
        //point(point_cube[i].x,point_cube[i].y,point_cube[i].z);
 }

  /*
  loadPixels();
  for(int x = 0; x<width; x++){
    for(int y = 0; y<height ; y++){
      int index =  x+ y*width;
      float[] dist_now = generate_distances(x,y); 
      
      pixels[index]= color(dist_now[select_close],dist_now[select_close],dist_now[select_close]);
      
    }
  }
  updatePixels();
  draw_points();
  */
}

void draw_points(){
  for(PVector v : points){
    v.x+=random(-1,1);
    v.y+=random(-1,1);
    stroke(0,255,0);
    strokeWeight(8);
    point(v.x,v.y);
    xoff += xincrement;
  }
}

void draw_cube(){
   for(int x = 0; x<side_cube; x++){
    for(int y = 0; y<side_cube; y++){
      for(int z = 0; z<side_cube; z++){
        pushMatrix();
        noStroke();
        translate(x + 40,y + 40, z);
        fill(255);
        sphere(5);
        resetMatrix();
        popMatrix();   
       
      }
    }
  }
}

float[] generate_distances(float x, float y, float z){
  float [] dist_list = new float [points.length];
  for(int i = 0; i<points.length; i++){
    dist_list[i] = dist(x,y,z,points[i].x,points[i].y,points[i].z);
  }
  return sort(dist_list);
}

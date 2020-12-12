boolean left_mouse_pressed;
int i_mouseX,i_mouseY;

class Drag_Bar{
  int x,y,w;
  float min,max;
  float value;
  boolean enabled,locked=false;
  String title,type;
  float size=10;
  
  Drag_Bar(String t,String type_,float a,float b,int x_,int y_,int w_,float v,boolean e){
    min=a;
    max=b;
    type=type_;
    x=x_;
    y=y_;
    w=w_;
    value=v;
    enabled=e;
    title=t;
  }

  void display(){
    if(enabled)update();
    if(enabled){
      fill(0);
      stroke(0);
    }else{
      fill(200);
      stroke(200);
    }
    textSize(12);
    text(title+": "+floor(value)+type,x,y-10);
    line(x,y,x+w,y);
    ellipse(x+map(value,min,max,0,w),y,size,size);
    //rect(x+map(value,min,max,0,w)-size/2,y-size/2,size,size);
  }

  boolean isOn(int x_,int y_){
    float xx=x+map(value,min,max,0,w)-size/2;
    return(x_>xx && x_<xx+size && y_<y+size/2 && y_>y-size/2);
  }
  
  void update(){
    
    if(left_mouse_pressed){
      if(isOn(i_mouseX,i_mouseY))locked=true;
      }else{
      locked=false;
   }
    
    if(locked){
      value=map(mouseX,x,x+w,min,max);
      if(value>max)value=max;
      if(value<min)value=min;
      
      if(title!="Radius" && title!="Particles number" && title!="Maximum Velocity" && title!="Life_span")
        refresh_canvas=true;
    }
  }
}
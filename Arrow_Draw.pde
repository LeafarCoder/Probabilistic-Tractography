void arrowLine(float x0, float y0, float x1, float y1, boolean solid)
{
  line(x0, y0, x1, y1);
  if(vectors_render){
    
    float lineAngle=atan2(y0-y1,x0-x1);
    float x2;
    float y2;
    float x3;
    float y3;
  
    x2 = x1 + 4*cos(lineAngle + radians(30));
    y2 = y1 + 4*sin(lineAngle + radians(30));
    x3 = x1 + 4*cos(lineAngle - radians(30));
    y3 = y1 + 4*sin(lineAngle - radians(30));
    if (solid)
    {triangle(x1, y1, x2, y2, x3, y3);
    }else{
      line(x1, y1, x2, y2);
      line(x1, y1, x3, y3);
    } 
    
  }else{
    
    ellipse(x1,y1,3,3);
  
  }
}

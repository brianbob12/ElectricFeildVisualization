class LineCharge{
  float charge;
  PVector pos1;
  PVector pos2;
  PVector a2b;
  float angleWithHorizon;
  float len;

  LineCharge(float x1,float y1,float x2, float y2, float charge){
    //+0.01 avoids zero error when calculating feilds at pixels
    this.pos1=new PVector(x1+0.01,y1+0.01);
    this.pos2=new PVector(x2+0.01,y2+0.01);
    this.charge=charge;
    
    
    PVector a2b=PVector.sub(pos2,pos1);
    this.angleWithHorizon=a2b.heading();
    this.len=a2b.mag();
    this.a2b=a2b;
    
    
  }
  
  void show(){
    
    stroke(255);
    fill(255,255,255);
    line(this.pos1.x,this.pos1.y,this.pos2.x,this.pos2.y);
  }
  
  PVector getCenter(){
    return(PVector.div(PVector.add(this.pos1,this.pos2),2));
  }
  float getCharge(){return (this.charge);}
}

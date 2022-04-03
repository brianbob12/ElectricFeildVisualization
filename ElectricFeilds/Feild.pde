class Feild{
  float permitivity;
  float k;
  ArrayList<PointCharge> pointCharges=new ArrayList<PointCharge>();
  ArrayList<LineCharge> lineCharges=new ArrayList<LineCharge>();
  Feild(float permitivity){
    this.permitivity=permitivity;
    this.k=1/(4*3.1415926535897*permitivity);
  }
  
  void addPointCharge(PointCharge p){
    this.pointCharges.add(p);
  }
  void addLineCharge(LineCharge l){
    this.lineCharges.add(l);
  }
  
  PVector getFeildAtPosition(PVector pos){
    PVector feild=new PVector(0,0);
    for(int i=0;i<this.pointCharges.size();i++){
      PointCharge myPC=this.pointCharges.get(i);
      PVector r=PVector.sub(pos,myPC.getPos());
      float distance=r.mag();
      r.normalize();
      if(distance!=0){
        feild.add(PVector.mult(r,(this.k*myPC.getCharge())/(distance*distance)));
      }
    }
    for(int i=0;i<this.lineCharges.size();i++){
      LineCharge myLC=this.lineCharges.get(i);
      float c=myLC.angleWithHorizon;
      
      //find shortest distance to line
      //minium of perpenduclar angle from a, distance from a, distance from b
      PVector aToPos=PVector.sub(pos,myLC.pos1);
      float angle_pos_A_B=PVector.angleBetween(aToPos,myLC.a2b);
      float b;
      float distanceToA=aToPos.mag();
      float distanceToB=PVector.sub(pos,myLC.pos2).mag();
      float s;
      if(angle_pos_A_B==c || angle_pos_A_B-c==PI){
        b=min(distanceToA,distanceToB);
        s=distanceToA;
      }
      else{
        float perpendicularDistance=abs(aToPos.mag()*sin(angle_pos_A_B));
        //check if perpenduclar point is on the line
        if(sq(distanceToA)-sq(perpendicularDistance)<sq(myLC.len) && sq(distanceToB)-sq(perpendicularDistance)<sq(myLC.len)){
          b=perpendicularDistance;
        }
        else{
          b=min(distanceToA,distanceToB);
        }
        
        s=sqrt(sq(distanceToA)-sq(perpendicularDistance));
      }
      
      
      float xComp=((sin(c-atan(b/(s))))-(sin(c-atan(b/(s-myLC.len)))))/b;
      float yComp=-((cos(c-atan(b/(s))))-(cos(c-atan(b/(s-myLC.len)))))/b;
      PVector tad=new PVector(xComp,yComp);
      tad.mult(this.k*myLC.getCharge()*(1/myLC.len));
      feild.add(tad);
    }
    return (feild);
  }
}


int n=10;
float deltaT=0.00005;

ArrayList<PointCharge> pointCharges=new ArrayList<PointCharge>();
ArrayList<LineCharge> lineCharges=new ArrayList<LineCharge>();
Feild f= new Feild(8.85418782E-12);

void setup(){
  size(1024,1024);
  
  for(var i=0;i<n;i++){
    PointCharge pc=new PointCharge(100+(float(i)/float(n))*100,512,1f/float(n),1);
    pointCharges.add(pc);
    f.addPointCharge(pc);
  }
  
  /*
  for(var i=0;i<n/2;i++){
    PointCharge pc=new PointCharge(random(1024),random(1024),1,1);
    pointCharges.add(pc);
    f.addPointCharge(pc);
  }
  for(var i=0;i<n/2;i++){
    PointCharge pc=new PointCharge(random(1024),random(1024),-1,1);
    pointCharges.add(pc);
    f.addPointCharge(pc);
  }
  */
  
  LineCharge a=new LineCharge(100,100,200,100,1);
  lineCharges.add(a);
  f.addLineCharge(a);
  //lineCharges.add(new LineCharge(100,120,200,120,1));
  
  println(f.getFeildAtPosition(new PVector(150,150)));
}

void draw(){
  background(0);
  //show feild
  colorMode(HSB,2*PI,100,100);
  for(var i=0;i<1024;i++){
    for(var j=0;j<1024;j++){
      PVector feildVal=f.getFeildAtPosition(new PVector(i,j));
      set(i,j,color(PI-feildVal.heading(),100,feildVal.mag()*1/20000));
    }
  }
  
  
  //show points
  colorMode(RGB,255);
  for(var i=0;i<n;i++){
    PointCharge pc=pointCharges.get(i);
    pc.move(f,deltaT);
    pc.show();
  }
  
  //show lines
  for(var i=0;i<lineCharges.size();i++){
    LineCharge lc=lineCharges.get(i);
    lc.show();
  }
  
  //saveFrame("A4/####.png");
  noLoop();
}

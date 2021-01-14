
//---------------------------------------------------------------------------------------------------------------------

PImage frame, frameCourant;

float [][] FrameZero = new float[640][360];
float [][] FramePrecedent = new float[640][360];
float [][] FrameCourant = new float[640][360];
ArrayList<PImage> FRAMES  = new ArrayList();

float [][] GxPrecedent = new float[35][57];
float [][] GxCourant = new float[35][57];
float [][] GyPrecedent = new float[35][57];
float [][] GyCourant = new float[35][57];

int [] hpPrecedent = new int[180];
int [] hpCourant = new int[180];

int [] hnPrecedent = new int[180];
int [] hnCourant = new int[180];

int [][] thetaPrecedent = new int[35][57];
int [][] thetaCourant = new int[35][57];

int i,j,k,loc,w=640,h=360,nbClick=0;
int xCourant=326, yCourant=161 ,xPrecedent,yPrecedent,x,y,xmin=0,ymin=0 ;
float hBallon=35, wBallon=57 , somme=0 ;
float r,g,b;
double dis , disMin;
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

void setup() {
  size(640, 360);  
  
  for (int im = 1; im < 10; im++) {
      frame = loadImage("boltR/0000000"+im+".jpg");      
      FRAMES.add(frame);  
   }
   
  for (int im = 10; im <100 ; im++) {
      frame = loadImage("boltR/000000"+im+".jpg");      
      FRAMES.add(frame);  
   }
   
     for (int im = 100; im <350 ; im++) {
      frame = loadImage("boltR/00000"+im+".jpg");      
      FRAMES.add(frame);  
   }
   
  FRAMES.get(nbClick).loadPixels();
  frameCourant= FRAMES.get(nbClick);
   loadPixels();
     
        for (int x = 0; x < w; x++ ) {
            for (int y = 0; y < h; y++ ) {
             loc = x + y*w;
             
           r = red (frameCourant.pixels[loc]);
           g = green (frameCourant.pixels[loc]);
           b = blue (frameCourant.pixels[loc]);
           
           int c = color(r,g,b) ;
           float brightness = brightness(c);
           FrameCourant[x][y] = brightness;
           FrameZero[x][y] = brightness;
           }
        }
        
        
}
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

void draw(){
 
  //afficher l'image courante
   
  for(i=0 ; i < frameCourant.width ; i++){
    for(j=0 ; j < frameCourant.height ; j++){
        loc= i+j*width;      
        pixels[loc]=color(FrameCourant[i][j] );
    }
  }
  
  updatePixels();
  
  //Dessiner le rectangle
  noFill();
  stroke(0,255,0);
  rect(xCourant,yCourant,hBallon, wBallon);

}

//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

void mousePressed(){
  
  nbClick++;
  if(nbClick == 350) { exit();}
  else{
  
    
      for (int x = 0; x < w; x++ ) {
            for (int y = 0; y < h; y++ ) {
              FramePrecedent[x][y] =FrameCourant[x][y];
            }
      }
   // Brightness de l'image nbclick
        FRAMES.get(nbClick).loadPixels();
        frameCourant= FRAMES.get(nbClick);
        
        for (int x = 0; x < w; x++ ) {
            for (int y = 0; y < h; y++ ) {
             loc = x + y*w;
             
           r = red (frameCourant.pixels[loc]);
           g = green (frameCourant.pixels[loc]);
           b = blue (frameCourant.pixels[loc]);
           
           int c = color(r,g,b) ;
           pixels[loc] =c;
           float brightness = brightness(c);
           FrameCourant[x][y] = brightness;
           }
        }
       // Mise à jour de xCourant , yCourant
       xPrecedent = 326;
       yPrecedent = 161;
       
       //calculer distancemin
       somme=0;
    
       Gx(FrameZero,GxPrecedent,xPrecedent,yPrecedent);
       Gy(FrameZero,GyPrecedent,xPrecedent,yPrecedent); 
       Angles(GxPrecedent,GyPrecedent,thetaPrecedent);
       Histogramme(thetaPrecedent,hpPrecedent,hnPrecedent);
       
       Gx(FrameCourant,GxCourant,xPrecedent,yPrecedent);
       Gy(FrameCourant,GyCourant,xPrecedent,yPrecedent); 
       Angles(GxCourant,GyCourant,thetaCourant);
       Histogramme(thetaCourant,hpCourant,hnCourant);
     
       somme=0;
       for(i=0 ; i < 180; i++){
               somme = somme + pow((hpCourant[i] -hpPrecedent[i]),2)+pow((hnCourant[i] -hnPrecedent[i]),2);
         }
         
       disMin = Math.sqrt(somme);
       xmin = xPrecedent;
       ymin = yPrecedent;
 
      
       //calculer distance 
        for(x= xPrecedent-25; x < xPrecedent+25 ; x++){
              for(y= yPrecedent-25 ; y < yPrecedent+25 ; y++){
                 somme=0;
                 Gx(FrameCourant,GxCourant,x,y);
                 Gy(FrameCourant,GyCourant,x,y); 
                 Angles(GxCourant,GyCourant,thetaCourant);
                 Histogramme(thetaCourant,hpCourant,hnCourant);
                 somme=0;
                                        
                 for(i=0 ; i < 180; i++){
                     somme = somme + pow((hpCourant[i] -hpPrecedent[i]),2)+pow((hnCourant[i] -hnPrecedent[i]),2);
                  }
                 
                 dis= Math.sqrt(somme);
                 if(dis < disMin){disMin = dis ; xmin=x ;ymin=y;}
              }
        }
         
         
        xCourant = xmin;
        yCourant = ymin;
     }
     
     
    
}
//----------------------------------------------------------------------------------------------------------------------

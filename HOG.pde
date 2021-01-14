void Gx(float Frame[][],float [][] Gx , int x1 ,int y1 ){
  int x2=x1+35 , y2=y1+57;
  for(i=x1 ; i < x2 ; i++){
    for(j=y1 ; j < y2 ; j++){
    
      if(i-1 < 0){
        Gx[i-x1][j-y1]=Frame[i+1][j];
      }
      else if(i+1>=640) {
        Gx[i-x1][j-y1]=Frame[i-1][j];
      }
      else Gx[i-x1][j-y1]=Frame[i+1][j] - Frame[i-1][j];
      
    }
  }

}
void Gy(float Frame[][],float [][] Gy ,int x1 ,int y1){
  int x2=x1+35 , y2 =y1+57;
  
  for(i=x1 ; i < x2 ; i++){
    for(j=y1 ; j < y2 ; j++){
      
      if(j-1 < 0){
        Gy[i-x1][j-y1]=Frame[i][j+1];
      }
      else if(j+1>=360) {
        Gy[i-x1][j-y1]=Frame[i][j-1];
      }
      else Gy[i-x1][j-y1]=Frame[i][j+1] - Frame[i][j-1];
      
    }
  }
}
void Angles(float [][] Gx, float [][] Gy, int [][]theta){
  
  for(i=0 ; i < 35 ; i++){
    for(j=0 ; j < 57 ; j++){
       theta[i][j] = int(degrees(atan(Gy[i][j]/Gx[i][j])));
    }
  }

}


void Histogramme(int [][]theta,int[]hp,int[]hn){
  
    for(int i = 0 ; i < 180 ; i++ ) {
      hp[i]=0;
      hn[i]=0;
    }
  
  for(int i = 0 ; i < 35 ; i++ ) {
      for (int j = 0 ; j < 57 ; j++){
       if(theta[i][j] < 0){
      
            hn[-theta[i][j]] ++;
       }
       else {
           hp[theta[i][j]]++;
       }
      }
}
}

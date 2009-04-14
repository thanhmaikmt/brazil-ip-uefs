#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define RAND_MAX 2147483647

 double randDouble(double low, double high) {
    double temp;
 
    /* swap low & high around if the user makes no sense */
    if (low > high) {
       temp = low;
       low = high;
       high = temp;
    }
    
    /* calculate the random number & return it */
    temp = (rand() / ((double)(RAND_MAX) + 1.0)) * (high - low) + low;  
 
    return temp;
 }


double reesc(unsigned char idx, unsigned coef){
  //printf("chegou aqui");
  unsigned char sf=0;
  double res;
  double table[255];
  while(sf!=255){
//  for(sf=0;sf<256;sf++){
//     if(sf!=0 && (sf%4==0)){
//       printf("\n");
//     }
    //printf("sf=%d,gain=%.16f\t",sf,pow(2,((sf-156)*0.25)));
    table[sf]=pow(2,((sf-156)*0.25));
     if(sf==255) {
//       printf("chegou aqui");
//       getchar();
       break;
     }
    sf=sf+1;
  }
  res=(table[idx]*coef);
  printf("C-> gain=%.15f || coef=%u || res=%.8f\n\n",table[idx],coef,res);
  return(res);

  
}


 int main(int argc, char *argv[]){
       unsigned char sf=atoi(argv[1]);
       unsigned cf=atoi(argv[2]);
       /*printf("sf=%d,gain=%.16f\n",sf,*/reesc(sf,cf);
       exit(0);
 }
 
 

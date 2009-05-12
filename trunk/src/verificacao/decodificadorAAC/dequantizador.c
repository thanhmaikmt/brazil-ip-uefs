/***************************************************************************
 *   Copyright (C) 2009 by eder   *
 *   eder@linux-pzu3   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/


#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double cuberoot( unsigned short int x_quant){
  
  double n=2;
  int i;
  //printf("n=%f\n",n);
  for(i=0;i<15;i++){
      //printf("n[%d]=%f\n",i,n);
      n=0.333333333333*(n*2+(x_quant/pow(n,2)));
  }
  
  return n;
}


double dequantiza(int idx){
  unsigned short int i=0;
  double table[8192];
  while(i!=8192){
    table[i]=cuberoot(i)*i;
    //printf("%d - %.16f\n",i,table[i]);
    i=i+1;
  }
  
  return table[idx];
}
    

/*
int main(int argc, char *argv[])
{
  //printf("Hello, world!\n");
	if(argc<2)
	{
		printf("Uso: dequant <numero a ser dequantizado>\n");
		return 0;
	}
	else
	{
		int cin = atoi(argv[1]);
		printf("Resultado=%f\n",dequantiza(cin));
		
	}
	
	
	
	
	
  return EXIT_SUCCESS;
}
*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct{
	int x, y;
} point;

int area(point a, point b, point c);

int isin(point a, point b, point c, point d);

int main(){	
	FILE * f = fopen("numeros.txt","r");
	FILE * res = fopen("resultadoc.txt","w");
	
	char c[2], aux, r;
	int i,j, k;
	point p[3];
	if(f == NULL){
		printf("Arquivo não encontrado."); 
		return 0;
	}
	while(!feof(f)){
		if (!fread(&aux,1,1,f)) 
			break;		
		fseek(f, -1, SEEK_CUR);
		for(i = 0; i < 4; i++){
			for(j = 0; j < 3; j++){
				fread(&aux, sizeof(char),1,f);
				c[j] = aux;
			}

			fseek(f, 1, SEEK_CUR);

			k = atoi(c);
			p[i].x = k;		
			for(j = 0; j < 3; j++){
				fread(&aux, sizeof(char),1,f);
				c[j] = aux;
			}
			fseek(f, 1, SEEK_CUR);

			k = atoi(c);
			p[i].y = k;
		}
		if(isin(p[0], p[1], p[2], p[3])){
			r=49;
		}else{
			r=48;
		}
		fwrite(&r,sizeof(char),1,res);
			r=10;							
		fwrite(&r,sizeof(char),1,res);
	}
	fclose(res);
	fclose(f);
	return 0;
}

int area(point a, point b, point c){
	return abs((a.x*(b.y-c.y) + b.x*(c.y-a.y) + c.x*(a.y-b.y)));
}

int isin(point a, point b, point c, point d){
	int total = area(a,b,c);
	int A1 = area(a,c,d);
	int A2 = area(a,b,d);
	int A3 = area(c,d,b);
	if(A1+A2+A3 == total){
		return 1;
	}else{
		return 0;
	}
}


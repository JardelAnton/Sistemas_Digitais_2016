#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct{
	int x, y;
} point;

int area(point a, point b, point c);

int isin(point a, point b, point c, point d);

int main(int argc,char *argv[]){//No momento da execução do programa deve ser inserido logo após o nome do arquivo que contenha os trinagulos os quais deseja verificar.

	fILE * f = fopen(argv[1],"r");
	if(f == NULL){
		printf("Arquivo não encontrado."); 
		return 0;
	}
	char c[2], aux;
	int i,j, k;
	point p[3];
	while(!feof(f)){ // enquanto não encontra o fim do arquivo, continua lendo e verificando.
		if (!fread(&aux,1,1,f)) break;
		fseek(f, -1, SEEK_CUR);
		for(i = 0; i < 4; i++){
			for(j = 0; j < 3; j++){
				fread(&aux, sizeof(char),1,f);
				c[j] = aux;
			}
			fseek(f, 1, SEEK_CUR);
			k = atoi(c);//a função atoi converte uma string em inteiro, desde que o conteudo da string sejam numeros na forma de caracter(char)
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
			printf("in\n");
		}
		else{
			printf("out\n");
		}
	}
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

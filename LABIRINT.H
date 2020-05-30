

//Funcoes para serem incluidas no arquivo do jogo LABIRINT

void janela(int xi,int yi,int xf,int yf,int radius,int norte,int leste,int sul,int oeste,int cor)
{
  int aux;

  setfillstyle(SOLID_FILL,cor);
  bar(xi,yi,xf,yf);

  setcolor(WHITE);
  for(aux=0;aux<radius;aux++) line(xi+aux,yi+aux,xf-aux,yi+aux);
  for(aux=0;aux<radius;aux++) line(xi+aux,yi+aux,xi+aux,yf-aux);

  setcolor(DARKGRAY);
   for(aux=0;aux<radius;aux++) line(xi+aux,yf-aux,xf-aux,yf-aux);
   for(aux=0;aux<radius;aux++) line(xf-aux,yi+aux,xf-aux,yf-aux);

  setfillstyle(SOLID_FILL,BLACK);
  bar(xi+oeste,yi+(norte-1),xf-leste,yf-(sul-1));

  setcolor(DARKGRAY);
   for(aux=0;aux<radius;aux++)
    line((xi+oeste)+aux,(yi+(norte-1))+aux,(xf-leste)-aux,(yi+(norte-1))+aux);
   for(aux=0;aux<radius;aux++)
    line((xi+oeste)+aux,(yi+(norte-1))+aux,(xi+oeste)+aux,(yf-(sul-1))-aux);

  setcolor(WHITE);
   for(aux=0;aux<radius;aux++)
    line((xi+oeste)+aux,(yf-(sul-1))-aux,(xf-leste)-aux,(yf-(sul-1))-aux);
   for(aux=0;aux<radius;aux++)
    line((xf-leste)-aux,(yi+(norte-1))+aux,(xf-leste)-aux,(yf-(sul-1))-aux);
}

void tresd(int xi,int yi,int xf,int yf,int rad,int prof,int cor)
{
  int aux,color1,color2;

  setfillstyle(SOLID_FILL,cor);
  bar(xi,yi,xf,yf);

  if (prof==1) { color1=WHITE;color2=DARKGRAY; }
    else { color1=DARKGRAY;color2=WHITE; }

  setcolor(color1);
  for(aux=0;aux<rad;aux++)
    line(xi+aux,yi+aux,xf-aux,yi+aux);

  setcolor(color1);
  for(aux=0;aux<rad;aux++)
    line(xi+aux,yi+aux,xi+aux,yf-aux);

  setcolor(color2);
  for(aux=0;aux<rad;aux++)
    line(xi+aux,yf-aux,xf-aux,yf-aux);

  setcolor(color2);
  for(aux=0;aux<rad;aux++)
    line(xf-aux,yi+aux,xf-aux,yf-aux);
}

void putstring(int x, int y, char *str)
{
 setcolor(BLACK);
 outtextxy(x+2,y+3,str);
 setcolor(WHITE);
 outtextxy(x,y,str);
}

int barra_vertical(int x1,int y1,int x2,int y2,int salt,int max)
{
 char letra;
 int xi=x1,yi=y1,xf=x2,yf=y2,salto=salt,pos=0;

 setwritemode(XOR_PUT);

 while (1)
 {
  rectangle(xi,yi,xf,yf);
  letra=getch();
  if (letra==0) letra=getch();
   else
   if (letra==13)   /*ENTER*/
    { setwritemode(COPY_PUT);return pos; }
    else
     if (letra==27) /*ESC*/
      {
       rectangle(xi,yi,xf,yf);
       setwritemode(COPY_PUT);return -1;
      }
  if ( (pos>0)&&(letra==72) )/*CIMA*/
   {
    rectangle(xi,yi,xf,yf);
    yi=yi-salto; yf=yf-salto; pos--;
   }
  else
   if ( (pos<max)&&(letra==80) )/*BAIXO*/
    {
     rectangle(xi,yi,xf,yf);
     yi=yi+salto; yf=yf+salto; pos++;
    }
   else
    rectangle(xi,yi,xf,yf);
 }
 setwritemode(COPY_PUT);
 return (pos);
}

void drawcheck(int xi,int yi,int cor)
{
 setcolor(cor);
 setlinestyle(SOLID_LINE,0,4);
 line(xi,yi,xi+38,yi-38);
 line(xi,yi,xi-10,yi-13);
 setlinestyle(SOLID_LINE,0,3);
}

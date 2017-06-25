function I = recortar(imagen_Final)
[Alto_Matriz, Ancho_Matriz]=find(imagen_Final==1);
Alto_M1=min(Alto_Matriz); 
Alto_M2=max(Alto_Matriz); 
Ancho_M1=min(Ancho_Matriz);
Ancho_M2=max(Ancho_Matriz);
Alto_Final=Alto_M2-Alto_M1;
Ancho_Final=Ancho_M2-Ancho_M1;
I=imcrop(imagen_Final, [Ancho_M1 Alto_M1 Ancho_Final Alto_Final]);
%{
F�rat �niversitesi Teknoloji Fak�ltesi Yaz�l�m M�hendisli�i
Say�sal G�r�nt� ��leme Dersi Projesi

�srafil �Z�K
14545029
%}

import java.awt.Robot;
import java.awt.event.*

fare = Robot;

screen = get(0, 'screensize');
vid=videoinput('winvideo',1,'YUY2_640x480'); %video giri� sat�r�

set(vid,'ReturnedColorSpace','rgb'); %renk kompozisyonunu de�i�tir

preview(vid); %kameray� a�
pause(2);

while 1 
    imge=getsnapshot(vid); %tekil video karesi alma
    %K�rm�z� nesneyi tan�ma yap�yoruz. Bunu da imge_2 isimli de�i�kene
    %at�yoruz.
    %K�rm�z� bile�eni ay�rma i�lemi
    renk_k= imsubtract(imge(:,:,1), rgb2gray(imge));
    
    %Mavi bile�eni ay�rma i�lemi
    renk_m= imsubtract(imge(:,:,3), rgb2gray(imge));
    
    %G�r�lt� filtresi i�lemi i�in 2-D medyan filtresini kullanma
    imge_2 = medfilt2(renk_k, [3 3]);
    
    renk_2 = medfilt2(renk_m, [3 3]);
    
    %Varolan gri tonlu resmi binary resme d�n��t�rme.
    imge_2 = im2bw(imge_2, 0.27);%0.26 de�eri denenerek bulunmu�tur.
    renk_2 = im2bw(renk_2, 0.32);
    
    imshow(imge_2);
    pause(0.05);
    
    [B,L,N]= bwboundaries(imge_2,'noholes');
    %A��rl�k merkezi hesab�. Dizi olarak sonu� d�necektir.
    a = regionprops(L,'centroid');
    
    [P,Q,R]=bwboundaries(renk_2,'noholes');
    b=regionprops(Q,'centroid');
    
    if N>= 1 && R==0
        
        %Farenin hareketi
        fare.mouseMove(1600-(a(1).Centroid(1,1)*(5/2)),(a(1).Centroid(1,2)*(5/2)-180));
    end
    
    if R>=1 && N>=1
        if (a(1).Centroid(1,1)-b(1).Centroid(1,1)>50)
            %Gelen sonu� + ise sa� buton t�klan�r
            fare.mousePress(InputEvent.BUTTON3_MASK);
            fare.mouseRelease(InputEvent.BUTTON3_MASK);
            
        else if(a(1).Centroid(1,1)-b(1).Centroid(1,1)<-50)
            %Gelen sonu� - ise sol buton t�klan�r
            fare.mousePress(InputEvent.BUTTON1_MASK);
            fare.mouseRelease(InputEvent.BUTTON1_MASK);
            end
        	
    end 
end    
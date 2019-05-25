%{
Fýrat Üniversitesi Teknoloji Fakültesi Yazýlým Mühendisliði
Sayýsal Görüntü Ýþleme Dersi Projesi

Ýsrafil ÜZÜK
14545029
%}

import java.awt.Robot;
import java.awt.event.*

fare = Robot;

screen = get(0, 'screensize');
vid=videoinput('winvideo',1,'YUY2_640x480'); %video giriþ satýrý

set(vid,'ReturnedColorSpace','rgb'); %renk kompozisyonunu deðiþtir

preview(vid); %kamerayý aç
pause(2);

while 1 
    imge=getsnapshot(vid); %tekil video karesi alma
    %Kýrmýzý nesneyi tanýma yapýyoruz. Bunu da imge_2 isimli deðiþkene
    %atýyoruz.
    %Kýrmýzý bileþeni ayýrma iþlemi
    renk_k= imsubtract(imge(:,:,1), rgb2gray(imge));
    
    %Mavi bileþeni ayýrma iþlemi
    renk_m= imsubtract(imge(:,:,3), rgb2gray(imge));
    
    %Gürültü filtresi iþlemi için 2-D medyan filtresini kullanma
    imge_2 = medfilt2(renk_k, [3 3]);
    
    renk_2 = medfilt2(renk_m, [3 3]);
    
    %Varolan gri tonlu resmi binary resme dönüþtürme.
    imge_2 = im2bw(imge_2, 0.27);%0.26 deðeri denenerek bulunmuþtur.
    renk_2 = im2bw(renk_2, 0.32);
    
    imshow(imge_2);
    pause(0.05);
    
    [B,L,N]= bwboundaries(imge_2,'noholes');
    %Aðýrlýk merkezi hesabý. Dizi olarak sonuç dönecektir.
    a = regionprops(L,'centroid');
    
    [P,Q,R]=bwboundaries(renk_2,'noholes');
    b=regionprops(Q,'centroid');
    
    if N>= 1 && R==0
        
        %Farenin hareketi
        fare.mouseMove(1600-(a(1).Centroid(1,1)*(5/2)),(a(1).Centroid(1,2)*(5/2)-180));
    end
    
    if R>=1 && N>=1
        if (a(1).Centroid(1,1)-b(1).Centroid(1,1)>50)
            %Gelen sonuç + ise sað buton týklanýr
            fare.mousePress(InputEvent.BUTTON3_MASK);
            fare.mouseRelease(InputEvent.BUTTON3_MASK);
            
        else if(a(1).Centroid(1,1)-b(1).Centroid(1,1)<-50)
            %Gelen sonuç - ise sol buton týklanýr
            fare.mousePress(InputEvent.BUTTON1_MASK);
            fare.mouseRelease(InputEvent.BUTTON1_MASK);
            end
        	
    end 
end    
clear all;
close all;

filename = 'bcw_info.txt';
fileID = fopen(filename);
Data = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f %f');
ID_Data = Data{1};
Rot_Data = Data{end};
num_Data = length(ID_Data);
Data_benign = zeros(1,9);
Data_malignant = zeros(1,9);
Rot_benign = zeros(1,1);
Rot_malignant = zeros(1,1);
Data_info = zeros(num_Data,9);

for k = 2:10 
    Data_info(:,k-1)=Data{k};
end

k_b=0;
k_m=0;
for k = 1:length(Data_info)
    
    A=Data_info(k,:);
    B = (A-min(A))/(max(A)-min(A));
    Data_info(k,:)=B;
    
    if Rot_Data(k)==2 
        k_b=k_b+1;
        Rot_Data(k)=0;
        Data_benign(k_b,:)=B;
        Rot_benign(k_b)=0;
    elseif Rot_Data(k)==4
        k_m=k_m+1;
        Rot_Data(k)=1;
        Data_malignant(k_m,:)=B;
        Rot_malignant(k_m)=1;
    end
end

Data_train = [Data_benign(1:150,:);Data_malignant(1:150,:)]';
Data_val = [Data_benign(151:170,:);Data_malignant(151:170,:)]';
Rot_train = [Rot_benign(1:150) Rot_malignant(1:150)];
Rot_val = [Rot_benign(151:170) Rot_malignant(151:170)];
save('x.mat','Data_train');
save('t.mat','Rot_train');

x = Data_train;
t = Rot_train;

trainFcn = 'trainscg';

hiddenLayerSize = 1;
net = patternnet(hiddenLayerSize, trainFcn);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

[net,tr] = train(net,x,t);

y = net(Data_val);
e = gsubtract(Rot_val,y);
performance = perform(net,Rot_val,y);
tind = vec2ind(Rot_val);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

view(net)
w1 = net.IW{1};
fprintf('\n Peso Camada Oculta: ');
fprintf(' %f ',w1);
w2 = net.LW{2};
fprintf('\n Peso Camada Saída: ');
fprintf(' %f ',w2);
b1 = net.b{1};
fprintf('\n Bias Camada Oculta: ');
fprintf(' %f ',b1);
b2 = net.b{2};
fprintf('\n Bias Camada Saída: ');
fprintf(' %f ',b2);

cont_0=0;
cont_1=0;
for k = 1:length(y)
   if k<length(y)*0.5
       if y(k)<0.5
          cont_0=cont_0+1; 
       end
   else
      if y(k)>0.5
          cont_1=cont_1+1; 
      end
   end
end
perc_res=100*(cont_0+cont_1)/length(y);
fprintf('\n Taxa de acerto: %f \% \n',perc_res);
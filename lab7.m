clear;clc;
arr=(xlsread('Lab_7_Data.xlsx'));
%T1 T2 T3 T4 T5 T6 T7 T8 T10 P1	P2 	P3	P4	I_evap I_compr I_cond V Flow
%1  2  3  4  5  6  7  8  9   10 11  12  13  14     15      16     17 18
%Change the unit of pressure to bar
arr(:,11:12)=(arr(:,11:12)+14.6959)*0.0689476;
arr(:,10)=arr(:,10)*0.0689476;
arr(:,13)=arr(:,13)*0.0689476;
arr(:,18)=arr(:,18)*0.453592/60;
%Initialize arrays to store data
h=zeros(9,4);
s=zeros(9,4);
T=zeros(9,4);
P=zeros(9,4);
v=zeros(9,4);
T(:,1)=arr(:,1);
T(:,2)=arr(:,2);
T(:,3)=arr(:,4);
T(:,4)=arr(:,5);
P(:,1)=arr(:,10);
P(:,2)=arr(:,11);
P(:,3)=arr(:,12);
P(:,4)=arr(:,13);
%Coolant inlet temperature
T_air=arr(:,9);
%cop: experimental,ideal,real
cop=zeros(9,3);
%Refrigeration Capacity
rc=zeros(9,1);
%real state 4
h4_r=zeros(9,1);
s4_r=zeros(9,1);
T4_r=zeros(9,1);
v4_r=zeros(9,1);
%ideal state 4
h4_id=zeros(9,1);
s4_id=zeros(9,1);
T4_id=zeros(9,1);
v4_id=zeros(9,1);
for j=1:9
        %state 1
        [T1,vf1,vg1,hf1,hg1,sf1,sg1]=R12_sat(arr(j,1));
        %[T1,vf1,vg1,hf1,hg1,sf1,sg1]=R12_sat_P(arr(j,10));
        h(j,1)=hf1;
        s(j,1)=sf1;
        v(j,1)=vf1;
        %state 2
        h(j,2)=h(j,1);
        [T2,vf2,vg2,hf2,hg2,sf2,sg2]=R12_sat(arr(j,2));
        %[T2,vf2,vg2,hf2,hg2,sf2,sg2]=R12_sat_P(arr(j,11));
        x2=(h(j,2)-hf2)/(hg2-hf2);
        s(j,2)=x2*sg2+(1-x2)*sf2;
        v(j,2)=x2*vg2+(1-x2)*vf2;
        %state 3
        %p3=arr(j,12)
        [v(j,3),h(j,3),u3,s(j,3)]=R12_SV_TP(arr(j,4),arr(j,12));
        %state 4
        %experimental
        %p4=arr(j,13)
        [v(j,4),h(j,4),u4_exp,s(j,4)]=R12_SV_TP(arr(j,5),arr(j,13));
        %ideal
        s4_id(j)=s(j,3);
        [v4_id(j),h4_id(j),u4_id,T4_id(j)]=R12_SV_SP(s4_id(j),arr(j,13));
        %real
        W_comp=arr(j,15)*arr(j,17)/1000; 
        h4_r(j)=W_comp/arr(j,18)+h(j,3);
        if j~=1 && j~=2
            [v4_r(j),T4_r(j),u4_r,s4_r(j)]=R12_SV_HP(h4_r(j),arr(j,13));
        end
        %cop
        cop(j,1)=(h(j,3)-h(j,2))/(h(j,4)-h(j,3));
        cop(j,2)=(h(j,3)-h(j,2))/(h4_id(j)-h(j,3));
        cop(j,3)=(h(j,3)-h(j,2))/(W_comp/arr(j,18));
        %total refrigeration capacity
        rc(j)=arr(j,18)*(h(j,3)-h(j,2));
end
%Trial 1 and 2, h out of range
T4_r(1:2)=[368.26 282.48];
v4_r(1:2)=[0.0606 0.0458];
s4_r(1:2)=[1.237 1.126];


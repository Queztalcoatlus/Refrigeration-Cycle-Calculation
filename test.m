set=[3,5,6,7,8,9];
G=xlsread('SV_DATA.xlsx','sat_P');
sat_s=vertcat(G(:,12),flipud(G(:,13)));
sat_p=vertcat(G(:,1),flipud(G(:,1)));
sat_h=vertcat(G(:,6),flipud(G(:,7)));
sat_T=vertcat(G(:,2),flipud(G(:,2)));
sat_v=vertcat(G(:,3),flipud(G(:,4)));
for m=1:3
    %h-s diagram
    figure(m);
    h_dat=zeros(1,5);
    h_dat(1,1:4)=h(set(m),:);
    h_dat(1,5)=h(set(m),1);
    h_dat_id=[h(set(m),3) h4_id(set(m)) h(set(m),1)];
    h_dat_r=[h(set(m),3) h4_r(set(m)) h(set(m),1)];
    s_dat=zeros(1,5);
    s_dat(1,1:4)=s(set(m),:);
    s_dat(1,5)=s(set(m),1);
    s_dat_id=[s(set(m),3) s4_id(set(m)) s(set(m),1)];
    s_dat_r=[s(set(m),3) s4_r(set(m)) s(set(m),1)];
    plot(s_dat,h_dat,'-*',s_dat_id,h_dat_id,'-.',s_dat_r,h_dat_r,'-.',sat_s(37:88),sat_h(37:88));
    xlabel('s (kJ/kg K)');
    ylabel('h (kJ/kg)');
    legend('Experimental','Ideal','Real','Saturation Dome','Location','northwest');
    
    %T-s diagram
    figure(m+3);
    coolx=[sat_s(20) sat_s(88)];
    cooly=[T_air(set(m)) T_air(set(m))];
    [T_high,v_high,s_high]=sat_state(P(set(m),1));
    [T_low,v_low,s_low]=sat_state(P(set(m),2));
    T_dat=zeros(1,7);
    T_dat(1,1:2)=T(set(m),1:2);
    T_dat(1,4:5)=T(set(m),3:4);
    T_dat(1,3)=T_low;
    T_dat(1,6)=T_high;
    T_dat(1,7)=T(set(m),1);
    T_dat_id=[T(set(m),3) T4_id(set(m)) T_high];
    T_dat_r=[T(set(m),3) T4_r(set(m)) T_high];
    s_dat2=zeros(1,7);
    s_dat2(1,1:2)=s(set(m),1:2);
    s_dat2(1,4:5)=s(set(m),3:4);
    s_dat2(1,3)=s_low;
    s_dat2(1,6)=s_high;
    s_dat2(1,7)=s(set(m),1);
    s_dat_id2=[s(set(m),3) s4_id(set(m)) s_high];
    s_dat_r2=[s(set(m),3) s4_r(set(m)) s_high];
    plot(s_dat2,T_dat,'-*',s_dat_id2,T_dat_id,'-.',s_dat_r2,T_dat_r,'-.',sat_s(20:88),sat_T(20:88),coolx,cooly);
    xlabel('s (kJ/kg K)');
    ylabel('T (^°C)');
    legend('Experimental','Ideal','Real','Saturation Dome','Coolant Inlet Temperature','Location','northwest');
end


for m=4:6
    p_dat=zeros(1,7);
    p_dat(1,1:2)=P(set(m),1:2);
    p_dat(1,4:5)=P(set(m),3:4);
    p_dat(1,3)=P(set(m),2);
    p_dat(1,6)=P(set(m),1);
    p_dat(1,7)=P(set(m),1);
    p_dat_id=[P(set(m),3) P(set(m),4) P(set(m),1)];
    p_dat_r=[P(set(m),3) P(set(m),4) P(set(m),1)];
    [T_high,v_high,s_high]=sat_state(P(set(m),1));
    [T_low,v_low,s_low]=sat_state(P(set(m),2));
    v_dat=zeros(1,7);
    v_dat(1,1:2)=v(set(m),1:2);
    v_dat(1,4:5)=v(set(m),3:4);
    v_dat(1,3)=v_low;
    v_dat(1,6)=v_high;
    v_dat(1,7)=v(set(m),1);
    v_dat_id=[v(set(m),3) v4_id(set(m)) v_high];
    v_dat_r=[v(set(m),3) v4_r(set(m)) v_high];
%     p_dat=zeros(1,5);
%     p_dat(1,1:4)=P(set(m),:);
%     p_dat(1,5)=P(set(m),1);
%     v_dat=zeros(1,5);
%     v_dat(1,1:4)=v(set(m),:);
%     v_dat(1,5)=v(set(m),1);
    figure(m+3)
    plot(v_dat,p_dat,'-*',v_dat_id,p_dat_id,'-.',v_dat_r,p_dat_r,'-.',sat_v(20:66),sat_p(20:66));
    ylim([0,15]);
    xlabel('v (m^3/kg)');
    ylabel('P (bar)');
    legend('Experimental','Ideal','Real','Saturation Dome');
end
%cop and rc vs inlet suction pressure (p3)
figure (10)
plot(P(1:4,3),cop(1:4,2),'-*',P(1:4,3),cop(1:4,3),'-*');
xlabel('Inlet Suction Pressure (bar)');
ylabel('COP');
legend('Ideal','Experimental','Location','northwest');
figure (11)
plot(P(1:4,3),rc(1:4,1),'-*');
xlabel('Inlet Suction Pressure (bar)');
ylabel('Refrigeration Capacity (kW)');
%Superheat
[T_5,v_5,s_5]=sat_state(P(5,3));
[T_6,v_6,s_6]=sat_state(P(6,3));
superheat5=T(5,3)-T_5;
superheat6=T(6,3)-T_6;

%Organize data
%Experimental

Table1=table(T,P,v*1000,h,s);
writetable(Table1,'Results.xlsx','sheet',1);
%State 4 Exp,Ideal,Real
Table2=table(P(:,4),T(:,4),T4_id,T4_r,v(:,4),v4_id,v4_r,h(:,4),h4_id,h4_r,s(:,4),s4_id,s4_r);
writetable(Table2,'Results.xlsx','sheet',2);
%cop Exp,Ideal,Real
%name3={'experimental','Ideal','Real'};
Table3=table(cop);
writetable(Table3,'Results.xlsx','sheet',3);
%RC
Table4=table(rc);
writetable(Table4,'Results.xlsx','sheet',4);
%superheat
Table5=table(superheat5,superheat6);
writetable(Table5,'Results.xlsx','sheet',5);
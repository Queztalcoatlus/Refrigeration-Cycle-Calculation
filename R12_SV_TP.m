function [v,h,u,s]=R12_SV_TP(T,P)
    P_arr=[1 1.5 2 2.5 3 4 5 6 7 8 9 10 15];
    arr(1:13)=struct('data',[]);
    for p=1:13
        arr(p)=struct('data',eval(['xlsread(''SV_data'',''',num2str(P_arr(p)),''')']));
    end
    for j=1:13
        if (P >= P_arr(j) && P <= P_arr(j+1))
            P1=P_arr(j);
            P2=P_arr(j+1);
            break;
        end
    end
    for t1=1:size(arr(j).data)
        if T < (arr(j).data(1,1))
            [T1,vf,vg,hf,hg,sf,sg]=R12_sat_P(P);
            data1a=[T1,vg,hg,0,sg];
            data1b=arr(j).data(1,:);
            break;
        end
        if (T >= arr(j).data(t1,1) && T <= arr(j).data(t1+1,1))
            data1a=arr(j).data(t1,:);
            data1b=arr(j).data(t1+1,:);
            break;
        end
    end
    data_P1=(data1b-data1a)./(data1b(1)-data1a(1))*(T-data1a(1))+data1a;
    for t2=1:size(arr(j+1).data)
        if T < (arr(j+1).data(1,1))
            [T2,vf,vg,hf,hg,sf,sg]=R12_sat_P(P);
            data2a=[T2,vg,hg,0,sg];
            data2b=arr(j+1).data(1,:);
            break;
        end
        if (T >= arr(j+1).data(t2,1) && T <= arr(j+1).data(t2+1,1))
            data2a=arr(j+1).data(t2,:);
            data2b=arr(j+1).data(t2+1,:);
            break;
        end
    end
    data_P2=(data2b-data2a)./(data2b(1)-data2a(1))*(T-data2a(1))+data2a;
    result=(data_P2-data_P1)./(P2-P1)*(P-P1)+data_P1;
    v=result(2);
    h=result(3);
    u=result(4);
    s=result(5);
end

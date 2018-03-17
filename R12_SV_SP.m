function [v,h,u,T]=R12_SV_SP(s,P)
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
        if (s >= arr(j).data(t1,5) && s <= arr(j).data(t1+1,5))
            data1a=arr(j).data(t1,:);
            data1b=arr(j).data(t1+1,:);
            break;
        end
    end
    data_P1=(data1b-data1a)./(data1b(5)-data1a(5))*(s-data1a(5))+data1a;
    for t2=1:size(arr(j+1).data)
        if (s >= arr(j+1).data(t2,5) && s <= arr(j+1).data(t2+1,5))
            data2a=arr(j+1).data(t2,:);
            data2b=arr(j+1).data(t2+1,:);
            break;
        end
    end
    data_P2=(data2b-data2a)./(data2b(5)-data2a(5))*(s-data2a(5))+data2a;
    result=(data_P2-data_P1)./(P2-P1)*(P-P1)+data_P1;
    v=result(2);
    h=result(3);
    u=result(4);
    T=result(1);
end
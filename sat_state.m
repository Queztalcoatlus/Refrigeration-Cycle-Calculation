function [T_sat,vg,sg]=sat_state(P)
    arr=xlsread('SV_data.xlsx','sat_P');
    for j=1:size(arr,1)
        if (P >= arr(j,1) && P <= arr(j+1,1))
            Sat=(arr(j+1,:)-arr(j,:))/(arr(j+1,1)-arr(j,1))*(P-arr(j,1))+arr(j,:);
        end
    end
    T_sat=Sat(2);
    vg=Sat(4);
    sg=Sat(13);
end
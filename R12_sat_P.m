function [T,vf,vg,hf,hg,sf,sg]=R12_sat_P(input)
    arr=xlsread('SV_data.xlsx','sat_P');
    len=size(arr,1);
    for j=1:len
        if (input >= arr(j,1) && input <= arr(j+1,1))
            T=(arr(j+1,2)-arr(j,2))/(arr(j+1,1)-arr(j,1))*(input-arr(j,1))+arr(j,2);            
            vf=(arr(j+1,3)-arr(j,3))/(arr(j+1,1)-arr(j,1))*(input-arr(j,1))+arr(j,3);
            vg=(arr(j+1,4)-arr(j,4))/(arr(j+1,1)-arr(j,1))*(input-arr(j,1))+arr(j,4);
            hf=(arr(j+1,6)-arr(j,6))/(arr(j+1,1)-arr(j,1))*(input-arr(j,1))+arr(j,6);
            hg=(arr(j+1,7)-arr(j,7))/(arr(j+1,1)-arr(j,1))*(input-arr(j,1))+arr(j,7);
            sf=(arr(j+1,12)-arr(j,12))/(arr(j+1,1)-arr(j,1))*(input-arr(j,1))+arr(j,12);
            sg=(arr(j+1,13)-arr(j,13))/(arr(j+1,1)-arr(j,1))*(input-arr(j,1))+arr(j,13);
            break;
         end
    end
end
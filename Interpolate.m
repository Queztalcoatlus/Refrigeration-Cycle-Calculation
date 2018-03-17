function y=Interpolate(x1,y1,x2,y2,x)
    y=(y2-y1)/(x2-x1)*(x-x1)+y1;
end
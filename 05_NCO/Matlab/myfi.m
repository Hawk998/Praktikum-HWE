function res = myfi(xin, bint,bfrac)
    
xsign = sign(xin);   
xabs = abs(xin);
xabs(find(xabs >= 2^bint)) = 2^bint - 1;
x = floor(xabs.*(2^bfrac));
b = bint + bfrac + 1;
res = [];
for it = 1:length(x)
        if(xsign(it) == -1)
            xpos = (2^b - 1) - x(it) + 1;
            temp = dec2bin(xpos,b);
            if(length(temp) > b)
               temp(1:length(temp)-b) = []; 
            end
            res = [res; temp];
        else    
            res = [res; dec2bin(x(it),b)];
        end
end    

end

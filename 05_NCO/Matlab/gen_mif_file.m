function res = gen_mif_file(target_file_name,vector,bit_width,mem_depth,fp_bit_integer)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if bit_width < fp_bit_integer
    disp('Bit widths do not match.');
else

    if mem_depth < length(vector)
        disp('WARNING: input vector exceed specified memory depth');
    end
% %%% Set local variables %%%%%%%%%%%%
% 
% f_name = target_file_name;
% vec    = vector;
% bitW   = bit_width;
% memD   = mem_depth;
% fp_int = fp_bit_integer;
% fp_frac= bitW - fp_bit_integer;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%% Fixed Point Vectorization %%
% 
% vec = fi(real(vec),1,fp_int + fp_frac,fp_frac);

%%% Set local variables %%%%%%%%%%%%

f_name = target_file_name;
vec    = real(vector);
bitW   = bit_width;
fp_int = fp_bit_integer;
fp_frac= bitW - fp_bit_integer - 1;
memD   = mem_depth;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Fixed Point Vectorization %%

vec = myfi(vec,fp_bit_integer,fp_frac);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%

%% open file
fid = fopen(f_name,'w');

fprintf(fid,'WIDTH=%d;\n',bitW);
fprintf(fid,'DEPTH=%d;\n',memD);
fprintf(fid,'\n');
fprintf(fid,'ADDRESS_RADIX=HEX;\n');
fprintf(fid,'DATA_RADIX=BIN;\n');
fprintf(fid,'\n');
fprintf(fid,'CONTENT BEGIN\n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for it = 1:length(vec)
    if it <= memD
            
    fprintf(fid,'        %X  :   ',it-1);
    try
        a = vec(it,:);
        for itr = 1:bitW
            fprintf(fid,a(1,itr)); 
        end 
    catch
        
        for itr = 1:bitW
            fprintf(fid,'0'); 
        end 
    end
    fprintf(fid,';\n');
    else
       break; 
    end
end

%%%%%%% Close file %%%%%%%%%%%
fprintf(fid,'END;\n');
fclose(fid);

end
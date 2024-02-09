% script to convert a HEX file to a MIF file
% user file names definition
fname_in  = "code.hex";
fname_out = "code.mif";

% the code below is not to be changed
disp("hex2mif started...\n\n");

f_in  = fopen(fname_in,'r');
f_out = fopen(fname_out,'w');

fprintf(f_out,"-- This MIF file was automatically converted from a HEX file\n");
fprintf(f_out,"-- file header\n");
fprintf(f_out,"WIDTH=32;\n");
fprintf(f_out,"DEPTH=256;\n\n");
fprintf(f_out,"ADDRESS_RADIX=HEX;\n");
fprintf(f_out,"DATA_RADIX=HEX;\n\n");
fprintf(f_out,"--data\nCONTENT BEGIN\n\n");
fprintf(f_out,"[000..0FF]  :   00000000;\n"); % zero by default

%main processing loop
addr = 0;
while feof(f_in)==0
    str = fgets(f_in);
    fprintf(f_out, '%6x : %s ;\n', addr, strtrim(str) );
    addr = addr + 1;
end

fprintf(f_out,"END;\n\n");
fclose(f_in);
fclose(f_out);

disp("hex2mif completed.\n\n");
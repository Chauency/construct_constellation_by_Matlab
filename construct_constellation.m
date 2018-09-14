% pskModulator = comm.PSKModulator(16,'BitInput',true);
% constellation(pskModulator)
% hMod = comm.RectangularQAMModulator('ModulationOrder',64,'BitInput',true, 'AveragePower', true);
% %constellation(hMod)
%M = floor(log2(size_of_constellation))
for M = 2 : 10
    for modType = 0: 1
        size_of_constellation = 2^M
        x = (0:size_of_constellation - 1)';
        %y = qammod(x, size_of_constellation,'UnitAveragePower', true,'PlotConstellation', true)
        if modType == 0
            y = qammod(x, size_of_constellation,'UnitAveragePower', true)
            output_file = sprintf('%dbits_%dQAM.txt', M, size_of_constellation)
        elseif modType == 1
            y = pskmod(x, size_of_constellation)
            output_file = sprintf('%dbits_%dPSK.txt', M, size_of_constellation)
        end
        
        fid = fopen(output_file, 'w');
        fprintf(fid, 'number_of_bits_per_symbol\n');
        fprintf(fid, '%d\n', M);
        
        fprintf(fid, 'number_of_symbols\n');
        fprintf(fid, '%d\n', size_of_constellation);
        
        %fprintf(fid, 'constellation\n');
        fprintf(fid, '"decimal_expression"____"binary_expression"____"symbol(real_image_..._real_image)"\n');
        
        
        for k=1:size_of_constellation
            fprintf(fid, '%-20d ', k-1);
            temp = dec2bin(k-1, M);
            for s=1:M
                fprintf(fid, '%d ', temp(s)-'0');
            end
            fprintf(fid, '     ');
            fprintf(fid, '%13.10f  ', real(y(k)));
            fprintf(fid, '%13.10f  ', imag(y(k)));
            fprintf(fid, '\n');
        end
        fclose(fid);
    end
end

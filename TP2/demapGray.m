function bitsEstimated = demapGray(an_chap, mComplex, mGray)



    N = length(an_chap);

    k = log2(numel(mComplex));

    bitsEstimated = [];



    for i = 1:N

        [~, index] = min(abs(mComplex(:) - an_chap(i)));



        [row, col] = ind2sub(size(mComplex), index);

        grayCode = mGray(row, col);

        grayCodeBinary = de2bi(grayCode, k, 'left-msb');





        bitsEstimated = [bitsEstimated, grayCodeBinary];

    end


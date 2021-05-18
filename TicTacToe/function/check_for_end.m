function ret = check_for_end(S)
    ret = 0;
    if sum(sum(abs(S)))==9
        ret =1;
        return;
end
function tdoa = getTDOA(emit, m1, m2, fs)
    c = 343;
    tdoa = fs*(norm(emit - m1, 2) - norm(emit - m2, 2))/c;
    tdoa = round(tdoa);
end
program SqrtTwo;

var
        l, r, m, eps: Double;

begin
        ReadLn (eps);

        l := 1;
        r := 2;

        while r - l > eps do begin
                m := (l + r) / 2;
                if Sqr(m) >= 2 then
                        r := m
                else
                        l := m
        end;

        WriteLn (r : 0 : 16);
        WriteLn (Sqrt(2) : 0 : 16)
end.

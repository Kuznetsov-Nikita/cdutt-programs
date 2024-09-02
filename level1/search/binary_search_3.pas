program SqrtTwo;

var
        l, r, m: Double;

begin
        l := 1;
        r := 2;
        m := (l + r) / 2;

        while (m <> l) and (m <> r) do begin
                if Sqr(m) >= 2 then
                        r := m
                else
                        l := m;
                m := (l + r) / 2
        end;

        WriteLn (r : 0 : 15);
        WriteLn (Sqrt(2) : 0 : 15)
end.

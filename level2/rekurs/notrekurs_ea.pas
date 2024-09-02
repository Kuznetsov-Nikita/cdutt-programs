program EuclideanAlgorithm;

var
        a, b, t: LongWord;

begin
        ReadLn (a, b);

        Write ('НОД (', a, ', ', b, ') = ');

        while b <> 0 do begin
                t := a mod b;
                a := b;
                b := t
        end;

        WriteLn (a)
end.

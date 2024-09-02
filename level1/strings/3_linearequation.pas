{ 3. Решение линейного уравнения }
program LinearEquation;

var
        s: string;
        i, t: Word;
        a, b, ans: Integer;

begin
        ReadLn (s);

        i := Pos('=', s);
        Val(Copy(s, i + 1, Length(s) - i), b, t);

        if s[1] in ['a'..'z'] then begin
                Write (s[1], ' = ');

                Val(Copy(s, 2, i - 2), a, t);

                ans := b - a
        end
        else begin
                Write (s[i - 1], ' = ');

                Val(Copy(s, 1, i - 3), a, t);

                if s[i - 2] = '-' then
                        ans := a - b
                else
                        ans := b - a
        end;

        WriteLn (ans)
end.

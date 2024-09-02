{ 2. Лишние пробелы }
program ExtraSpaces;

var
        s: string;
        i, j: Word;

begin
        ReadLn (s);

        i := 1;
        while s[i] = ' ' do
                Inc(i);

        Delete(s, 1, i - 1);

        i := Length(s);
        while s[i] = ' ' do
                Dec(i);

        Delete(s, i + 1, Length(s) - i);

        i := Pos('  ', s);
        while i <> 0 do begin
                j := i;
                while s[j] = ' ' do
                        Inc(j);

                Delete(s, i, j - i - 1);

                i := Pos('  ', s)
        end;

        WriteLn (s)
end.

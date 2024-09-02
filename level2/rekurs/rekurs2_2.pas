program Number2;

procedure Rekurs (a, b: LongWord);
begin
        Write (a, ' ');

        if a < b then
                Rekurs(a + 1, b);

        if a > b then
                Rekurs(a - 1, b)
end;

var
        a, b: LongWord;

begin
        ReadLn (a, b);

        Rekurs(a, b)
end.

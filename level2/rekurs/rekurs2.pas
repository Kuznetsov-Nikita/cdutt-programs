program Number2;

procedure Rekurs (a, b: LongWord);
begin
        if a <= b then begin
                Write (a, ' ');
                Rekurs(a + 1, b)
        end
end;

var
        a, b: LongWord;

begin
        ReadLn (a, b);

        Rekurs(a, b)
end.

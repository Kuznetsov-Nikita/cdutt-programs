{ 2(б). Функция UpCase }
program UpCaseOfLetter;

function UpCase (ch: Char): Char;
begin
        case ch of
          'а'..'п' : Dec(ch, 32);
          'р'..'я' : Dec(ch, 80);
          'ё'      : Dec(ch)
        else
                ch := System.UpCase(ch)
        end;

        UpCase := ch
end;

var
        s: string;
        i: Byte;

begin
        ReadLn (s);

        for i := 1 to Length(s) do
                s[i] := UpCase (s[i]);

        WriteLn (s)
end.

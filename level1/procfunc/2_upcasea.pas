{ 2(а). Функция UpCase }
program UpCaseOfLetters;

function UpCase (ch: Char): Char;
begin
        if ch in ['а'..'п'] then
                Dec(ch, 32)
        else if ch in ['р'..'я'] then
                Dec(ch, 80)
        else if ch = 'ё' then
                Dec(ch);

        UpCase := System.UpCase(ch)
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

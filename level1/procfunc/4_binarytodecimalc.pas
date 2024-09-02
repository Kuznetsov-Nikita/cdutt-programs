{ 4(в). Перевод из двоичной системы счисления в десятичную }
program BinaryToDecimal;

procedure BinToDec(b: string; var n: LongWord; var v: Word);
var
        i: Word;
begin
        v := 0;
        n := 0;
        for i := 1 to Length(b) do
                if (b[i] <> '1') and (b[i] <> '0') then begin
                        v := i;
                        Exit
                end
                else
                        n := n * 2 + Ord(b[i]) - 48
end;

var
        s: string;
        x: LongWord;
        v: Word;

begin
        ReadLn (s);
        BinToDec(s, x, v);
        if v > 0 then
                WriteLn ('Ошибка в записи двоичного числа в позиции ', v)
        else
                WriteLn (s + 'B = ', x)
end.

{ 4(б). Перевод из двоичной системы счисления в десятичную }
program BinaryToDecimal;

procedure BinToDec(b: string; var n: LongWord; var v: Word);
var
        i, len, p: Word;
begin
        len := Length(b);
        v := 0;

        for i := 1 to len do
                if (b[i] <> '1') and (b[i] <> '0') then begin
                        v := i;
                        Exit
                end;

        p := 1;
        n := 0;
        for i := len downto 1 do begin
                n := n + (Ord(b[i]) - 48) * p;
                p := p shl 1
        end
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

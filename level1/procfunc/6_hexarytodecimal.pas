{ 6. Перевод из шестнадцатеричной системы счисления в десятичную }
program HexaryToDecimal;

procedure HexToDec(h: string; var n: LongWord; var v: Word);
const
        HEXDIGITS = '0123456789ABCDEF';
var
        i: Word;
begin
        v := 0;
        n := 0;
        for i := 1 to Length(h) do
                if Pos(h[i], HEXDIGITS) = 0  then begin
                        v := i;
                        Exit
                end
                else
                                n := n * 16 + Pos(h[i], HEXDIGITS) - 1
end;

var
        s: string;
        x: LongWord;
        v: Word;

begin
        ReadLn (s);
        HexToDec(s, x, v);
        if v > 0 then
                WriteLn ('Ошибка в записи шестнадцатеричного числа в позиции ', v)
        else
                WriteLn (s + 'H = ', x)
end.

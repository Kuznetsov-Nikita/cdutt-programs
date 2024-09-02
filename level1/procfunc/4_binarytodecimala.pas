{ 4(а). Перевод из двоичной системы счисления в десятичную }
program BinaryToDecimal;

procedure BinToDec(b: string; var n: LongWord; var v: Word);

function PowerOfTwo(k: Word): LongWord;
var
        j: Word;
begin
        PowerOfTwo := 1;
        for j := 1 to k do
                PowerOfTwo := PowerOfTwo shl 1
end;

var
        i, len: Word;
begin
        v := 0;
        n := 0;
        len := Length(b);
        for i := 1 to len do
                if (b[i] <> '1') and (b[i] <> '0') then begin
                        v := i;
                        Exit
                end
                else
                        n := n + (Ord(b[i]) - 48) * PowerOfTwo(len - i)
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

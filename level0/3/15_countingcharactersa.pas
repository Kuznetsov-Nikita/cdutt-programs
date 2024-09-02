{ 3.15(а) Подсчёт символов в строке }
program CountingCharacters;

var
        s: string;
        c: Char;
        len, cnt, k: Word;

begin
        ReadLn (s);
        ReadLn (c);

        cnt := 0;
        k := 1;
        len := Length(s);

        while k <= len do begin
                if s[k] = c then
                        Inc(cnt);
                Inc(k)
        end;

        WriteLn (cnt)
end.
{
С Новым годом!
о
3

С Новым годом!
с
0

С Новым годом!
С
1

С Новым годом!
!
1


ц
0
}

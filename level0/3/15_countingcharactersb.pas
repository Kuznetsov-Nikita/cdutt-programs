{ 3.15(б) Подсчёт символов в строке }
program CountingCharacters;

var
        s: string;
        c: Char;
        cnt, k: Word;

begin
        ReadLn (s);
        ReadLn (c);

        cnt := 0;

        for k := 1 to Length(s) do
                if s[k] = c then
                        Inc(cnt);

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

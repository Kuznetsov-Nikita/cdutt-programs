{ 3.14 Отгадай число }
program GuessNumber;

var
        l, r, m: Integer;
        ans: Byte;

begin
        l := 1;
        r := 1000;

        while l < r do begin
                m := l + (r - l) div 2;

                Write ('Ваше число больше ', m, '? ');

                ReadLn (ans);

                if ans = 1 then
                        l := m + 1
                else
                        r := m
        end;

        WriteLn ('Вы загадали число ', l)
end.
{
1
Вы загадали число 1

1000
Вы загадали число 1000
}

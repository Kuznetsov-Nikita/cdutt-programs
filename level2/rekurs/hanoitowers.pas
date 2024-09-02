program HanoiTowers;

procedure Hanoi (n: Word; src, dst, tmp: Char);
begin
        if n = 1 then
                WriteLn (src, ' -> ', dst)
        else begin
                Hanoi(n - 1, src, tmp, dst);
                Hanoi(1, src, dst, tmp);
                Hanoi(n - 1, tmp, dst, src)
        end
end;

var
        n: Word;

begin
        ReadLn (n);

        Hanoi(n, 'A', 'B', 'C')
end.

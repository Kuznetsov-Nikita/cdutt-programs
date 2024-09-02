{ 3.12 Перевод из десятичной в двоичную систему счисления }
program DecimalToBinary;

var
        n: LongWord;
        s: string;

begin
        ReadLn (n);

        s := '';

        repeat
                if n mod 2 = 0 then
                        s := '0' + s
                else
                        s := '1' + s;

                n := n div 2;
        until n = 0;

        WriteLn (n, ' = ', s, 'B')
end.
{
0
0 = 0B

13
13 = 1101B
}

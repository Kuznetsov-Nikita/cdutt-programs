{ 1. ФИО }
program SNP;

var
        s: string;
        i, j: Word;

begin
        ReadLn (s);

        i := Pos(' ', s);
        j := i;
        while s[j] = ' ' do
                Inc(j);

        Delete(s, i, j - i);

        j := Pos(' ', s);
        while s[j] = ' ' do
                Inc(j);

        Delete(s, i + 1, j - i - 1);

        Delete(s, i + 2, Length(s));

        Insert(' ', s, Length(s) - 1);
        Insert('.', s, Length(s));
        s := s + '.';

        WriteLn (s)
end.

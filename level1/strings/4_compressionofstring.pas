{ 4(а). Упаковка строки }
program CompressionOfString;

var
        s, strcnt: string;
        i, j, cnt, k: Word;

begin
        ReadLn (s);

        cnt := 1;
        s := s + '#';
        j := 1;

        for i := 2 to Length(s) do
                if s[i] = s[i - 1] then
                        Inc(cnt)
                else
                        if cnt <= 2 then begin
                                for k := 0 to cnt - 1 do
                                        s[k + j] := s[k - cnt + j];
                                j := j + cnt
                        end
                        else begin
                                Str(cnt, strcnt);

                                for k := 1 to Length(strcnt) do
                                        s[k + j] := strcnt[k + 1];

                                s[Length(strcnt) + j] := s[i - 1];
                                j := j + Length(strcnt) + 1;
                                cnt := 1
                        end;

        Delete(s, j, Length(s));

        WriteLn (s)
end.

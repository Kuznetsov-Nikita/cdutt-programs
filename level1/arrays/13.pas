{ 13. Подсчет всех символов в строке }
program Array13;

var
        s: string;
        chars: array ['A'..'Z'] of Integer;
        i: Integer;
        j: Char;

begin
        ReadLn (s);

        s := UpCase(s);

        FillChar(chars, SizeOf(chars), 0);

        for i := 1 to Length(s) do
                Inc(chars[s[i]]);

        for j := 'A' to 'Z' do
                if chars[j] <> 0 then
                        WriteLn (j, ': ', chars[j])
end.

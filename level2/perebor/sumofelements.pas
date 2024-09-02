program SumOfElements;

type
        TNumbers = array [1..1000] of Integer;
        TSigns = array [1..1000] of Char;

procedure PrintExpression(const nums: TNumbers; const sgn: TSigns; n: Integer);
var
        i: Integer;
        s: LongInt;
begin
        Write (nums[1]);
        s := nums[1];

        for i := 2 to n do begin
                if sgn[i] = '+' then
                        Inc(s, nums[i])
                else
                        Dec(s, nums[i]);

                Write (' ', sgn[i], ' ', nums[i])
        end;

        WriteLn (' = ', s)
end;

procedure NextSign(const nums: TNumbers; var sgn: TSigns; n, k: Integer; s: LongInt);
begin
        if k > n then begin
                if s = 0 then
                        PrintExpression(nums, sgn, n);
                Exit
        end;

        sgn[k] := '+';
        NextSign(nums, sgn, n, k + 1, s - nums[k]);

        sgn[k] := '-';
        NextSign(nums, sgn, n, k + 1, s + nums[k])
end;

var
        n, i: Integer;
        s: LongInt;
        nums: TNumbers;
        sgn: TSigns;

begin
        ReadLn (n, s);

        for i := 1 to n do
                Read (nums[i]);

        NextSign(nums, sgn, n, 2, s - nums[1])
end.

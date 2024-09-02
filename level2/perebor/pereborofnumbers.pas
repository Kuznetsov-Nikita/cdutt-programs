program PereborOfNumbers;

type
        ArrDigits = array [1..100] of Byte;

procedure PrintNumber (var a: ArrDigits; n: Integer);
var
        i: Integer;
begin
        for i := 1 to n do
                Write (a[i]);
        WriteLn
end;

procedure NextDigit (var a: ArrDigits; n, k, s: Integer);
var
        i: Integer;
begin
        if k > n then begin
                PrintNumber(a, n);
                Exit
        end;

        for i := 0 to s - 1 do begin
                a[k] := i;
                NextDigit(a, n, k + 1, s)
        end
end;

var
        a: ArrDigits;
        n, i, s: Integer;

begin
        ReadLn (n, s);

        {for i := 1 to s - 1 do begin
                a[1] := i;
                NextDigit(a, n, 2, s)
        end}
        NextDigit(a, n, 1, s)
end.

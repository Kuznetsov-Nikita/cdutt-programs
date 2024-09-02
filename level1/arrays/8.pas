{ 8. Сдвинуть в конец массива все нулевые элементы }
program Array8;

const
	SIZE = 1000;

type
        TArr = array [1..SIZE] of Integer;

procedure InitArray(var a: TArr; n: Integer);
const
        LEFT = -100;
        RIGHT = 100;
var
        i: Integer;
begin
        for i := 1 to n do begin
                a[i] := Random(RIGHT - LEFT + 1) + LEFT;
                if a[i] < 0 then
                        a[i] := 0
        end
end;

procedure PrintArray(const a: TArr; n: Integer);
var
        i: Integer;
begin
        for i := 1 to n do
                Write (a[i], ' ');
        WriteLn
end;

var
	a: TArr;
	n, i, j: Integer;

begin
        Randomize;

        ReadLn (n);

        InitArray(a, n);

        PrintArray(a, n);

        j := 1;
        for i := 1 to n do
                if a[i] <> 0 then begin
                        a[j] := a[i];
                        Inc(j)
                end;

        for i := j to n do
                a[i] := 0;

        PrintArray(a, n)
end.

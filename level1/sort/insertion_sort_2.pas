{ Сортировка вставкой (б) }
program InsertionSort;

const
	SIZE = 1000000;

type
        TArr = array [1..SIZE] of LongInt;

procedure ReadArray(var a: TArr; n: LongInt);
var
        i: LongInt;
begin
        for i := 1 to n do
                Read (a[i])
end;

procedure SortArray(var a: TArr; n: LongInt);
var
        i, j, t: LongInt;
begin
        for i := 2 to n do begin
                t := a[i];

                j := i;
                while a[j - 1] > t do begin
                        a[j] := a[j - 1];
                        Dec(j)
                end;

                a[j] := t
        end
end;

procedure WriteArray(const a: TArr; n: LongInt);
var
        i: LongInt;
begin
        for i := 1 to n do
                Write (a[i], ' ');
        WriteLn
end;

var
	arr: TArr;
	n, m: LongInt;

begin
        ReadLn (n);
        ReadArray(arr, n);

        SortArray(arr, n);

        WriteArray(arr, n);
end.

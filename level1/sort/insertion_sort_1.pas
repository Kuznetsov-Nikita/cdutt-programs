{ Сортировка вставкой (a) }
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
        i, j, k, t: LongInt;
begin
        for i := 2 to n do begin
                t := a[i];

                j := 1;
                while a[j] < t do
                        Inc(j);

                for k := i - 1 downto j do
                        a[k + 1] := a[k];

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

program QuickSort;

const
	SIZE = 10000000;

type
        TArr = array [1..SIZE] of LongInt;

procedure ReadArray(var a: TArr; n: LongInt);
var
        i: LongInt;
begin
        for i := 1 to n do
                Read (a[i])
end;

procedure Swap(var a, b: LongInt);
var
        t: LongInt;
begin
        t := a;
        a := b;
        b := t
end;

procedure QSort (var a: TArr; left, right: LongInt);
var
        i, j: LongInt;
        m: LongInt;
begin
        m := a[left + (right - left) div 2];
        i := left;
        j := right;

        while i <= j do begin
                while a[i] < m do
                        Inc(i);

                while a[j] > m do
                        Dec(j);

                if i <= j then begin
                        Swap(a[i], a[j]);
                        Inc(i);
                        Dec(j)
                end
        end;

        if left < j then
                QSort(a, left, j);

        if i < right then
                QSort(a, i, right)
end;

procedure SortArray(var a: TArr; n: LongInt);
begin
        QSort(a, 1, n)
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

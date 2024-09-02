program PermitationsAlgorithm;

type
        TArr = array [1..20] of Integer;

procedure Swap (var a, b: Integer);
var
        t: Integer;
begin
        t := a;
        a := b;
        b := t
end;

procedure PrintPerm (const p: TArr; n: Integer);
var
        i: Integer;
begin
        for i := 1 to n do
                Write (p[i], ' ');
        WriteLn
end;

procedure Perms (var p: TArr; k, n: Integer);
var
        i: Integer;
begin
        if k > n then begin
                PrintPerm(p, n);
                Exit
        end;

        for i := k to n do begin
                Swap(p[i], p[k]);
                Perms(p, k + 1, n);
                Swap(p[i], p[k])
        end
end;

var
        p: TArr;
        n, i: Integer;

begin
        ReadLn (n);

        for i := 1 to n do
                p[i] := i;

        Perms(p, 1, n)
end.

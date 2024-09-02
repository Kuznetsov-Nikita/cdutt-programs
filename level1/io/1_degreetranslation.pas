{ 1. Перевод градусов }
program DegreeTranslation;

var
        it, ot: Double;
        ds: Char;

begin
        ReadLn (it, ds, ds);

        if ds = 'C' then begin
                ot := it * 9 / 5 + 32;
                WriteLn (it : 0 : 1, ' °C = ', ot : 0 : 1, ' °F')
        end
        else begin
                ot := (it - 32) * 5 / 9;
                WriteLn (it : 0 : 1, ' °F = ', ot : 0 : 1, ' °C')
        end
end.
{
0 C
0.0 °C = 32.0 °F

0 F
0.0 °F = -17.8 °C

212 F
212.0 °F = 100.0 °C

100 C
100.0 °C = 212.0 °F

-100 C
-100.0 °C = -148.0 °F

-148 F
-148.0 °F = -100.0 °C
}

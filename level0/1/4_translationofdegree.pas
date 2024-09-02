{ 1.4 Перевод градусов }
program TranslationOfDegree;

var
        c, f: Double;

begin
        ReadLn (c);

        f := c * 9 / 5 + 32;

        WriteLn (c : 0 : 1, ' °C = ', f : 0 : 1, ' °F')
end.
{
100
100.0 °C = 212.0 °F

0
0.0 °C = 32.0 °F

36.6
36.6 °C = 97.9 °F

-100
-100.0 °C = -148.0 °F
}

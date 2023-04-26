# チェリー本 P.179 単位変換
def convert_length(len, units_from, units_to)
  units={m: 1.0, ft: 3.28, in: 39.37}
  (len / units[unit_from] * units[unit_to]).round(2)
end
puts convert_length(1,:m,:in)
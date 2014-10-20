Sprangular.Luhn =
  isValid: (number) ->
    number = '' + number
    return false if number.length < 8 or number.length > 19
    sum = 0
    mul = 1
    l = number.length
    i = 0
    while i < l
      digit = number.substring(l - i - 1, l - i)
      tproduct = parseInt(digit, 10) * mul
      if tproduct >= 10
        sum += (tproduct % 10) + 1
      else
        sum += tproduct
      if mul is 1
        mul++
      else
        mul--
      i++

    (sum % 10) is 0

module NumberHelper
  def leading_zero(number)
    number.to_s.rjust(2, '0')
  end
end

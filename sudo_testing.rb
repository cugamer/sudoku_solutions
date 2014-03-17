@inputstring1 = "105802000090076405200400819019007306762083090000061050007600030430020501600308900".split("").map!{|x| x.to_i}
@string_true = "145892673893176425276435819519247386762583194384961752957614238438729561621358947".split("").map!{|x| x.to_i}

def make_rows(input)
  @rows = input.each_slice(9).to_a
end

def make_or_unmake_cols(input)
  @cols = []
  9.times do | outer |
    @cols << []
    start = outer
    9.times do | iterator |
      @cols[outer] << input[ start ]
      start += 9
    end
  end
  @cols
end

def make_or_unmake_grids(input)
  @grids = []
  count_num = 0
  9.times do | first_iteration |
    @grids << []
    count_num -= 24 if first_iteration % 3 != 0
    count_num -= 6 if first_iteration % 3 == 0 and first_iteration != 0
    3.times do | second_iteration |
      @grids[first_iteration] << []
      3.times do | third_iteration |
        @grids[first_iteration][second_iteration] << input[count_num]
        count_num += 1
      end
      count_num += 6
    end
  end
  @grids #= @grids.flatten.each_slice(9).to_a
end

  p make_or_unmake_grids(@inputstring1).flatten(2)
  p make_rows(make_or_unmake_grids(@inputstring1).flatten(2))

def check_solved?(completed_arr)
  completed_arr.each do |row|
    if row.include?(0) or row.inject(0){|sum, next_num| sum += next_num} != 45
      return false
    end
  end

  true
end

p check_solved?(make_rows(@inputstring1))
p check_solved?(make_rows(@string_true))
p check_solved?(make_or_unmake_cols(@inputstring1))
p check_solved?(make_or_unmake_cols(@string_true))
p check_solved?(make_rows(make_or_unmake_grids(@inputstring1).flatten(2)))
p check_solved?(make_rows(make_or_unmake_grids(@string_true).flatten(2)))

























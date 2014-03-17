# input_string = "530070000600195000098000060800060003400803001700020006060000280000419005000080079"

@inputstring1 = "105802000090076405200400819019007306762083090000061050007600030430020501600308900".split("").map!{|x| x.to_i}
@inputstring2 = "005030081902850060600004050007402830349760005008300490150087002090000600026049503".split("").map!{|x| x.to_i}
@inputstring3 = "105802000090076405200400819019007306762083090000061050007600030430020501600308900".split("").map!{|x| x.to_i}
@inputstring4 = "005030081902850060600004050007402830349760005008300490150087002090000600026049503".split("").map!{|x| x.to_i}
@inputstring5 = "290500007700000400004738012902003064800050070500067200309004005000080700087005109".split("").map!{|x| x.to_i}
@inputstring6 = "080020000040500320020309046600090004000640501134050700360004002407230600000700450".split("").map!{|x| x.to_i}
@inputstring7 = "608730000200000460000064820080005701900618004031000080860200039050000100100456200".split("").map!{|x| x.to_i}
@inputstring8 = "370000001000700005408061090000010000050090460086002030000000000694005203800149500".split("").map!{|x| x.to_i}
@inputstring9 = "000689100800000029150000008403000050200005000090240801084700910500000060060410000".split("").map!{|x| x.to_i}
@inputstring10 = "030500804504200010008009000790806103000005400050000007800000702000704600610300500".split("").map!{|x| x.to_i}
@inputstring11 = "096040001100060004504810390007950043030080000405023018010630059059070830003590007".split("").map!{|x| x.to_i}
@inputstring12 = "000075400000000008080190000300001060000000034000068170204000603900000020530200000".split("").map!{|x| x.to_i}

# @integer_array = input_string.split("").map!{|x| x.to_i}

def make_rows(input)
  @rows = input.each_slice(9).to_a.flatten(1)
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

def get_possible_values(input_arr, type)
  position = 0
  9.times do  | step_one |
    @found_values = []

    9.times do | step_two_a|
      @found_values << input_arr[(step_one + 1) * 9 - 9 + step_two_a] if input_arr[(step_one + 1) * 9 - 9 + step_two_a].is_a?(Array) == false and  input_arr[(step_one + 1) * 9 - 9 + step_two_a] != 0
      @remaining_possibilities = (1..9).to_a - @found_values
    end

    9.times do | step_two_b |
      if input_arr[(step_one + 1) * 9 - 9 + step_two_b] == 0
        input_arr[(step_one + 1) * 9 - 9 + step_two_b] = @remaining_possibilities
      elsif input_arr[(step_one + 1) * 9 - 9 + step_two_b].is_a?(Array) == true
        old_pos = input_arr[(step_one + 1) * 9 - 9 + step_two_b]
        new_pos = @remaining_possibilities
        really_new_pos = []
        (old_pos & new_pos).each{ | i | really_new_pos << i}
        input_arr[(step_one + 1) * 9 - 9 + step_two_b] = really_new_pos
        input_arr[(step_one + 1) * 9 - 9 + step_two_b] = input_arr[(step_one + 1) * 9 - 9 + step_two_b][0] if input_arr[(step_one + 1) * 9 - 9 + step_two_b].length == 1
      end
    end
  end
  input_arr = make_or_unmake_cols(input_arr).flatten(1) if type == "col"
  input_arr = make_or_unmake_grids(input_arr) if type == "grid"
  return input_arr
end


def run_reduce(num_of_runs, input_array)
  @previous_value = ""
  count = 0
  @working_value = input_array
  num_of_runs.times do
    @working_value = get_possible_values(@working_value, "row")
    @working_value = get_possible_values(make_or_unmake_cols(@working_value).flatten(1), "col")
    @working_value = get_possible_values(make_or_unmake_grids(@working_value).flatten(2), "grid")
    @working_value = @working_value.flatten(2)
    count += 1
    # p @working_value
    # p @previous_value
    if @working_value.flatten == @working_value
      # p "This is working #{@working_value}"
        check_solved?(@working_value)
        return format_value(@working_value)
    elsif @working_value == @previous_value
      return p "Max reduction at #{count}"
    else
      @previous_value = @working_value
    end
  end
end

def check_solved?(completed_arr)
  p completed_arr
  testing_arr = completed_arr.each_slice(9).to_a
  p check_solved_by_row(testing_arr)
  p check_solved_by_row(testing_arr)
  p check_solved_by_row(testing_arr)
end

def check_solved_by_row(input_rows)
  input_rows.each do |row|
    if row.include?(0) or row.inject(0){|sum, next_num| sum += next_num} != 45
        return false
    end
  end
  true
end

def format_value(completed_arr)
  completed_arr = completed_arr.each_slice(9).to_a
  completed_arr.each_index do | place |
    insert_pos = 3
    2.times do
      completed_arr[place].insert(insert_pos, "  |  ")
      insert_pos += 4
    end
    puts completed_arr[place].join
  end
end

run_reduce(10000, @inputstring1)
puts
run_reduce(10000, @inputstring2)
puts
run_reduce(10000, @inputstring3)
puts
run_reduce(10000, @inputstring4)
puts
run_reduce(10000, @inputstring5)
puts
run_reduce(10000, @inputstring6)
puts
run_reduce(10000, @inputstring7)
puts
run_reduce(10000, @inputstring8)
puts
run_reduce(10000, @inputstring9)
puts
run_reduce(10000, @inputstring10)
puts
run_reduce(10000, @inputstring11)
puts
run_reduce(10000, @inputstring12)


























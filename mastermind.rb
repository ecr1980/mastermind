class Combo
  def initialize
    @combo_array = Array.new(4,"x")
  end

  def array_change(input_array)
    @combo_array = input_array
  end

  def array_display
    puts " #{@combo_array[0]} #{@combo_array[1]} #{@combo_array[2]} #{@combo_array[3]}"
  end

  def check_array
    @combo_array
  end
end

def game_setup
   $secret_code = comp_choice()
   $turns = Array.new(12) {Array.new(4, "X ")}
   $turns_results = Array.new(12) {Array.new(4, " +")}
   $player = true
end

def game_display
  $turns.each_with_index do |turn, i|
    puts " #{turn[0]} #{turn[1]} #{turn[2]} #{turn[3]}    #{$turns_results[i][0]} #{$turns_results[i][1]} #{$turns_results[i][2]} #{$turns_results[i][3]}"
  end
end

def player_choice
  ok = true
  puts "Please enter the four colors you want, in order."
  puts "Choices are: Blue, Yellow, Red, Orange, Green, and Purple"
  choice = gets.upcase.chomp
  choice = choice.split(" ")
  if choice.length != 4
    "Only four choices, please."
    ok = false
  end
  choice.each do |color,index|
    color = color.chr
    if (color != "B" && color != "Y" && color != "R" && color != "O" && color != "G" && color != "P")
      puts "Only valid choices, please."
      ok = false
      break
    end
  end
  array_change[color]
end

def comp_choice
  choice = Array.new(4)

  choice.each_with_index do |c,index|
    x = rand(6)
    case x
    when 0
      x = "B"
    when 1
      x = "Y"
    when 2
      x = "R"
    when 3
      x = "O"
    when 4
      x = "G"
    when 5
      x = "P"
    else
      puts "Generic Error, what gives?"
    end
    choice[index] = x
  end
  return choice
end


game_setup()

game_display()

#YOU ARE OVER THINKING THIS. YOU DON'T NEED TO STORE YOUR GUESSES IN A CLASS
#VARIABLE! YOU CAN JUST HAVE AN ARRAY OF STORED VALUES.



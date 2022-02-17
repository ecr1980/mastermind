def game_setup
  if $player == true
   $secret_code = comp_choice()
  else
    puts "Your turn to make the secret code."
    $secret_code = player_choice()
  end
   $turns = Array.new(12) {Array.new(4, "-")}
   $turns_results = Array.new(12) {Array.new(4, " +")}
end

def game_display
  $turns.each_with_index do |turn, i|
    puts " #{turn[0]}  #{turn[1]}  #{turn[2]}  #{turn[3]}     #{$turns_results[i][0]} #{$turns_results[i][1]} #{$turns_results[i][2]} #{$turns_results[i][3]}"
  end
end

def player_choice
  $OK = true
  puts "Please enter the four colors you want, in order."
  puts "Choices are: Blue, Yellow, Red, Orange, Green, and Purple"
  choice = gets.upcase.chomp
  choice = choice.split(" ")
  if choice.length != 4
    puts "Four choices, please."
    $OK = false
  end
  choice.each do |color,index|
    color = color.chr
    if (color != "B" && color != "Y" && color != "R" && color != "O" && color != "G" && color != "P")
      puts "Only valid choices, please."
      $OK = false
      break
    end
  end
  choice
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

def count(x)
  color_count = Array.new(6,0)

  x.each do |value|
    case value
    when "B"
      color_count[0] += 1
    when "Y"
      color_count[1] += 1
    when "R"
      color_count[2] += 1
    when "O"
      color_count[3] += 1
    when "G"
      color_count[4] += 1
    when "P"
      color_count[5] += 1
    end
  end
  color_count
end

def count_minus(x, value)
    case value
    when "B"
      x[0] -= 1
    when "Y"
      x[1] -= 1
    when "R"
      x[2] -= 1
    when "O"
      x[3] -= 1
    when "G"
      x[4] -= 1
    when "P"
      x[5] -= 1
    end
  x
end

def color_array_location(x)
  case x
  when "B"
    y = 0
  when "Y"
    y = 1
  when "R"
    y = 2
  when "O"
    y = 3
  when "G"
    y = 4
  when "P"
    y = 5
  end
  y
end



def score_check(turn, x)
  color_count = count($secret_code)
  turn.each_with_index do |value, i|
    if value == $secret_code[i]
      $turns_results[x][i] = " 2"
      color_count = count_minus(color_count, value)
    end
  end
  turn.each_with_index do |value, i|
    c_a_l = color_array_location(value)
    $secret_code.each_with_index do |secret, j|
      if (secret == value) && (color_count[c_a_l] > 0) && ($turns_results[x][i] != " 2")
        $turns_results[x][i] = " 1"
        color_count = count_minus(color_count,value)
        break
      elsif ($turns_results[x][i] != " 1") && ($turns_results[x][i] != " 2")
        $turns_results[x][i] = " 0"
      end
    end
  end     
  if turn != $secret_code
    return false
  else
    return true
  end
end

def turn_logic(turn, i)
  $turns[i] = turn
  $win = score_check(turn, i)
  game_display()
  if $win
    puts "You win!"
    $win = true
  end
end


def game_loop(play_a_round)
  while play_a_round == true
    game_setup()
    game_display()
    if $player == true
      $turns.each_with_index do |turn, i|
        $OK = false
        while $OK == false
          turn = player_choice() #gets player's choice, false if invalid input
        end
        turn_logic(turn, i)
        if $win == true
          break
        end
      end
      if $win != true
        puts "You didn't get it. So sad."
        puts "Winning combo was #{$secret_code[0]} #{$secret_code[1]} #{$secret_code[2]} #{$secret_code[3]}."
      end
      $player = false
    else
     puts "Computers turn!"
     $turns.each_with_index do |turn, i|
      turn = comp_choice() #gets computer's choice.
      turn_logic(turn, i) 
     end
     $player = true
    end
    puts "Would you like to play again?"
    play_again = ""
    while  play_again != "n" && play_again != "y"
      puts "Please type yes or no."
      play_again = gets.chomp
      play_again = play_again.chr
    end
    if play_again == 'n'
      play_a_round = false
      puts "Thank you for playing"
    end
  end
end

$player = true
$win = false
game_loop(true)



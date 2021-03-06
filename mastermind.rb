def game_setup
  if $player == true
   $secret_code = comp_choice()
  else
    puts "Your turn to make the secret code."
    $secret_code = player_choice()
  end
   $turns = Array.new(12) {Array.new(4, "-")}
   $turns_results = Array.new(12) {Array.new(4, " +")}
   $color_flag = Array.new(4){Array.new(2, 0)}
end

def game_display
  $turns.each_with_index do |turn, i|
    puts " #{turn[0]}  #{turn[1]}  #{turn[2]}  #{turn[3]}     #{$turns_results[i][0]} #{$turns_results[i][1]} #{$turns_results[i][2]} #{$turns_results[i][3]}"
  end
end

def player_choice
  $OK = true
  puts "Please enter the four colors you want, in order."
  puts "Choices are: Blue, Yellow, Red, Orange, Green, Purple, Cyan, and Magenta"
  choice = gets.upcase.chomp
  choice = choice.split(" ")
  if choice.length != 4
    puts "Four choices, please."
    $OK = false
  end
  choice.each_with_index do |color, i|
    color = color.chr
    choice[i] = color
    if (color != "B" && color != "Y" && color != "R" && color != "O" && color != "G" && color != "P" && color != "C" && color != "M")
      puts "Only valid choices, please."
      $OK = false
      break
    end
  end
  choice
end

def rand_color()
  x = rand(8)
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
  when 6
    x = "C"
  when 7
    x = "M"
  end
  x
end

def been_picked (color, index)
  been_picked = false
  $turns.each do |turn|
    if turn[index] == color
      been_picked = true
      break
    end  
  end
  been_picked
end

def comp_choice(i = 0)
  choice = Array.new(4)
  choice.each_with_index do |c,index|
    flagged = false
    if (i != 0 && $player == false)
      if $turns_results[i - 1][index] == " 2"
        x = $turns[i - 1][index]
      else
        $color_flag.each_with_index do |flag, j|
          if flag[0] == 1 
            y = been_picked(flag[1], index)
            if y == false
              x = flag[1]
              $color_flag[j] = [0,0]
              flagged = true
            break
            end
          end
        end
        if flagged == false
          been_picked = true
          while been_picked == true
            y = rand_color()
            been_picked = been_picked(y, index)
          end
          x = y
        end
      end
    else
      x = rand_color()
    end
    choice[index] = x
    if $player == false
      $turns[i][index] = x
      sleep(0.5)
      game_display()
      puts ""
    end
  end
  return choice
end

def count(x)
  color_count = Array.new(8,0)

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
    when "C"
      color_count[6] += 1
    when "M"
      color_count[7] += 1
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
    when "C"
      x[6] -= 1
    when "M"
      x[7] -= 1
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
  when "C"
    y = 6
  when "M"
    y = 7
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
        if $player == false
          $color_flag[i] = [1, value]
        end
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
    if $player
      puts "You win!"
    else
      puts "Computer won!"
    end
    $win = true
  end
end

def which_player()
  good_input = false
  while good_input == false
    puts "Would you like to be player 1 or 2?"
    x = gets.chomp
    x = x.to_i
    if x == 1
      $player = true
      good_input = true
    elsif x == 2
      $player = false
      good_input = true
    else
      puts "I'm sorry, I didn't understand. Just the number. 1 or 2?"
    end
  end
end



def game_loop(play_a_round)
  while play_a_round == true
    which_player()
    game_setup()
    game_display()
    puts ""
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
    else
     $turns.each_with_index do |turn, i|
      turn = comp_choice(i) #gets computer's choice.
      turn_logic(turn, i)
      puts ""
      if $win == true
        break
      end 
     end
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

puts "Welcome to Mastermind!"
puts "In this game one player will pick a four part combination of six"
puts "different colors. The other player will have to try to figure out"
puts "the correct colors in the correct order.\n"
puts "Each round, the guessing player will get a 2 for each correct color"
puts "placed at each correct position, a 1 for correct colors out of the"
puts "correct position, and a 0 if there are none. You will not get a 1"
puts "for a guess that has the correct color in the wrong place if you have"
puts "already recieved a 2.\n"
puts "Player 1 attempts to crack the code. Player 2 will create the code."
game_loop(true)



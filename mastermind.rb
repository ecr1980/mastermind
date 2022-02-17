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
   $secret_code = Combo.new()
   $choice_1 = Combo.new()
   $choice_2 = Combo.new()
   $choice_3 = Combo.new()
   $choice_4 = Combo.new()
   $choice_5 = Combo.new()
   $choice_6 = Combo.new()
   $choice_7 = Combo.new()
   $choice_8 = Combo.new()
   $choice_9 = Combo.new()
   $choice_10 = Combo.new()
   $choice_11 = Combo.new()
   $choice_12 = Combo.new()
end

def game_display
  $choice_1.array_display()
  $choice_2.array_display()
  $choice_3.array_display()
  $choice_4.array_display()
  $choice_5.array_display()
  $choice_6.array_display()
  $choice_7.array_display()
  $choice_8.array_display()
  $choice_9.array_display()
  $choice_10.array_display()
  $choice_11.array_display()
  $choice_12.array_display()
end

game_setup()

game_display()


class Game

def initialize(word)
	@word = word
end


def start
	errors = 6
	letters = []
	arr_w = @word.chars
	letter = ''
	alph = ('a'..'z').to_a

  #Начальная картинка
	current_path = File.dirname(__FILE__)
	file_path = current_path + "/img/6.txt"
	f = File.new(file_path, "r:UTF-8")
	lines = f.readlines
	f.close
	puts lines


	w = @word.gsub(/\S/, '*')

	while errors > 0 do

		puts "Remaining letters:  "
		puts alph.join(' ')

		#Проверка какие буквы должны быть видны
		c = 0
		while c < @word.size do
			if letters.include?(@word[c])
				w[c] = @word[c]
			end
			c += 1
		end


		puts "Your word: "  + w

		print errors
		puts " attempts left. Enter your letter: "
		letter = gets.chomp


		#Удаляем выбранную букву из алфавита
		alph.each do |n|
			 if letter == n
				alph.delete(n)
			 end
			end

    #Проверка на корректность введенного символа
		if letter.downcase =~ /[a-z]/ && letter.size == 1

			#Проверка была ли уже такая буква
			if letters.include?(letter)
				puts "You have already used this letter before "
			else
				letters << letter
			  if @word.include?(letter.to_s)
				  arr_w.delete(letter)

				  puts "Yep! It`s right"
					puts " "
			  else
				  errors -= 1
				  puts "Did not guess :("
					puts " "
			  end
			end

				if arr_w[0] == nil
					break
				end

		  else
			  puts "This is not letter! Try again."
			  puts " "
		  end


      #Открывается файл
			if errors >= 0
				file_path = current_path + "/img/#{errors}.txt"
				  f = File.new(file_path, "r:UTF-8")
				  lines = f.readlines
				  f.close
				  puts lines
			end


	end

	if arr_w == []
		puts "Congratulations! You win. Answer: " + @word
	else
		puts "Sorry... You lose. Answer: " + @word
	end

	end


end

  #game = Game.new("hangman")
	a = File.read("words.txt").split(' ').sample
	game = Game.new(a)
  game.start

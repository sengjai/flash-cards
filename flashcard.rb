# Main file for your code.
require 'csv'
require 'byebug'
require 'pp'

class QuizController

end

class Cards
	attr_accessor :definitions, :terms

	def initialize(hash={})
		@definitions = hash[:definitions]
		@terms = hash[:terms]
	end
end

class CardParser
	attr_reader :file

	def initialize(file)
		@file = file
		@cards = [] #even is definition , odd is terms
	end

	def game_cards
		temp_cards = []
		total_cards = []

		File.open(@file, "r") do |row|
			row.each_line do |line|
				if line != "\n"
					temp_cards << line
				end
			end
		end
		total_cards = Array.new(temp_cards.length/2) {
			temp_cards.shift(2)
		}

		for i in (0..(total_cards.length)-1)
			@cards << Cards.new(definitions: total_cards[i][0], terms: total_cards[i][1])
		end
 
  	return @cards
	end

	def random_card
		puts "Definition"
		id = rand(0..@cards.length-1)

		puts "#{@cards[id].definitions}"
		response = gets.chomp
		guess_card(response,id)
		
	end

	def guess_card(response, id)
		if response == @cards[id].terms.gsub(/\n/,"")
			puts "Guess: #{@cards[id].terms}"
			puts "Correct"
			puts "\n"
			random_card() #do random card again
		else
			puts "Guess: #{response}"
			puts "Incorrect! Try again"
			puts "\n"
			response2 = gets.chomp
			guess_card(response2,id)
			#do again
		end
	end
end

parser = CardParser.new('flashcard_samples.txt')
parser.game_cards
puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition"
puts "\n"
parser.random_card


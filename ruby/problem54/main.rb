class DataParser
  attr_reader :data

  def initialize(file)
    @data = []
    parse_file(file)
  end

  def parse_file(file)
    file.each_line do |line|
      cards = line.split(' ').map{|str| Card.new(str)}
      hand1 = cards.shift(5)
      hand2 = cards.pop(5)
      hands = [hand1, hand2].map{|cards| Hand.new(cards)}
      @data << hands
    end
  end
end

class Hand
  attr_reader :cards
  attr_accessor :score

  def initialize(cards)
    @cards = cards
  end

  def high_card
    cards.sort.last
  end

  def one_pair?
    group_by_num_counts(2)
  end

  def two_pairs?
    group_by_num_counts(2, 2)
  end

  def three_of_a_kind?
    group_by_num_counts(3)
  end

  def straight?
    straight = true
    sorted_cards = cards.sort

    sorted_cards.each_with_index do |card, index|
      next_card = sorted_cards[index + 1]
      break if next_card.nil?
      straight = card.number.next == next_card.number
      break unless straight
    end
    straight
  end

  def flush?
    cards.group_by(&:suit).keys.count == 1
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def four_of_a_kind?
    group_by_num_counts(4)
  end

  def straight_flush?
    straight? && flush?
  end

  def royal_flush?
    straight_flush? && cards.all?(&:face?)
  end

  def find_card_value
    hsh = cards.group_by(&:number).select{|num, cards| cards.count > 1}
    return if hsh.nil?
    # return the first card in the set of the biggest number of matching cards
    hsh.sort_by{|num, cards| cards.count}.reverse[0][1][0]
  end

  private

  def group_by_num_counts(card_count, result_size=1)
    cards.group_by(&:number).select{|num, cards| cards.count == card_count}.count == result_size
  end
end

class Card
  include Comparable
  attr_reader :number, :suit

  MAPPINGS = {
    'T' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }.freeze

  def initialize(str)
    determine_number_and_suit(str)
  end

  def face?
    number >= 10
  end

  private

  def <=>(other)
    number <=> other.number
  end

  def determine_number_and_suit(string)
    @number, @suit = string.split('')
    @number = MAPPINGS[@number] || @number.to_i
  end
end

class Scorer
  attr_reader :first_hand, :second_hand

  POINT_VALUES = {
    royal_flush: 9,
    straight_flush: 8,
    four_of_a_kind: 7,
    full_house: 6,
    flush: 5,
    straight: 4,
    three_of_a_kind: 3,
    two_pairs: 2,
    one_pair: 1
  }.freeze

  def initialize(first_hand, second_hand)
    @first_hand = first_hand
    @second_hand = second_hand
  end

  def evaluate(hand)
    points = 0
    POINT_VALUES.each_key do |key|
      if hand.public_send("#{key}?")
        points = POINT_VALUES[key]
        hand.score = key
        break
      end
    end
    points
  end

  def determine_winner
    first, second = [first_hand, second_hand].map{|hand| evaluate(hand)}
    if first > second
      'Player One'
    elsif first < second
      'Player Two'
    else
      if [:one_pair, :two_pairs, :three_of_a_kind, :four_of_a_kind, :full_house].include?(first_hand.score)
        compare(first_hand.find_card_value, second_hand.find_card_value, 0)
      else
        compare(first_hand.high_card, second_hand.high_card)
      end
    end
  end

  def compare(first_card, second_card, index=-1)
    if first_card > second_card
      'Player One'
    elsif first_card < second_card
      'Player Two'
    else
      index -= 1
      compare(first_hand.cards.sort[index], second_hand.cards.sort[index], index)
    end
  end
end

file = File.open('data.txt')
data = DataParser.new(file).data
one_wins = 0
data.each do |round|
  if Scorer.new(*round).determine_winner == 'Player One'
    one_wins += 1
  end
end
puts "Player 1 won #{one_wins} times"

class Test
  # Examples from https://projecteuler.net/problem=54
  def round_one
    test(%w(5H 5C 6S 7S KD), %w(2C 3S 8S 8D TD), 'Player Two')
  end

  def round_two
    test(%w(5D 8C 9S JS AC), %w(2C 5C 7D 8S QH), 'Player One')
  end

  def round_three
    test(%w(2D 9C AS AH AC), %w(3D 6D 7D TD QD), 'Player Two')
  end

  def round_four
    test(%w(4D 6S 9H QH QC), %w(3D 6D 7H QD QS), 'Player One')
  end

  def round_five
    test(%w(2H 2D 4C 4D 4S), %w(3C 3D 3S 9S 9D), 'Player One')
  end

  def test(one, two, expected_winner)
    [one, two].each do |arr|
      arr.map!{|str| Card.new(str)}
    end
    hand1 = Hand.new(one)
    hand2 = Hand.new(two)
    Scorer.new(hand1, hand2).determine_winner == expected_winner
  end
end

module BookKeeping
  VERSION = 3
end

class BeerSong
  def verse(n)
    first_verse = "#{bottles(n)} of beer on the wall, #{bottles(n)} of beer.".capitalize
    second_verse = 
      if n == 0
        "Go to the store and buy some more, #{bottles(99)} of beer on the wall."
      else
        "Take #{correct_pronoun(n)} down and pass it around, #{bottles(n-1)} of beer on the wall."
      end
    "#{first_verse}\n#{second_verse}\n"
  end

  def verses(beginning_verse, ending_verse)
    (ending_verse..beginning_verse).to_a.reverse.map {|n| verse(n)}.join("\n")
  end

  def bottles(n)
    case n
    when 1
      "1 bottle"
    when 0
      "no more bottles"
    else
      "#{n} bottles"
    end
  end

  def correct_pronoun(n)
    n == 1 ? "it" : "one"
  end
end

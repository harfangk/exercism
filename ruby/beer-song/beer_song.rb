module BookKeeping
  VERSION = 3
end

class BeerSong
  def verse(n)
    if n != 0
%Q(#{bottles(n)} of beer on the wall, #{bottles(n)} of beer.
Take #{correct_pronoun(n)} down and pass it around, #{bottles(n-1)} of beer on the wall.
)
    else
%Q(No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, #{bottles(99)} of beer on the wall.
)
    end
  end

  def verses(beginning_verse, ending_verse)
    beginning_verse.downto(ending_verse).map {|n| verse(n)}.join("\n")
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

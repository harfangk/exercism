module BookKeeping
  VERSION = 3
end

class BeerSong
  def verse(n)
    if n == 2
      %Q(#{n} bottles of beer on the wall, #{n} bottles of beer.
Take one down and pass it around, #{n - 1} bottle of beer on the wall.
)
    elsif n == 1
      %Q(#{n} bottle of beer on the wall, #{n} bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
)
    elsif n == 0
      %Q(No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
)
    else
      %Q(#{n} bottles of beer on the wall, #{n} bottles of beer.
Take one down and pass it around, #{n - 1} bottles of beer on the wall.
)
    end
  end

  def verses(beginning_verse, ending_verse)
    (ending_verse..beginning_verse).to_a.reverse.map {|n| verse(n)}.join("\n")
  end
end

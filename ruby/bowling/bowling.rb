module BookKeeping
  VERSION = 3
end

class Game
  attr_accessor :record_keeper

  def initialize
    @record_keeper = RecordKeeper.new(self)
  end

  def roll(pins)
    @record_keeper.process_roll(pins)
  end

  def score
    @record_keeper.calculate_score
  end
end

class RecordKeeper
  attr_reader :game, :frames_with_incomplete_score, :scored_frames, :current_frame, :frame_count

  def initialize(game)
    @game = game
    @frames_with_incomplete_score = []
    @scored_frames = []
    @current_frame = nil
    @frame_count = 0
  end

  def process_roll(pins)
    unless @current_frame
      @frame_count += 1
      @current_frame = Frame.new(@record_keeper, @frame_count)
    end
    
    @current_frame.add_knocked_down_pins(pins)
    @frames_with_incomplete_score.each { |f| f.add_score(pins) }
  end

  def calculate_score
    @scored_frames.map(:score).reduce(:+)
  end

  def conclude_frame(frame)
    @frames_with_incomplete_score << frame
    @current_frame = nil
  end

  def finished_scoring(frame)
    scored_frame = @frames_with_incomplete_score.find { |f| f.equal?(frame) }
    @scored_frames << scored_frame
    @frames_with_incomplete_score.delete_if { |f| f.equal?(frame) }
  end
end

class Frame
  attr_accessor :record_keeper, :knocked_down_pins, :scores, :frame_type

  def initialize(record_keeper, frame_count)
    @record_keeper = record_keeper
    @knocked_down_pins = []
    @scores = []
    @frame_type = "undecided"
    @frame_count = frame_count
  end

  def score
    @scores.reduce(:+)
  end

  def add_knocked_down_pins(pins)
    @knocked_down_pins << pins
    @scores << pins

    if concluded?
      evaluate_current_frame
      @record_keeper.conclude_frame(self)
    end
  end

  def add_score(pins)
    @scores << pins
    if scoring_completed?
      @record_keeper.finished_scoring(self)
    end
  end

  private

  def concluded?
    if @frame_count == 10
      (@knocked_down_pins.length == 2 && @knocked_down_pins.reduce(:+) < 10) || @knocked_down_pins.length == 3
    else
      @knocked_down_pins.first == 10 || @knocked_down_pins.length == 2
    end
  end

  def evaluate_current_frame
    if @knocked_down_pins.first == 10
      @frame_type = "strike"
    elsif @knocked_down_pins.reduce(:+) == 10
      @frame_type = "spare"
    else
      @frame_type = "open"
    end
  end

  def scoring_completed?
    if @frame_type == "strike" || @frame_type == "spare"
      @scores.length == 3 
    elsif @frame_type == "open"
      @scores.length == 2
    else
      false
    end
  end
end

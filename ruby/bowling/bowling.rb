module BookKeeping
  VERSION = 3
end

class Game
  def initialize
    @concluded_frames = []
    @scoring_completed_frames = []
    @current_frame = nil
  end

  def roll(pins)
    if is_pin_count_invalid?(pins)
      raise Game::BowlingError
    end

    if @current_frame == nil && @concluded_frames.length < 10
      @current_frame = Frame.new(self, @concluded_frames.length + 1)
    end
    
    @concluded_frames.each { |f| f.add_score(pins) }

    if @current_frame
      @current_frame.add_knocked_down_pins(pins)
    end
  end

  def score
    if is_game_unstarted_or_unfinished?
      raise Game::BowlingError
    end

    @scoring_completed_frames.map(&:score).reduce(&:+)
  end

  def conclude_frame(frame)
    @concluded_frames << frame
    @current_frame = nil
  end

  def completed_scoring_frame(frame)
    @scoring_completed_frames << frame
    @concluded_frames.delete_if { |f| f.frame_count == frame.frame_count }
  end

  def is_pin_count_invalid?(pins)
    pins < 0 || pins > 10
  end

  def is_game_unstarted_or_unfinished?
    @scoring_completed_frames.length == 0 || @scoring_completed_frames.length < 10
  end
end

class Frame
  attr_accessor :game, :knocked_down_pins, :scores, :frame_type, :frame_count

  def initialize(game, frame_count)
    @game = game
    @frame_count = frame_count
    @knocked_down_pins = []
    @scores = []
    @frame_type = "undecided"
  end

  def score
    @scores.reduce(:+)
  end

  def add_knocked_down_pins(pins)
    @knocked_down_pins << pins

    if are_pin_counts_invalid?
      raise Game::BowlingError
    end

    if concluded?
      evaluate_current_frame
      @game.conclude_frame(self)
    end

    add_score(pins)
  end

  def add_score(pins)
    if !scoring_completed? 
      if is_final_frame_score_invalid?
        raise Game::BowlingError
      end
      @scores << pins
      if scoring_completed?
        @game.completed_scoring_frame(self)
      end
    end
  end

  private

  def concluded?
    @knocked_down_pins.first == 10 || @knocked_down_pins.length == 2
  end

  def evaluate_current_frame
    if @knocked_down_pins.first == 10
      @frame_type = "strike"
    elsif @knocked_down_pins.reduce(&:+) == 10
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

  def are_pin_counts_invalid?
    @knocked_down_pins.length == 2 && @knocked_down_pins.reduce(&:+) > 10
  end

  def is_final_frame_score_invalid?
    if frame_count == 10
      if @scores 
    end
  end
end

class Game::BowlingError < StandardError
end

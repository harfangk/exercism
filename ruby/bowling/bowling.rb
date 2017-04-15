module BookKeeping
  VERSION = 3
end

class Game
  MAX_FRAME_COUNT = 10

  def initialize
    @frames = []
    @current_frame = nil
  end

  def roll(pins)
    if is_pin_count_invalid?(pins)
      raise Game::BowlingError
    end

    if finished_frames.length >= MAX_FRAME_COUNT
      raise Game::BowlingError
    end

    if @current_frame == nil && @frames.length < MAX_FRAME_COUNT
      @current_frame = Frame.new(self, @frames.length + 1)
      @frames << @current_frame
    end

    if @current_frame
      @current_frame.add_knocked_down_pins(pins)
    end

    frames_with_incomplete_scoring.each { |f| f.add_score(pins) }
  end

  def score
    if is_game_unstarted_or_unfinished?
      raise Game::BowlingError
    end

    finished_frames.map(&:score).reduce(&:+)
  end

  def conclude_current_frame
    @current_frame = nil
  end

  private

  def frames_with_incomplete_scoring
    @frames.reject { |f| f.scoring_completed? }
  end

  def finished_frames
    @frames.select { |f| f.scoring_completed? && f.concluded? }
  end

  def is_pin_count_invalid?(pins)
    !(0..10).include?(pins)
  end

  def is_game_unstarted_or_unfinished?
    @frames.length == 0 || finished_frames.length < MAX_FRAME_COUNT
  end
end

class Frame
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
      evaluate_frame_type
      conclude_frame
    end
  end

  def add_score(pins)
    if !scoring_completed?
      @scores << pins
      if @frame_count == 10 && scoring_completed?
        validate_final_frame_score
      end
    end
  end

  def concluded?
    @knocked_down_pins.first == 10 || @knocked_down_pins.length == 2
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

  private

  def evaluate_frame_type
    if @knocked_down_pins.first == 10
      @frame_type = "strike"
    elsif @knocked_down_pins.reduce(&:+) == 10
      @frame_type = "spare"
    else
      @frame_type = "open"
    end
  end

  def conclude_frame
    @game.conclude_current_frame
  end

  def are_pin_counts_invalid?
    @knocked_down_pins.length == 2 && @knocked_down_pins.reduce(&:+) > 10
  end

  def is_final_frame_score_invalid?(pins)
    if @scores.length < 2
      return false
    elsif @scores[0] == 10 && @scores[1] == 10
      false
    elsif @scores[0] == 10 && @scores[1] < 10
      @scores[1] + @scores[2] > 10
    end
  end

  def validate_final_frame_score
    case @frame_type
    when "open"
      if @scores.length > 2
        raise Game::BowlingError
      end
    when "spare"
      if (@scores[0] + @scores[1]) > 10 || @scores[2] > 10
        raise Game::BowlingError
      end
    when "strike"
      if @scores[1] < 10 && (@scores[1] + @scores[2]) > 10 
        raise Game::BowlingError
      end
    end
  end
end

class Game::BowlingError < StandardError
end

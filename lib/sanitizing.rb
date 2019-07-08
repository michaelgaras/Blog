# frozen_string_literal: true

class Sanitizing
  def self.sanitize_upcase(word)
    word.split.map(&:capitalize).join(' ')
  end

  def self.sanitize_downcase(word)
    word.split.map(&:downcase).join(' ')
  end
end

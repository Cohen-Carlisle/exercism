class School
  VERSION = 1

  def initialize
    @grades = Hash.new { [] }
  end

  def add(*students, grade)
    @grades[grade] = (@grades[grade] + students).sort!
    @grades = Hash[@grades.sort]
    @grades.default_proc = proc { [] }
  end

  def grade(grade)
    @grades[grade]
  end

  def to_h
    @grades
  end
end

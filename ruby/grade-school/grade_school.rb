module BookKeeping
  VERSION = 3
end

class School
  def initialize()
    @students = []
  end

  def students(grade)
    @students.find_all {|s| s[:grade] == grade}.reduce([]) {|memo, x| memo << x[:name]}.sort
  end

  def add(student, grade)
    @students << {grade: grade, name: student}
  end

  def students_by_grade
    grades = @students.reduce([]) {|memo, s| memo << s[:grade]}.uniq.sort
    grades.map {|g| {grade: g, students: students(g)}}
  end
end

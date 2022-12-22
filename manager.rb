require_relative "employee"

class Manager < Employee
  attr_reader :employees
  def initialize(name, salary, title, boss = nil)
    super(name, salary, title, boss)
    @employees = [] 
  end

  def add_employee(subordinate)
    employees << subordinate
    subordinate
  end

  def bonus(multiplier)
    self.bonus_calculation * multiplier
  end
 
  protected
  def bonus_calculation
    total_salary = 0
    self.employees.each do |subordinate|
      subordinate.is_a?(Manager) ? total_salary += subordinate.salary + subordinate.bonus_calculation : total_salary += subordinate.salary
    end
    total_salary
  end

end


Ned = Manager.new("Ned", 1_000_000, "Founder")
Darren = Manager.new("Darren", 78_000, "TA Manager", Ned)
Shawna = Employee.new("Shawna", 12_000, "TA", Darren)
David = Employee.new("David", 10_000, "TA", Darren)

p Ned.bonus(5) # => 500_000
p Darren.bonus(4) # => 88_000
p David.bonus(3) # => 30_000

# p Ned
# p David
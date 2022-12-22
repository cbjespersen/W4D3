class Employee
  attr_reader :name, :salary, :title
  attr_accessor :boss

  def initialize(name, salary, title, boss=nil)
    @name, @salary, @title = name, salary, title
    self.boss = boss 
  end

  def boss=(boss)
    @boss = boss
    boss.add_employee(self) unless boss.nil?
  end

  def bonus(multipler)
    self.salary * multipler
  end
end




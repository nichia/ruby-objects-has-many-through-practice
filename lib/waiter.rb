require 'pry'
require_relative './customer.rb'
require_relative './meal.rb'

class Waiter

  attr_accessor :name, :yrs_experience

  @@all = []

  def initialize(name, yrs_experience)
    @name = name
    @yrs_experience = yrs_experience
    @@all << self
  end

  def self.all
    @@all
  end

  def new_meal(customer, total, tip=0)
    Meal.new(self, customer, total.to_f, tip.to_f)
  end

  def meals
    Meal.all.select do |meal|
      meal.waiter == self
    end
  end

  # A list of the names of customers that a specific waiter has served
  def customers
    meals.collect do |meal|
      meal.customer
    end
  end

  # The average years of experience of all waiters
  def self.avg_yrs_experience
    total_yrs = 0
    self.all.each do |waiter|
      total_yrs += waiter.yrs_experience
    end
    avg_experience = total_yrs / self.all.count
  end

  # The customer that has tipped a specific waiter the highest percentage
  def highest_tipper

    highest_tip = 0
    high_tipper = nil
    meals.each do |meal|
      #binding.pry
      if ((meal.tip.to_f / meal.total.to_f) * 100) > highest_tip
        highest_tip = ((meal.tip.to_f / meal.total.to_f) * 100)
        high_tipper = meal.customer
      end
    end
    high_tipper
  end

  # The average tips for the most experienced waiter and the average tips for the least experienced waiter
  def self.avg_tips
    # most_experienced_waiter
    #most_experienced = 0
    #self.all.each do |waiter|
      #binding.pry
      #if waiter.yrs_experience > most_experienced
      #  most_experienced = waiter.yrs_experience
      #  most_experienced_waiter = waiter
      #end
    #end

    #least_experienced_waiter
    #least_experienced = 100
    #least_experienced_waiter = nil
    #self.all.each do |waiter|
    #binding.pry
    #  if waiter.yrs_experience < least_experienced
    #    least_experienced = waiter.yrs_experience
    #    least_experienced_waiter = waiter
    #  end
    #end

    binding.pry
    sorted_all = Waiter.all.sort_by { |w| w.yrs_experience }

    most_experienced_waiter = sorted_all.last
    least_experienced_waiter = sorted_all.first

    puts "Most Experienced Waiter: #{most_experienced_waiter.name}"
    self.waiter_avg_tips(most_experienced_waiter)

    puts "Least Experienced Waiter: #{least_experienced_waiter.name}"
    self.waiter_avg_tips(least_experienced_waiter)
  end

  def self.waiter_avg_tips(waiter)
    total_tips = 0
    count = 0
    Meal.all.each do |meal|
      #binding.pry
      if meal.waiter == waiter
        total_tips += meal.tip
        count += 1
      end
    end
    avg_tips = total_tips / count
    puts "#{waiter.name}'s Average Tips: #{avg_tips}"
  end

end

sam = Customer.new("Sam", 27)
sally = Customer.new("Sally", 31)
sean = Customer.new("Sean", 55)


pat = Waiter.new("Pat", 22)
alex = Waiter.new("Alex", 35)
peter = Waiter.new("Peter", 45)
abby = Waiter.new("Abby", 21)
paul = Waiter.new("Paul", 37)
sam.new_meal(pat, 50, 10)
sam.new_meal(alex, 20, 3)
pat.new_meal(sam, 30, 5)
sally.new_meal(alex, 100, 25)
sally.new_meal_20_percent(pat, 75)
sean.new_meal_20_percent(alex, 46)
sean.new_meal_20_percent(abby, 40)
sean.new_meal_20_percent(peter, 67)
sam.new_meal(abby, 100, 22)
sally.new_meal(peter, 110, 25)

Waiter.avg_tips

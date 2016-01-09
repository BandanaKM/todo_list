module Menu
  # doctest: List the options for use
  # >> Menu.menu.is_a?(String)
  # => true
  def self.menu
    " Welcome to Bandana's Awesome Menuing System!
    This menu will help you use the Task List System
    1) Add
    2) Show
    3) Update
    4) Delete
    5) Write to File
    6) Read from File
    7) Toggle Status
    Q) Quit "
  end

  # doctest: Linify the menu
  # >> Menu.show.include?('2')
  # => true
  def self.show
    self.menu
  end
end

module Promptable
  def prompt(message = "Just the facts, ma'am.", symbol = ':> ')
    print message
    print symbol
    gets.chomp
  end
end
include Promptable

# doctest: I can initialize a List object
# >> List.new.class
# => List
class List
  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

  # the initialize method constructs the data structure

  # doctest: Add a task
  # >> ml =  List.new
  # >> ml.add(Task.new('Add something to the master list')).length
  # => 1
  # doctest: Add a another task to the List
  # >> ml.add(Task.new('Fix faucet')).length
  # => 2
  def add(task)
    all_tasks << task
  end

  # doctest: Delete a single task
  # >> ml = List.new
  # Set up the things that we want on the list, in this case
  # just words, one word for each "task""
  # >> things = %w[cookie brownie spinach cake pie]
  # and now we collect the things into our task list.
  # >> things.map {|t| ml.add(t) }
  # >> ml.delete(3)
  # => 'spinach'
  # >> ml.show.include?('spinach')
  # =>  false
  def delete(task_number)
    all_tasks.delete_at(task_number - 1)
  end

  # doctest: Update the task
  # >> ml = List.new
  # >> things = %w[cookie brownie spinach cake pie]
  # >> things.map {|t| ml.add(t) }
  # >> ml.update(3, Task.new('jello'))
  # doctest: while updating we drop the old
  # >> ml.show.include?('spinach')
  # => false
  # doctest: and bring in the new
  # >> ml.show.include?('jello')
  # => true
  def update(task_number, task)
    all_tasks[task_number - 1] = task
  end

  # doctest: Show the task
  # >> ml =  List.new
  # >> ml.add(Task.new('Add something to the master list')).length
  # => 1
  # >> ml.show.empty?
  # => false
  # doctest: Show multiple tasks (all the tasks)
  # >> ml.add(Task.new('Fix faucet')).length
  # => 2
  # >> ml.show.split(/\n/).all? {|s| !s.empty?}
  # =>true
  def show(linify: true)
    result = linify ? linify(task_report) : task_report
    result.join("\n")
  end

  def write_to_file(filename)
    machinified = @all_tasks.map(&:to_machine).join("\n")
    IO.write(filename, machinified)
  end

  def read_from_file(filename)
    IO.readlines(filename).each do |line|
      status, *description = line.split(':')
      status = status.include?('X')
      add(Task.new(description.join(':').strip, status))
    end
  end

  def toggle(task_number)
    all_tasks[task_number - 1].toggle_status
  end

  private

  def linify(text)
    text.map.with_index { |l, i| "(#{i.next}): #{l}" }
  end

  def task_report
    all_tasks.collect(&:to_s)
  end

  # menu items
end

class Task
  attr_reader :description
  attr_accessor :complete

  def initialize(description, completed_status = false)
    @description = description
    @complete = completed_status
  end

  # doctest: task responds to complete
  # >> Task.allocate.respond_to?(:complete)
  # => true
  # doctest: By default my task is incomplete
  # >> mt = Task.new('Make a task')
  # >> mt.complete
  # => false
  # doctest: I can set the task as complete
  # >> mt.complete = true
  # >> mt.complete
  # => true
  alias :status :complete

  # to represent the task as a string
  def to_s
    "#{represent_status} : #{description}"
  end

  def to_machine
    "#{represent_status}:#{description}"
  end

  def represent_status
    "#{completed? ? '[X]' : '[ ]'}"
  end

  def completed?
    complete
  end

  # doctest: I can toggle the status of a task
  # >> mt.toggle_status
  # => false
  # >> mt.toggle_status
  # => true
  def toggle_status
    self.complete = !completed?
  end

  # clarify to_s
end

if __FILE__ == $PROGRAM_NAME
  ml = List.new
  puts 'Please choose from the following list'
  until ['q'].include?(user_input = prompt(Menu.show).downcase)
    case user_input
    when '1'
      ml.add(Task.new(prompt('What is the task you would like to accomplish?')))
    when '2'
      puts ml.show
    when '3'
      ml.update(prompt('Which task to update?').to_i, Task.new(prompt("Task Description?")))
    when '4'
      puts ml.show
      ml.delete(prompt('Which task to delete?').to_i)
    when '5'
      ml.write_to_file(prompt 'What is the filename to write to?')
    when '6'
      begin
        ml.read_from_file(prompt('What is the filename to read from?'))
      rescue Errno::ENOENT
        puts "File name not found, please verify your file name and path."
      end
    when '7'
      puts ml.show
      ml.toggle(prompt('Which would you like to toggle the status for?').to_i)
    else
      puts 'Try again, I did not understand.'
    end
    prompt('Press enter to continue', '')
  end
  puts 'Outro - Thanks for using the awesome Bandana Malik Menuing System!'
end

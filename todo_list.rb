module Menu
  # doctest: List the options for use
  # >> Menu.menu
  # => "Add\nShow\nRead from file\nWrite to file\nQuit"
  def self.menu
    ['Add', 'Show', 'Read from file', 'Write to file', 'Quit'].join("\n")
  end

  # doctest: Linify the menu
  # >> Menu.show
  # => "1: Add\n2: Show\n3: Read from file\n4: Write to file\n5: Quit"
  def self.show
    menu.each_line.with_index(1).map { |t, i| "#{i}: #{t}" }.join
  end
end

module Promptable
  def prompt(message = "Just the facts, ma'am.", symbol = ':> ')
    puts message
    print symbol
    gets
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
    @all_tasks << task
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
    @all_tasks.delete_at(task_number - 1)
  end

  # doctest: Show the task
  # >> ml =  List.new
  # >> ml.add(Task.new('Add something to the master list')).length
  # => 1
  # >> ml.show
  # => 'Add something to the master list'
  # doctest: Show multiple tasks (all the tasks)
  # >> ml.add(Task.new('Fix faucet')).length
  # >> ml.show
  # => "Add something to the master list\nFix faucet"
  def show
    all_tasks.collect(&:to_s).join("\n")
  end

  def write_to_file(filename)
    IO.write(filename, show)
  end

  def read_from_file(filename)
    IO.readlines(filename).each do |line|
      add(Task.new(line.chomp))
    end
  end

  # menu items
end

class Task
  attr_reader :description

  def initialize(description)
    @description = description
  end

  # to represent the task as a string
  def to_s
    description
  end

  # clarify to_s
end

if __FILE__ == $PROGRAM_NAME
  ml = List.new
  puts 'Please choose from the following list'
  # A prompting method can clean this duplication up nicely
  until 5 == user_input = prompt(Menu.show).to_i
    puts Menu.show
    case user_input
    when 1
      ml.add(prompt('What is the task you would like to accomplish?').chomp)
    when 2
      puts ml.show
    when 3
      puts 'What is the filename to read from?'
      filename = gets.chomp
      ml.read_from_file(filename)
    when 4
      puts 'What is the filename to write to?'
      filename = gets.chomp
      ml.write_to_file(filename)
    else
      puts 'Try again, I did not udnerstand.'
    end
    prompt("Press enter to continue", '')
  end
  puts 'Outro - Thanks for using the awesome Bandana Malik Menuing System!'
end

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
  # doctest: Show the task
  # >> ml.show
  # => 'Add something to the master list'
  # doctest: Add a another task to the List
  # >> ml.add(Task.new('Fix faucet')).length
  # => 2
  # doctest: Show multiple tasks (all the tasks)
  # >> ml.show
  # => "Add something to the master list\nFix faucet"
  def add(task)
    @all_tasks << task
  end

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

  def to_s
    description
  end

  # clarify to_s
end

module UserInterface
  # doctest: List the options for use
  # >> UserInterface.menu
  # => "Add\nShow\nRead from file\nWrite to file\nQuit"
  def self.menu
    ['Add', 'Show', 'Read from file', 'Write to file', 'Quit'].join("\n")
  end

  # doctest: Linify the menu
  # >> UserInterface.show_menu
  # => "1: Add\n2: Show\n3: Read from file\n4: Write to file\n5: Quit"
  def self.show_menu
    menu.each_line.with_index(1).map { |t, i| "#{i}: #{t}" }.join
  end
end

if __FILE__ == $PROGRAM_NAME
  ml = List.new
  puts 'Please choose from the following list'
  puts UserInterface.show_menu
  # A prompting method can clean this duplication up nicely
  until 5 == user_input = gets.to_i
    puts UserInterface.show_menu
    case user_input
    when 1
      puts 'What would you like to name your task?'
      ml.add(gets.chomp)
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
    puts 'Press any key to continue'
    gets
  end
  puts 'Outro - Thanks for using the awesome Bandana Malik Menuing System!'
end

# update a task
# delete a task

# Remember, there are four high-level responsibilities, each of which have
# multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (persisting models to
# non-volatile storage, aka "the hard drive")
# 4. Manipulating the in-memory objects that model a real-life TODO list
# (model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of
# responsibilities (1), (2), and (3).

class List
  attr_reader :all_tasks, :file_name, :num_of_tasks
  def initialize(file_name)
    @file_name = file_name
    @all_tasks = []
  end

  def parse
    File.open(file_name, 'r').each do |task|
      new_task = Task.new(task.chomp)
      new_task.complete = true if task.include?('[X]')
      strings_only(new_task)
      @all_tasks << new_task
    end
  end

  # Method strips checkboxes and leading whitespaces from
  # task descriptions
  def strings_only(task)
    task = task.to_s
    task.gsub!('[X]', '').lstrip! if task.include?('[X]')
    task.gsub!('[ ]', '').lstrip! if task.include?('[ ]')
  end

  def display_list
    @all_tasks.map.with_index do |task, index|
      index += 1
      "#{index}) #{checkbox?(task)}"
    end.join("\n")
  end

  def checkbox?(task, _index = nil)
    if task.complete?
      "[X] #{task}"
    else
      "[ ] #{task}"
    end
  end

  def save_list
    new_file = File.open(file_name, 'w')
    @all_tasks.each do |task|
      new_file.puts checkbox?(task)
    end
  end

  def delete_task(task)
    task_to_delete = find_task(task)
    @all_tasks.delete(task_to_delete)
  end

  def find_task(task_num)
    num_of_tasks = @all_tasks.length
    if (1..num_of_tasks).include?(task_num)
      return @all_tasks[task_num - 1]
    else
      return 'Task not found.'
    end
  end

  def add_task(task)
    @all_tasks << task
  end

  def complete_task(task)
    completed_task = find_task(task)
    return completed_task if completed_task.is_a?(String)
    completed_task.check_off_task
    completed_task.complete = true
  end
end

class Task
  attr_accessor :complete, :description
  def initialize(description)
    @description = description
    @complete = false
  end

  # delete these two methods and assign checkbox status at List#display_list
  # method
  def check_off_task
    description.gsub!('[ ]', '[X]')
  end

  def uncheck_task
    description.gsub!('[X]', '[ ]')
  end

  def complete?
    complete
  end

  def to_s
    description
  end
end

class UserView
  def self.machine_confirmation(command, task)
    case command
    when 'add'
      puts "\"#{task}\" has been added to your list!"
    when 'complete'
      puts "\"#{task}\" has been completed!"
    when 'delete'
      puts "\"#{task}\" has been deleted!"
    end
  end
end

# controller
test_list = List.new('test_list.txt')
test_list.parse
command, *rest = ARGV
rest = rest.join(' ')
case command
when 'print'
  puts test_list.display_list
when 'add'
  new_task = Task.new(rest)
  test_list.add_task(new_task)
  test_list.save_list
  UserView.machine_confirmation(command, rest)
when 'complete'
  rest = rest.to_i
  task = test_list.find_task(rest)
  if test_list.all_tasks.include?(task)
    test_list.complete_task(rest)
    test_list.save_list
    UserView.machine_confirmation(command, task)
  end
when 'delete'
  rest = rest.to_i
  task = test_list.find_task(rest)
  if test_list.all_tasks.include?(task)
    test_list.delete_task(rest)
    test_list.save_list
    UserView.machine_confirmation(command, task)
  end
end

# view
# possibly superfluous class

# DRIVER TESTS
test_list = List.new('test_list.txt')
test_list.parse
p test_list.all_tasks
puts test_list.display_list
p '#########################'
p test_list.find_task(1)
test_list.delete_task(11)
puts test_list.display_list

# I want to be able to open a file
# I want to be able to complete tasks by typing complete followed by task
# number

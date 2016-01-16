```
User Story 4: As a user I can save a list to a text file 
```

Congratulations, you finished all the core user stories. We'll now work on the secondary user stories. Building these will allow users to save a list to a text file, read a list from a text file, delete a task from a list and update a task on a list.

The following approach will allow you to save a list to a file when you run the Todo List application from the command line. This specific approach allows you name the specific text file to save to. 


1. Create method that takes a `filename` as an argument. The method should write the tasks to a file. 

As a hint, use a class that allows you to write to a file. Also, be sure to join each task on a new line. 


```
def write_to_file(filename)
  IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
end
```


2. Nice work. Update the menu so that it displays a new option to "Write to File". 

```
module Menu

  def self.menu
    " Welcome to the TodoLister Program!
    This menu will help you use the Task List System
    1) Add
    2) Show
    3) Write to File
    4) Read from File
    Q) Quit "
  end

... 

end 

```


3. Add the `write_to_file` method to the program runner. 

```
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
      ml.write_to_file(prompt 'What is the filename to write to?')
    else
      puts 'Try again, I did not understand.'
    end
    prompt('Press enter to continue', '')
  end
  puts 'Outro - Thanks for using the awesome TodoLister Menu System!'
end

```


4. Run the program. Go ahead and save the Todo List to the text file. 

BM -- ocme back to this - users need more detail on how ot run the program, and to save it as a text file. 

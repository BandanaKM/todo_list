```
User Story 3: As a user I can see all tasks in a list. 
```

You have now built the functionality that allows a user to create and make lists within the to do list. The next core user story is to see all tasks in a list. 

We'll be doing this by creating a `show` method. It is important to note that, for the `show` method to display the description of the tasks correctly, it must display the description of the task as a string, and not display the tasks as object.


1. Create a method to turn a task's description into a string. 


```
class Task 

  def to_s
    description
  end

```


2. Create a `show` method that shows all tasks in the list. 


```
class List

  def show
    all_tasks.collect(&:to_s)
  end

```


3. Add the show method to the program runner.


```

if __FILE__ == $PROGRAM_NAME
  ml = List.new
  puts 'You have created a new list'
  ml.add(Task.new('Make Breakfast')
  puts 'You have added a task to the todo list'
  ml.show
end 

```


4. Run the program. 
```
User Story 2: As a user I can add tasks to the todo list
```

By this point you've built functionality to allow a user to create a to do list. The next step to build the next user story, to allow a user to add tasks to the list.


Task Class Guidelines 


1. Create a task class. 

*** Hide/Show *** 

```
class Task

end
```


2. In Object Oriented Programming I, you learned about instance variables, which assign information to class instances. 

*** Hide/Show *** 

```
class Task

  def initialize(description)
    @description = description
  end

end 

```


3. Let’s write one more piece of code before testing to see if it works. Remember attribute accessor methods? We use them to read and/or write instance variables. Use an attribute reader method for `description` so we can easily find out what any Task’s description is.

*** Hide/Show *** 

```
class Task
  attr_reader :description

  ...

end 

````


4. Now that we have a `class Task`, let's think about how we would add tasks to a list. While a class Task manages actions that can be implemented on a task object, the class List handles  actions implemented on a List oject. 

In the `class List`, create an initialize method. The initialize method will initialize a List object with an array that stores all tasks called `all_tasks`. 


*** Hide/Show *** 

```
class List

  def initialize
    @all_tasks = [] 
  end

end 

````


5. Add an attribute reader that will allow you to read the array attribute that stores all tasks. 


*** Hide/Show *** 

```
class List
  attr_reader :all_tasks

  ...

end 

```


6. In the `class List`, create an `add` method that accepts a task as an argument. The method should add the task to the array that stores all tasks. 


*** Hide/Show *** 

```
 def add(task)
    all_tasks << task
 end

```


7. Nice work. We can use the `add` method to add a new Task object in the program. 

Complete the runner to test out the add method. Call the add method on the list, instantiating a new instance of Task class. 


*** Hide/Show *** 

```
if __FILE__ == $PROGRAM_NAME
  ml = List.new
  puts 'You have created a new list'
  ml.add(Task.new('Make Breakfast')
  puts 'You have added a task to the todo list'
end 

````


8. Run the program from the command line.
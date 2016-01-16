```
User Story 1: As a user I can create a todo list
```

Houses are built brick by brick. We have our plan for Todo List, and now it is time to build. Let’s create a workflow to adhere to as we add features and iterate upon them:

Todo List Workflow

Build a piece then test it, build another piece, then test it.
Know that each brick is sound and stable before you put another one on top of it.

Core Features: Classes With Core Program Behaviors

If we think high-level about Todo List, the most important thing it should be able to do is create a list. 

We can accomplish this by creating a List class that makes new List List instances when called with the `.new` method. If these concepts seem a little hazy, that’s okay. Check out Object Oriented Programming I for a quick refresher.


List Class Guidelines

1. Create a Ruby file to serve as your main code file for this project. You can call it todo_list.rb. 


2. Create a List class

**Hide/Show**

```ruby
class List
end
```


3. Beneath the list class, write code to run the program 

**Hide/Show**

```ruby 
if __FILE__ == $PROGRAM_NAME
  ml = List.new
  puts 'You have created a new list'
end 
```

4. Run the program from the command line with `ruby todo_list.rb`. 

**Hide/Show**

ruby todo_list.rb


Nice! We now have a list class. It’ll need to be filled out with instance variables and instance methods, but we’ve addressed the first user story, so let’s move to the next one.
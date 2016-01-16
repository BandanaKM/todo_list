Note: No user story 

Beginner programmers are often surprised to learn that program design involves very little coding. Step 3 is all about programmatic thinking: understanding the real-world problem your program is attempting to address, then breaking that down into small, manageable steps that a computer can solve.

Object-Oriented Thinking - Classes, Methods, And Actions

Now for the tough part: let’s translate our ideas into the building blocks that will become our code in the next step.

The Todo List will have a two different major constructs: lists and tasks. You can make these objects in Ruby by writing them as a Classes. Remember, Classes are just bundles of methods that you can make to do just about anything you want (you can review Classes here).

Todo List should also be able to do some essential actions for us too. This is where our user stories come in. They will help us determine what kinds of methods and actions we will write later on to make Todo List come to life.

Make An Outline Of Your Classes, Methods, And Actions

Suggested Classes And Methods:

List Class
  Create a list
  Add task to list
  Show all tasks
  Read a List from a File
  Write a List to a File
  Delete a task
  Update a task

Task Class
  Create a task item

Actions

These can be mapped directly from the brainstorming you did in your outline. A number of examples for useful methods await you further down in this guide in case you forgot any.

This program will also make use of Modules.

*******BM ADD SOMETHING ABOUT MODULES HERE********


Single File Program Organization

A quick word on organizing your code: The Todo List code examples in this project guide assume that you’ll be writing your program as a single file. We’ve named ours todo_list.rb You can of course name yours whatever makes sense to you.

It’s perfectly fine for a program of this size to label different sections with comments. For example, your Classes can begin under a line with the comment #Classes, and your actions (which should be written below the Classes) can start under a line that says #actions
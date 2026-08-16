    # Class representing a single task
class Task
    attr_accessor :title, :completed


    # Initialize a new task with a title and default completed status
    def initialize(title)
        @title = title      # Store the task title
        @completed = false  # Default to not completed
    end
end


    # Class that manages a list of tasks
class TaskManager
    def initialize
        @tasks = []     # Array to store task objects
    end


    # Add a new task
    def add_task
        print "Enter task title:"
        title = gets.chomp      # Get input from the user
        @tasks << Task.new(title)       # Create and add a new task object
        puts "Task added!"
    end


        # List all tasks
    def list_tasks
        if @tasks.empty?    # Check if there are no tasks
            puts "No task registered."
            return
        end

        @tasks.each_with_index do |task, index|
            status = task.completed ? "✓" : "✗"
            puts "#{index + 1}. [#{status}] #{task.title}"
        end
    end


        # Mark a task as completed
    def completed_task
        list_tasks
        print "Number of tasks to complete:"
        num = gets.to_i - 1     # Convert input to array index

        if @tasks[num]       # Check if the task exists
            @tasks[num].completed = true
            puts "Task completed!"
        else
            puts "Invalid task number."
        end
    end


        # Delete a task
    def delete_task
        list_tasks
        print "Number of tasks to delete:"
        num = gets.to_i - 1

        if @tasks[num]
            @tasks.delete_at(num)        # Remove task from the array
            puts "Task deleted!"
        else
            puts "Invalid task number."
        end
    end


    # Main menu loop
    def menu
        loop do
            puts "\n########## Task Manager ##########"
            puts "1. Add Task"
            puts "2. List Tasks"
            puts "3. Complete Task"
            puts "4. Delete Task"
            puts "5. Exit"
            print "Choose an option:"

            option = gets.to_i      # Get user input

            case option
            when 1
                add_task
            when 2
                list_tasks
            when 3
                completed_task
            when 4
                delete_task
            when 5
                puts "Exiting..."
                break
            else
                puts "Invalid option. Please try again."
            end
        end
    end
end


    # Create a TaskManager instance and start the menu
task_manager = TaskManager.new
task_manager.menu

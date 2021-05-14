require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true

require_relative "task"

# TODO: CRUD some tasks

# 1. Implement the READ logic to find a given task
#    (by its id)
puts ' ~~~~~ Test 1: READ ONE ~~~~~'
task = Task.find(1)
puts "#{task.title} = #{task.description}"

# 2. Implement the CREATE logic in a save instance method
puts ' ~~~~~ Test 2: CREATE ~~~~~'
task = Task.new(title: 'Enjoy the weekend',
                description: 'Relax and take it easy')
task.save
puts "Task id: #{task.id}"

# 3. Implement the UPDATE logic in the same method
puts ' ~~~~~ Test 3: UPDATE ~~~~~'
task = Task.find(1)
task.done = true
task.save

task = Task.find(1)
done = task.done ? 'X' : ' '
puts "[#{done}] - #{task.title}"

# 4. Implement the READ logic to retrieve all tasks
#    (what type of method is it?)
puts ' ~~~~~ Test 4: READ ALL ~~~~~'
tasks = Task.all
tasks.each do |task|
  done = task.done ? 'X' : ' '
  puts "[#{done}] - #{task.title}"
end

# 5. Implement the DESTROY logic on a task
puts ' ~~~~~ Test 5: DESTROY ~~~~~'
task = Task.find(2)
task.destroy

task = Task.find(2)
puts "Deleted? #{task == nil}"

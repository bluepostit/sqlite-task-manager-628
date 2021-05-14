# For Task class
class Task
  attr_accessor :id, :done
  attr_reader :title, :description

  def initialize(attr = {})
    @title = attr[:title]
    @description = attr[:description]
    @id = attr[:id]
    @done = attr[:done] || false
  end

  def save
    if @id.nil?
      insert
    else
      update
    end
  end

  def destroy
    query = 'DELETE FROM tasks WHERE id = ?'
    DB.execute(query, @id)
  end

  def self.find(id)
    query = <<-SQL
      SELECT * FROM tasks
      WHERE id = ?
    SQL
    result = DB.execute(query, id).first
    return nil if result.nil?

    build_task(result)
  end

  def self.all
    query = 'SELECT * FROM tasks'
    DB.execute(query).map { |row| build_task(row) }
  end

  def self.build_task(row)
    row[:title] = row['title']
    row[:description] = row['description']
    row[:id] = row['id']
    row[:done] = row['done'] == 1
    new(row)
  end

  private

  def insert
    query = <<-SQL
      INSERT INTO tasks (title, description, done)
      VALUES (?, ?, ?)
    SQL
    done = @done ? 1 : 0
    DB.execute(query, @title, @description, done)
    @id = DB.last_insert_row_id
  end

  def update
    query = <<-SQL
      UPDATE tasks
      SET title = ?, description = ?, done = ?
      WHERE id = ?
    SQL
    done = @done ? 1 : 0
    DB.execute(query, @title, @description, done, @id)
  end
end

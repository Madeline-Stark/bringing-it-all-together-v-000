class Dog
attr_accessor :id, :name, :breed

def initialize(id: id=nil, name: name, breed: breed)
  @id = id
  @name = name
  @breed = breed
end

def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
        SQL
    DB[:conn].execute(sql)
end

def self.drop_table
  sql = <<-SQL
    DROP TABLE dogs
      SQL
  DB[:conn].execute(sql)
end

def self.new_from_db(row)
    new_dog = self.new(id: row[0], name: row[1], breed: row[2])
    new_dog
end

def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE name = ?
      LIMIT 1
    SQL

    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
end





end

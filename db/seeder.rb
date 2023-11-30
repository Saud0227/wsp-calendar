require 'sqlite3'

class Seeder

    def self.seed!
        puts "Seeding the DB"
        drop_tables
        create_tables
        seed_data
        puts "Seed complete"
    end

    private

    def self.db
        return @db if @db
        @db = SQLite3::Database.new('db/calendar.sqlite')
        @db.results_as_hash = true
        return @db
    end

    def self.drop_tables
        puts "  * Dropping Tables"
        db.execute('DROP TABLE IF EXISTS doors')
    end
    
    
    def self.create_tables
        puts "  * Creating tables"
        db.execute('CREATE TABLE doors(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            day INTEGER NOT NULL,
            opened BOOLEAN DEFAULT false
        )')
    end
    
    def self.seed_data
        puts "  * Seeding tables"
        (1..24).to_a.shuffle.each { |day| db.execute('INSERT INTO doors (day) VALUES (?)', day) }
    end
end
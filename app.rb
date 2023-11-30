class Calendar < Sinatra::Base

    def db
        return @db if @db
        @db = SQLite3::Database.new('./db/calendar.sqlite')
        @db.results_as_hash = true
        return @db
    end

end



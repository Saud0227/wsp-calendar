class Calendar < Sinatra::Base

    def db
        return @db if @db
        @db = SQLite3::Database.new('./db/calendar.sqlite')
        @db.results_as_hash = true
        return @db
    end

    get '/' do
        @doors = db.execute('SELECT * FROM doors')

        erb :index
    end


    get '/doors/:day' do
        @door = db.execute('SELECT * FROM doors WHERE day = ?', params[:day]).first
        puts @door
        db.execute('UPDATE doors SET opened = true WHERE day = ?', params[:day])
        puts @door
        erb :'door/show'
    end

end



require_relative 'db/seeder'
class Calendar < Sinatra::Base

    def db
        return @db if @db
        @db = SQLite3::Database.new('./db/calendar.sqlite')
        @db.results_as_hash = true
        return @db
    end

    get '/' do
        @doors = db.execute('SELECT * FROM doors')

        erb :'door/index'
    end

    get '/doors/denied' do
        erb :'door/denied'
    end

    get '/doors/:day' do |day|
        time = Time.now
        
        if ((day.to_i <= time.mday) && (time.month == 12))
            @door = db.execute('SELECT * FROM doors WHERE day = ?', params[:day]).first

            db.execute('UPDATE doors SET opened = true WHERE day = ?', params[:day])

            erb :'door/show'
        else
            redirect '/doors/denied'
        end
    end

    get '/reset' do
        Seeder.seed!
        redirect '/'
    end


end



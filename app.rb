require 'sinatra'
require 'json'
require 'data_mapper'
require 'find'
require 'pathname'

BASEPATH = File.dirname(File.expand_path(__FILE__))
MOVIESPATH= File.join(BASEPATH,'public','flv')

#datamapper setup
DataMapper::setup(:default, "sqlite3://#{BASEPATH}/movie.db")

class Movie
  include DataMapper::Resource
  property :id, Serial
  property :title, Text
  property :path, Text
  property :dir, Text
  property :created_at, DateTime
end

DataMapper.finalize
Movie.auto_upgrade!


MOVIES = {movies: [
    {
      id: 1,
      title: "prova 1",
      path: "/tmp/prova_1.avi"
    },
    {
      id: 2,
      title: "prova 2",
      path: "/tmp/prova_2.avi"
    },
    {
      id: 3,
      title: "Killer Instinct",
      path: "/tmp/killer_instinct.avi"
    }
  ]}
class EmberVideo < Sinatra::Base
  helpers do
    def get(id)
      MOVIES[:movies][id.to_i+1].to_json
    end

    def get_all()
      MOVIES.to_json
    end

    def add_movie(path)
      path = Pathname.new(path).relative_path_from(Pathname.new(MOVIESPATH)).to_s 
      m = Movie.first_or_create(
        path: path,
        title: File.basename(path,File.extname(File.basename(path))),
        :dir => File.dirname(path)
      )
      m.errors.each {|e| puts e}
    end
  end

  get '/' do
    erb :index
  end

  get '/movies' do
    content_type :json
    movies = {movies: Movie.all(:order => [:dir.asc, :path.asc ])}.to_json
    #get_all
  end

  get '/movies/:id' do
    content_type :json
    movie = Movie.get(params[:id]).to_json
    #get(params[:id])
  end

  get '/update' do
    Find.find(MOVIESPATH) do |path|
       path = path.force_encoding('ISO-8859-1')
       add_movie(path) if path =~ /\.flv$/
     end
    s = ''
    Movie.all.each do |m|
      file = File.join(MOVIESPATH,m.path)
      s += m.path + "\n"
      unless File.exist?(file)
        m.destroy
      end
    end
    @updated = true
    redirect '/'
  end
end



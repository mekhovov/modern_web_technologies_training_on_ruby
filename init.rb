
require 'rubygems'
require 'haml'
require 'sinatra'
require 'sequel'
require './db/db_init'

# require codel and controller
def include_model_controller name
  %w[models controllers].each{|dir| require File.join('./', dir, "#{name.to_s}");}
  
end
# include news
include_model_controller :news
# initialize
@@id = nil
@@show_news = nil
@@show_all_news = nil
set :haml, {:format => :html5, :attr_wrapper => '"'}

helpers do
  # call controller and show view
  def render_page options
    # initialize
    @@id = options[:id] if options.has_key? :id
    options[:action] = :index unless options.has_key? :action || !options[:action].nil?
    # call controller
    begin
      eval "#{options[:controller].capitalize}Controller.new.#{options[:action]}"
    rescue => e 
      p e.exception
      p ">>> no method: #{options[:action]}"
    end
    # show view
    begin
    	if (options.has_key? :layout)
      	haml "#{options[:controller]}/#{options[:action]}".to_sym, :layout => false
    	else
      	haml "#{options[:controller]}/#{options[:action]}".to_sym
    	end
    rescue => e 
      p e.exception
    	p ">>> no view: #{options[:controller]}/#{options[:action]}"
     haml :p404
    end
  end
end

# root
get '/' do
  render_page :controller => :home
end
# add news
post '/news/add' do
  NewsModel.new.add params
  redirect :news
end
# del news
get '/news/delete/:id' do
  NewsController.new.delete params[:id]
  redirect :news
end
# edit news
post '/news/edit/:id' do
  NewsModel.new.update params
  redirect :news
end
# ext js demo
get '/extjs_demo' do
  render_page :controller => :extjs_demo, :layout => false
end
# common routes
get '/*/*/*' do
    render_page :controller => params[:splat][0], :action => params[:splat][1], :id => params[:splat][2]
end
get '/*/*' do
    render_page :controller => params[:splat][0], :action => params[:splat][1]
end
get '/*' do
  render_page :controller => params[:splat][0]
end


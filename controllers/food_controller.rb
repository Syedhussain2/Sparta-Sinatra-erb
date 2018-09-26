class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
#Resetting the root as the parent directory of the current directory
  set :root, File.join(File.dirname(__FILE__),'..')
  #Sets the views directory correctly
  set :views, Proc.new{File.join(root, "views")}
  $food = [
    {
      :id => 1,
      :title => 'KFC Chicken',
      :flavour => 'BBQ',
      :meal => ['Chips', 'Drink','Corn']
    },
    {
      :id => 2,
      :title => 'KFC Box',
      :flavour => 'Hot',
      :meal => ['Chips', 'Drink', 'Burger']
    },
    {
      :id => 3,
      :title => 'Burger',
      :flavour => 'classic',
      :meal => ['chips', 'Drink',]
    }
  ]
  #INDEX
  get '/food' do
    @title = "KFC"
    @food = $food

    erb  :'food/index'
  end
  #NEW
  get '/food/new' do
    erb :"food/new"
  end
  #SHOW
  get '/food/:id' do
    id = params[:id].to_i
    @food = $food[id - 1]
    erb :'food/show'
  end
  #Create
  post '/food' do
    id = $food.length + 1
    if params[:meal].include? ','
      actors = params[:meal].split ','
    else
      actors = [params[:meal]]
    end
    newFood = {
      :id => id,
      :title =>params[:title],
      :flavour =>params[:flavour],
      :meal => meal
    }
    $food.push newFood
    redirect '/food'
  end
  #UPDATE
  put '/food/:id' do
    id = params[:id].to_i - 1
    @food = $food[id]

    food = $food[id]

    if params[:meal].include? ','
      meal = params[:meal].split ','
    else
      meal = [params[:meal]]
    end

    food[:title] = params[:title]
    food[:flavour] = params[:flavour]
    food[:meal] = meal

    $food[id] = food

    redirect '/food'
  end
  #Delete
  delete '/food/:id' do
    id = params[:id].to_i
    $food.delete_at id
    redirect '/food'
  end
  #EDIT
  get '/food/:id/edit' do
    id = params[:id].to_i - 1
    @food = $food[id]

    erb :'food/edit'
  end

end # class end

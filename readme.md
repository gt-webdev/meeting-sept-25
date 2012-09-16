# gt-webdev meeting #3: views and controllers!

Now that we have a simple Sinatra app serving out what we're having for dinner, lets introduce the views and controllers part of MVC.

## Getting up and running

If you want to follow allow with us during the meeting checkout last weeks repo, otherwise to get the finished product running this week follow these steps

    git clone git@github.com:gt-webdev/meeting-sept-25.git
    cd meeting-sept-25
    ruby dinner.rb

Then point your browser to ``http://localhost:4567/dinner``

If you want to work along from the September 18th meeting where we introduced dynamic apps then

    git clone git@github.com:gt-webdev/meeting-sept-18.git
    cd meeting-sept-18

and work with the ``dinner.rb`` file in there.

## Views

Views are a great way to seperate out HTML (presentation) from the actual code. The reason we want to do this is because as webapps continue to grow in complexity the HTML becomes very large and it becomes very hard maintain an app with inline HTML (in addition to it being very ugly). 

### ``get '/add_dinner'``

Starting from where we ended last week, we had a route called ``get '/add_dinner'`` that contained an HTML form inside of a heredoc:

    get '/add_dinner' do
      <<-FORM
    <form action="/add_dinner" method="post">
      dinner: <input type="text" name="dinner">
      <input type="submit">
    </form>

    #{$food}
      FORM
    end
    
We can all agree that this is really ugly. Ideally we do not want any HTML inside of here. Lets first start by making a new directory called ``views``. Inside of there create a file called ``new.erb``; this will be our view for ``/add_dinner``. ``erb`` is one of several templating engines available for Ruby and stands for Embedded Ruby (others include HAML and Slim which we will cover later). 

Lets take everything inside of the heredoc, stick it into ``views/new.erb`` and remove it from the route's action:

    <form action="/add_dinner" method="post">
      dinner: <input type="text" name="dinner">
      <input type="submit">
    </form>

    #{$food}
    
The route now looks like

    get '/add_dinner' do
    end
    
Much cleaner right? But wait! How do we tell it which view to use? Easy! It's just a matter of adding ``erb :new``

    get '/add_dinner' do
      erb :new
    end
    
If we ``ruby dinner.rb`` and go to ``http://localhost:4567/add_dinner`` it'll work but there's one change we want to make. ``$`` in Ruby defines a global which is not something you want to do (we're doing it here to make explaining concepts easier so it's only a little bad!). Let's change it by first removing the ``$`` from the view, making it ``<%= food %>``. This'll break everything temporarily but it's a quick fix!

    get '/add_dinner' do
      erb :new, locals: { food: $food }
    end
    
We're telling the template engine to create a local variable for us called ``food`` with the data from ``$food``.

And it's as easy as that!

### ``get '/dinner'``

We also made ``/dinner`` a view but since we covered the rest in detail I'll make this quick.

Create a file inside of the views folder called ``index.erb`` and inside of it lets have

    Tonight we are going to be eating <b><%= dinner %></b>

Let's change the action to

    get '/dinner' do
      erb :index, locals: { dinner: dinner }
    end
    
This'll render the ``index.erb`` view with a local called ``dinner`` with the data outputted from the dinner function.

### Rendering

We introduced some weird syntax inside of the view: ``<%= food %>``. This is where the Embedded Ruby part of ERB comes in. Everything inside of the ``<%= %>`` is considered to be Ruby and will be rendered into the view. We also have ``<% %>`` available which does not render anything in the view. It's use for flow control like loops and conditionals which we'll cover later.

## Controllers

Controllers manage the requests that come into the app so that when you go to the browser and tell it you want ``/dinner`` the app knows where to direct your request. In fact, ``dinner.rb`` is a controller! We have routes specifying what people can do and request and the app knows how to handle those, where to go, what to do, and what views to render.
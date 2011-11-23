class App.Todos extends Spine.Controller
  events:
    "submit form":  "create"
    "click .clear": "clear"
    
  elements:
    ".todos":     "todos"
    "form input": "input"

  constructor: ->
    super
    App.Todo.bind("create",  @addOne)
    App.Todo.bind("refresh", @addAll)
    App.Todo.fetch()

  addOne: (todo) =>
    view = new App.TodoItem(todo: todo)
    @todos.append(view.render().el)

  addAll: =>
    App.Todo.each(@addOne)
  
  create: (e) ->
    e.preventDefault()
    App.Todo.create(name: @input.val(), done: false)
    @input.val("")
    
  clear: ->
    App.Todo.destroyDone()
    
    
class App.TodoItem extends Spine.Controller
  events:
    "change input[type=checkbox]": "toggle"
    "click  .destroy":             "destroyTodo"
    
  constructor: ->
    super
    @todo.bind("update",  @render)
    @todo.bind("destroy", @remove)

  render: =>
    @html @view("todos/todo")(@todo)
    @

  remove: =>
    @el.remove()
    
  toggle: ->
    @todo.done = !@todo.done
    @todo.save()
  
  destroyTodo: ->
    @todo.destroy()
    
    


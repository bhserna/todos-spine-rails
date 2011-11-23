class App.Todo extends Spine.Model
  @configure 'Todo', 'name', 'done'
  @extend Spine.Model.Ajax
  
  @active: ->
    @select (todo) -> !todo.done

  @done: ->
    @select (todo) -> !!todo.done

  @destroyDone: ->
    rec.destroy() for rec in @done()

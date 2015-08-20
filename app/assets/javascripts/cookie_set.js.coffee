Larch.CookieSet = Ember.Set.extend
  init: ->
    @load()

  addOrRemove: (item) ->
    if @contains(item)
      @remove(item)
    else
      @add(item)
    @save()
    false

  load: ->
    @clear()
    data = $.cookie(@_name())
    if array = JSON.parse(data)
      @addEach(array)

  save: ->
    $.cookie(@_name(),JSON.stringify(@toArray()))
    # console.log "Saved #{@_name()}"

  _name: ->
    Ember.get(this,'cookieName')

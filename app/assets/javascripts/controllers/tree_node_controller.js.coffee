# TODO: replace by component
Larch.TreeNodeController = Ember.ObjectController.extend
  # FIXME: not working - must be shared!      
  closedItems: Larch.CookieSet.create(cookieName: 'tree-closed-items')
  
  isClosed: (->
    id = @get('model.id')
    @get('closedItems').contains(id)
  ).property('closedItems.[].id')

  actions:
    toggleClosed: ->
      id = @get('model.id')
      closed = @get('closedItems').addOrRemove(id)
      false

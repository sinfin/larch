# TODO: replace by component
Larch.TreeNodeController = Ember.ObjectController.extend
  needs: ['tree']
  closedItems: Ember.computed.alias('controllers.tree.closedItems')

  isClosed: (->
    id = @get('model.id')
    @get('closedItems').contains(id)
  ).property('closedItems.[].id')

  actions:
    toggleClosed: ->
      id = @get('model.id')
      closed = @get('closedItems').addOrRemove(id)
      false

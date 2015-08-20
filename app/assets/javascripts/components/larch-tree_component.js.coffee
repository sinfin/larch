Larch.TreeComponent = Ember.Component.extend
  layoutName: 'components/larch/tree'
  tagName: 'ul',
  classNameBindings: [':list-group'],
  closedItems: Larch.CookieSet.create(cookieName: 'tree-closed-items')

  nodes: null      
  nodesSorting: ['position']
  sortedNodes: Ember.computed.sort('nodes','nodesSorting')      

  roots: (->
     @get('sortedNodes').filterBy('ancestryDepth',0)
  ).property('sortedNodes.@each.depth')

  actions:
    moveUp: (item) ->
      @_move(item,up: true)
      false

    moveDown: (item) ->
      @_move(item)
      false

    remove: (item) ->
      item.deleteRecord()
      item.save()
      false

    create: (parent) ->
      @transitionTo 'menu_items_new',parent.get('id')
      false

    changeParent: (item_id,parent_id,position = null) ->
      data = { menu_item: { parent_id: parent_id }}
      @postToServer("/admin/menu_items/#{item_id}",data,type: 'PUT').then =>
        console.log "Item #{item_id} changed parent."
      false


  _move: (item,params = {}) ->
    id = item.get('id')
    @postToServer("/admin/menu_items/#{id}/move", params).then =>
      console.log "Item #{id} moved."
    false
  

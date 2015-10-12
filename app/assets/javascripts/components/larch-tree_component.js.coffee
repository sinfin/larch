Larch.TreeComponent = Ember.Component.extend
  layoutName: 'components/larch/tree'
  tagName: 'ul',
  classNameBindings: [':list-group'],
  closedItems: Larch.CookieSet.create(cookieName: 'tree-closed-items')

  nodes: null
  nodesSorting: ['position']
  sortedNodes: Ember.computed.sort('nodes','nodesSorting')

  init: ->
    @_super()
    @ensureProperty('nodes')
    @ensureProperty('store')
    @ensureProperty('removeNode')
    @ensureProperty('serverPath')

  ensureProperty: (name) ->
    throw "Missing property '#{name}' for Larch.TreeComponent" if Ember.isEmpty(@get(name))

  roots: (->
     @get('sortedNodes').filterBy('ancestryDepth',0)
  ).property('sortedNodes.@each.depth')

  actions:
    removeNode: (node) ->
      @sendAction 'removeNode', node
      false

    moveUp: (item) ->
      @_move(item,up: true)
      false

    moveDown: (item) ->
      @_move(item)
      false

    changeParent: (item_id,parent_id,position = null) ->
      data = { parent_id: parent_id }
      path = @get('serverPath')
      @postToServer("#{path}/#{item_id}",data,type: 'PUT').then =>
        console.log "Item #{item_id} changed parent."
      false


  _move: (item,params = {}) ->
    id = item.get('id')
    path = @get('serverPath')
    @postToServer("#{path}/#{id}/move", params).then =>
      console.log "Item #{id} moved."
    false


  # moved here from Barbecue so that there is no dependency
  postToServer: (url,data = {},options = {}) ->
    new Promise (resolve, reject) =>
      csrf_token = $('meta[name="csrf-token"]').attr('content')
      csrf_param = $('meta[name="csrf-param"]').attr('content')
      data.authenticity_token = csrf_token

      try
        $.ajax
          url: url
          type: options.type || 'POST'
          data: data
          success: (response) =>
            console.info 'Payload', response
            @store.pushPayload(options.serializer || 'page',response)
            resolve(response)

          error: (response) =>
            reject(response)
      catch e
        reject(e)

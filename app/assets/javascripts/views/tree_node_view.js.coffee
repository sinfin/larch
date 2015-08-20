Larch.TreeNodeView = Ember.View.extend
  templateName: 'tree/node'
  
  attributeBindings: ['draggable','style']
  classNameBindings: [ 'draggingOver:dragging-over','active']
  draggingOver: false

  draggable: Ember.computed.not('context.isNew')
  classNames:  ['tree-node','list-group-item']
  tagName: 'li'

  active: (->
    @get('childViews').anyBy('active')
  ).property('childViews.@each.active')

  style: (->
    d = @get('context.depth') || 0
    "padding-left: #{d * 15}px"
  ).property('context.depth')

  # click: ->
  #   item = @get('content')
  #   @get('controller').transitionToRoute('menu_item',item)
  #   false

  dragStart: (ev) ->
      ev.dataTransfer.setData('text/data', @get('context.id'))

  # enables dropping to be catched
  dragOver: (ev) ->
    ev.preventDefault()

  dragEnter: (ev) ->
    @set 'draggingOver', true

  dragLeave: (ev) ->
    @set 'draggingOver', false

  drop: (ev) ->
    @set 'draggingOver', false
    dropped_id = ev.dataTransfer.getData('text/data')
    parent_id = @get('context.id')
    @get('controller').send('changeParent', Number(dropped_id),Number(parent_id),null)

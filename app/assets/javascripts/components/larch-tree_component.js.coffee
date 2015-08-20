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

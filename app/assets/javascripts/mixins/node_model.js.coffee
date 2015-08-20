Larch.NodeModel = Ember.Mixin.create
  parent: DS.belongsTo('menu_item',inverse: 'children')
  children: DS.hasMany('menu_item',inverse: 'parent', async: true)
  position: DS.attr 'number'
  ancestry: DS.attr 'string'
  ancestryDepth: DS.attr 'number'

Larch.NodeMixinFor = (model_name) ->
  Ember.Mixin.create
    parent: DS.belongsTo(model_name, inverse: 'children')
    children: DS.hasMany(model_name, inverse: 'parent', async: true)
    position: DS.attr 'number'
    ancestry: DS.attr 'string'
    ancestryDepth: DS.attr 'number'

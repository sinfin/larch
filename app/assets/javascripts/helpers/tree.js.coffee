Ember.Handlebars.helper 'tree-node-indentation', (node) ->
  depth = node.get('ancestryDepth')
  str = ''

  for i in [1..depth]
    str += '&nbsp;'
    
  new Handlebars.SafeString(str)        

Ember.Handlebars.helper 'tree-node-title', (item,title) ->
  text = if title
           title
         else
           if item.get('isNew')
             'New Item'
           else
             '[untitled]'


  clazz = if item.get('isNew')
            'text-success'
          else if item.get('fixed')
            'text-muted'
          else
            ''

  html = "<span class='#{clazz}'>#{text}</span>"
  new Handlebars.SafeString(html)

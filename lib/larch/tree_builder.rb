class Larch::TreeBuilder
  def initialize(clazz)
    @clazz = clazz
  end

  def node(options,&subtree)
    old_parent = @parent
    @parent = @clazz.create!({ parent: old_parent }.merge(options))
    self.instance_eval(&subtree) if subtree
  ensure
    @parent = old_parent
  end

end

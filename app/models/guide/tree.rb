module Guide::Tree
  def self.draw(&block)
    root.instance_eval(&block)
    root
  end

  def self.root
    @@root ||= Guide::Document.new(:root, 'content')
  end
end

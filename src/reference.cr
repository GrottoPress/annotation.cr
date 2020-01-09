class Reference
  macro inherited
    {% unless @type.superclass.abstract? %}
      {% if @type.superclass.annotation(Final) %}
        {% raise "Cannot inherit final type `#{@type.superclass.name}`" %}
      {% end %}
    {% end %}

    macro method_added(method)
      \{% if @type.ancestors.any? &.methods.any? do |m|
        m.annotation(Final) &&
        m.name == method.name &&
        m.args.map{ |a| r.resolve if r = a.restriction } ==
          method.args.map{ |a| r.resolve if r = a.restriction } &&
        !m.stringify.starts_with?("abstract ")
      end %}
        \{% raise "Attempt to override final method `\
          #{m.name}(#{m.args.join(", ").id})\
          #{m.return_type ? " : #{m.return_type}".id : "".id}` with `\
          #{method.name}(#{method.args.join(", ").id})\
          #{method.return_type ? " : #{method.return_type}".id : "".id}`" %}
      \{% end %}
    end
  end
end

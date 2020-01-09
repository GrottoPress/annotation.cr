class Object
  macro inherited
    macro method_added(method)
      \{% if method.annotation(Override) %}
        \{% if !@type.ancestors.any? &.methods.any? do |m|
          m.name == method.name &&
          m.args.map{ |a| r.resolve if r = a.restriction } ==
            method.args.map{ |a| r.resolve if r = a.restriction }
        end %}
          \{% raise "Attempt to override non-existent method `\
            #{method.name}(#{method.args.join(", ").id})\
            #{method.return_type ? \
            " : #{method.return_type }".id : "".id}`" %}
        \{% end %}
      \{% end %}
    end
  end
end

class Object
  macro inherited
    macro method_added(method)
      \{% if method.annotation(Override) %}
        \{% if !@type.ancestors.any? &.methods.any? do |m|
          i = 0
          a1 = m.args.select &.default_value.is_a?(Nop)
          a2 = method.args.select &.default_value.is_a?(Nop)

          m.name == method.name && a1.size == a2.size && a1.all? do |a|
            r1 = a.restriction
            r2 = a2[i].restriction
            i = i + 1
            r1.is_a?(Nop) || r2.is_a?(Nop) || r1.resolve == r2.resolve
          end
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

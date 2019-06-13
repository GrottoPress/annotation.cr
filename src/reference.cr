class Reference
  macro inherited
    {% if !@type.superclass.abstract? %}
      {% if @type.superclass.annotation(Final) %}
        {% raise "Cannot inherit final type `#{@type.superclass.name}`" %}
      {% end %}
    {% end %}

    macro method_added(method)
      \{% if method.annotation(Override) %}
        \{% if !@type.ancestors.any? &.methods.includes?(method) %}
          \{% raise "Trying to override non-existent method '#{method.name}'" %}
        \{% end %}
      \{% end %}

      \{% if @type.superclass.methods.any? { |m|
        m == method && m.annotation(Final)
      } %}
        \{% raise "Cannot override final method '#{method.name}'" %}
      \{% end %}
    end
  end
end

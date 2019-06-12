# Crystal Annotations

Crystal supports user-defined annotations. This shard leverages this capability to add certain annotations.

Annotations supported include:

- `Final`: Marks a type or method as final. Final types cannot be inheritted, final methods cannot be overridden.
- `Override`: Marks a method as overriding an existing method in it's super class. This means a mistyped method name in the subclass gives a compile-time error, instead of being silently added as a new method.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  annotation:
    github: grottopress/crystal-annotation
```

## Usage

```crystal
require "annotation"

# 'Final' class

@[Final]
class Parent
end

class Child < Parent # Oops! Cannot inherit final type 'Parent'
end

# 'Final' method

class Parent
  @[Final]
  def final_method
  end
end

class Child < Parent
  def final_method # Oops! Cannot override final method 'final_method'
  end
end

# 'Override'

class Parent
  def my_method
  end
end

class Child < Parent
  @[Override]
  def non_existent # Oops! Trying to override non-existent method 'non_existent'
  end

  @[Override]
  def my_method # Good to go!
  end
end
```

## Security

Kindly report suspected security vulnerabilities in private, via contact details outlined in this repository's `.security.txt` file.

## Contributing

1. Fork it (<https://github.com/grottopress/crystal-annotation/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [@GrottoPress](https://github.com/grottopress) (creator, maintainer)
- [@akadusei](https://github.com/akadusei)

# Crystal Annotations

Crystal supports user-defined annotations. This shard leverages this capability to add certain annotations.

Annotations supported include:

### `@[Final]`

Marks a type or method as final. Final types cannot be inheritted, final methods cannot be overridden.

The inheriting method should have the same type restrictions as the inherited method, in order for this annotation to prevent the override.

This means the parameter types and order should be the same for the inheriting method as for the inherited method.

A difference in type restrictions of the parameters is considered an overload, not an override.

### `@[Override]`

Marks a method as overriding an existing method in it's super class. This means a mistyped method name in the subclass gives a compile-time error, instead of being silently added as a new method.

The inheriting method should have the same name and type restrictions as the inherited method, in order for this annotation to ensure an override.

This means the parameter names, types and order should be the same for the inheriting method as it is for the inherited method.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  annotation:
    github: GrottoPress/annotation.cr
```

## Usage

```crystal
require "annotation"

##
# 'Final' class
##

@[Final]
class Parent
end

# Error!: Cannot inherit final type
class Child < Parent
end

##
# 'Final' method
##

class Parent
  @[Final]
  def final_method(a : String) : Nil
  end
end

class Child < Parent
  # OK: This is an overload
  def final_method(c : UInt8) : Bool
  end

  # OK: This is an overload
  def final_method(a : String, b : String) : Nil
  end

  # Error!: Cannot override final method
  def final_method(a : String) : Nil
  end

  # Error!: Cannot override final method
  def final_method(b : String) : Bool
    true
  end

  # Error!: Cannot override final method
  def final_method(c) : Bool
    true
  end
end

##
# 'Override'
##

class Parent
  def my_method(a : String) : Nil
  end
end

class Child < Parent
  # OK
  @[Override]
  def my_method(a : String) : Nil
  end

  # OK
  @[Override]
  def my_method(b)
  end

  # OK
  @[Override]
  def my_method(a : String) : Bool
    false
  end

  # OK
  @[Override]
  def my_method(b : String) : Bool
    false
  end

  # Error!: Method must exist
  @[Override]
  def non_existent
  end

  # Error!: This an overload
  @[Override]
  def my_method(a, b)
  end

  # Error!: This an overload
  @[Override]
  def my_method(a : Int32) : Nil
  end
end
```

## Contributing

1. [Fork it](https://github.com/GrottoPress/annotation.cr/fork)
1. Switch to the `master` branch: `git checkout master`
1. Create your feature branch: `git checkout -b my-new-feature`
1. Make your changes, updating changelog and documentation as appropriate.
1. Commit your changes: `git commit`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a new *Pull Request* against the `GrottoPress:master` branch.

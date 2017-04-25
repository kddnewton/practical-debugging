# Debugging

Identify the type of problem you're facing by determining which question you're asking. Follow the techniques below.

## Interface problems

Interface problems occur when you don’t understand the dependent structure of methods or constants.

*Questions like:*

- Why is this thing nil?
- Why can’t I call the method I want?
- What are the constants I can reference?
- What can this object see and do?
- What is this gem doing?

*Questions to ask yourself:*

- Did I handle every type of object that can be returned from this method (including `nil`)?
- What is the value of `self` in this block?
- Did I account for lexical scope?

*Tools and methods to use:*

- Listing methods:
  - [Object#methods](http://ruby-doc.org/core-2.4.1/Object.html#method-i-methods)
  - [Module#instance_methods](http://ruby-doc.org/core-2.4.1/Module.html#method-i-instance_methods)
  - [Module#private_instance_methods](http://ruby-doc.org/core-2.4.1/Module.html#method-i-private_instance_methods)
- Inspecting methods:
  - [Object#method](http://ruby-doc.org/core-2.4.1/Object.html#method-i-method)
  - [Module#instance_method](http://ruby-doc.org/core-2.4.1/Module.html#method-i-instance_method)
  - [Method#source_location](http://ruby-doc.org/core-2.4.1/Method.html#method-i-source_location)
  - [Method#parameters](http://ruby-doc.org/core-2.4.1/Method.html#method-i-parameters)
- Constants:
  - [Module::nesting](http://ruby-doc.org/core-2.4.1/Module.html#method-c-nesting)
  - [Module#constants](http://ruby-doc.org/core-2.4.1/Module.html#method-i-constants)
  - [Module#const_get](http://ruby-doc.org/core-2.4.1/Module.html#method-i-const_get)

*Command line utilities to use:*

- [`bundle open`](http://bundler.io/v1.1/bundle_open.html) (opens the source of gems in your editor)
- [`gem pristine`](http://guides.rubygems.org/command-reference/#gem-pristine) (restores gems to their original state)

## State problems

State problems occur when the assumptions you made about the current state of the program are incorrect.

*Questions like:*

- How does this value change at this point?
- What has been initialized at this point?
- How many objects are allocated in this method?

*Questions to ask yourself:*

- What am I assuming about the current state of the program at this point in code?

*Tools and methods to use:*

- Variables:
  - [Kernel#local_variables](http://ruby-doc.org/core-2.4.1/Kernel.html#method-i-local_variables)
  - [Object#instance_variables](http://ruby-doc.org/core-2.4.1/Object.html#method-i-instance_variables)
  - [Object#instance_variable_get](http://ruby-doc.org/core-2.4.1/Object.html#method-i-instance_variable_get)
  - [Object#instance_variable_set](http://ruby-doc.org/core-2.4.1/Object.html#method-i-instance_variable_set)
  - [Kernel#global_variables](http://ruby-doc.org/core-2.4.1/Kernel.html#method-i-global_variables)
- State:
  - [Kernel#puts](http://ruby-doc.org/core-2.4.1/Kernel.html#method-i-puts)
  - [Object#inspect](http://ruby-doc.org/core-2.4.1/Object.html#method-i-inspect)
  - [Kernel#p](http://ruby-doc.org/core-2.4.1/Kernel.html#method-i-p)
  - [Binding#irb](http://ruby-doc.org/core-2.4.1/Binding.html#method-i-irb)
  - [GC::stat](https://ruby-doc.org/core-2.4.1/GC.html#method-c-stat)

## Flow problems

Flow problems occur when you don’t know how the ruby interpreter got to or left a location in code and its associated state.

*Questions like:*

- How did the interpreter get here?
- Where does the interpreter go from here?
- How did this object get here?
- Where is this object being mutated?
- When does this instance variable get set?

*Questions to ask yourself:*

- What am I assuming has happened or is going to happen next?

*Tools and methods to use:*

- Interpreter location:
  - [Kernel#caller](http://ruby-doc.org/core-2.4.1/Kernel.html#method-i-caller)
  - [TracePoint](http://ruby-doc.org/core-2.4.1/TracePoint.html)
  - [Kernel#set_trace_func](http://ruby-doc.org/core-2.4.1/Kernel.html#method-i-set_trace_func)
  - [Binding#eval](http://ruby-doc.org/core-2.4.1/Binding.html#method-i-eval)
- Object lifecycle:
  - [ObjectSpace](http://ruby-doc.org/core-2.4.1/ObjectSpace.html)
  - [Object#freeze](http://ruby-doc.org/core-2.4.1/Object.html#method-i-freeze)

## References

- [A Comprehensive Guide to Debugging Rails](https://www.jackkinsella.ie/articles/a-comprehensive-guide-to-debugging-rails)
- [Debugging memory leaks in Ruby](https://samsaffron.com/archive/2015/03/31/debugging-memory-leaks-in-ruby)
- [Debugging Rails Applications](http://guides.rubyonrails.org/debugging_rails_applications.html)
- [Debugging Rails Applications in Development](http://nofail.de/2013/10/debugging-rails-applications-in-development/)
- [I am a puts debuggerer](https://tenderlovemaking.com/2016/02/05/i-am-a-puts-debuggerer.html)
- [Ruby Debugging Magic Cheat Sheet](http://www.schneems.com/2016/01/25/ruby-debugging-magic-cheat-sheet.html)
- [There’s More to Ruby Debugging Than puts()](https://engineering.shopify.com/17489080-theres-more-to-ruby-debugging-than-puts)

## Code examples

For `minesweeper`, run `bundle install` in the root of the repository to fetch the dependencies. Then run `bin/minesweeper` to run the program. The number of rows, columns, and mines can be specified as command line arguments in that order.

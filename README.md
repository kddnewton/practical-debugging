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
  - Object#methods
  - Object#instance_methods
  - Object#private_instance_methods
- Inspecting methods:
  - Object#method
  - Object#instance_method
  - Method#source_location
  - Method#parameters
- Constants:
  - Module::nesting
  - Module#constants
  - Module#get_const

*Command line utilities to use:*

- `bundle open` (opens the source of gems in your editor)
- `gem pristine` (restores gems to their original state)

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
  - Kernel#local_variables
  - Kernel#instance_variables
  - Kernel#instance_variable_get
  - Kernel#instance_variable_set
  - Kernel#global_variables
- State:
  - Kernel#puts
  - Object#inspect
  - Binding#irb

## Flow problems

Flow problems occur when you don’t know how the ruby interpreter go to or left a location in code and its associated state.

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
  - Kernel#caller
  - TracePoint module
  - Binding#eval
- Object lifecycle:
  - ObjectSpace module
  - Object#freeze
  - Object#unfreeze

## Code examples

For `minesweeper`, run `bundle install` in the root of the repository to fetch the dependencies. Then run `bin/minesweeper` to run the program. The number of rows, columns, and mines can be specified as command line arguments in that order.

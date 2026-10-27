/-- A counter that can't go below zero. -/
structure Counter where
  value : Nat := 0

namespace Counter

def increment (c : Counter) : Counter := { value := c.value + 1 }

def decrement (c : Counter) : Counter := { value := c.value - 1 }

def reset (_ : Counter) : Counter := {}

end Counter

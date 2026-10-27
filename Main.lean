import Js
import App.Counter
import App.Message

open Js.Dom
open Std.Async

/-- Returns the element with the ID `id`, throwing an error if there is no such element. -/
def getElement (doc : Document) (id : String) : IO HtmlElement := do
  let some e ← doc.getElementById id | throw (.userError s!"no element with ID {id}")
  e.cast HtmlElement

def main : IO Unit := do
  let doc ← document

  -- A counter, whose state is a `Counter` in a mutable reference.
  let count ← getElement doc "count"
  let counter ← IO.mkRef ({} : Counter)
  let update (f : Counter → Counter) : IO Unit := do
    counter.modify f
    count.setTextContent (toString (← counter.get).value)
  for (id, f) in [("increment", Counter.increment), ("decrement", .decrement), ("reset", .reset)]
  do
    (← getElement doc id).addEventListener "click" fun (_ : Event) => update f
  update id

  -- A message, fetched when the button is clicked.
  let message ← getElement doc "message"
  (← getElement doc "load-message").addEventListener "click" fun (_ : Event) => do
    message.setTextContent "Loading…"
    -- The listener returns at once, and the fetch finishes later.
    discard <| EAsync.toBaseIO do
      try
        let m ← fetchMessage "/message.json"
        message.setTextContent s!"“{m.text}” — {m.author}"
      catch e =>
        message.setTextContent s!"Error: {e}"

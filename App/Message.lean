import Js

open Js.Fetch
open Std.Async

/-- A message, as `public/message.json` stores it. -/
structure Message where
  text : String
  author : String
  deriving FromJs

/-- Fetches the message from `url`. -/
def fetchMessage (url : String) : Async Message := do
  let res ← fetch url
  unless res.ok do
    throw <| .userError s!"failed to fetch {url}: {res.status}"
  fromJs (← res.json)

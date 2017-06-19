port module Ports exposing (..)


port getWindowSize : (( Float, Float ) -> msg) -> Sub msg


port setWindowSize : ( Float, Float ) -> Cmd msg

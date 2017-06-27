module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Games
import Ports exposing (..)


type alias Model =
    { count : Int
    , games : Games.Model
    }


init : ( Model, Cmd Msg )
init =
    ( { count = 0
      , games = []
      }
    , fetchGames
    )


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type Msg
    = Increment
    | Decrement
    | GamesMsg Games.Msg
    | GetWindowSize ( Float, Float )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        GamesMsg msg ->
            let
                ( games, msg_ ) =
                    Games.update msg model.games
            in
                ( { model | games = games }, Cmd.map GamesMsg msg_ )

        GetWindowSize ( w, h ) ->
            ( model, setWindowSize ( w, h ) )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model.count) ]
        , button [ onClick Increment ] [ text "+" ]
        , Html.map GamesMsg <| Games.view model.games
        ]


fetchGames : Cmd Msg
fetchGames =
    Cmd.map GamesMsg Games.fetchGames


subscriptions : Model -> Sub Msg
subscriptions model =
    getWindowSize GetWindowSize

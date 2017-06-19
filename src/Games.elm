module Games exposing (..)

import Html exposing (Html, div, text)
import Json.Encode exposing (encode, object)
import Json.Decode exposing (decodeString, Decoder, string, int, list, nullable)
import Json.Decode.Pipeline exposing (decode, required, optional)
import RemoteData exposing (..)
import Http


type alias Game =
    { id : String
    , date : String
    , homeScore : Maybe Int
    , awayScore : Maybe Int
    }


type Msg
    = LoadGames (WebData (List Game))


type alias Model =
    List Game


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadGames games ->
            case games of
                Success games_ ->
                    ( games_, Cmd.none )

                _ ->
                    ( model, Cmd.none )


gameDecoder : Decoder Game
gameDecoder =
    decode Game
        |> required "id" string
        |> required "date" string
        |> optional "homeScore" (nullable int) Nothing
        |> optional "awayScore" (nullable int) Nothing


gameEncode : Game -> String
gameEncode game =
    let
        json =
            object
                [ ( "id", Json.Encode.string game.id )
                , ( "time", Json.Encode.string game.date )
                ]
    in
        encode 0 json


fetchGames : Cmd Msg
fetchGames =
    Http.get "http://localhost:3030/games.json" (list gameDecoder)
        |> RemoteData.sendRequest
        |> Cmd.map LoadGames


view : Model -> Html Msg
view model =
    div []
        (model |> List.map (\g -> div [] [ text g.id ]))

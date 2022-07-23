module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, img, input, text, ul)
import Html.Attributes exposing (placeholder, src, value)
import Html.Events exposing (onClick, onInput)



---- MODEL ----


type alias Model =
    { toDoText : String
    , toDoList : List String
    }


init : ( Model, Cmd Msg )
init =
    let
        initModel =
            { toDoText = ""
            , toDoList = [ "first" ]
            }
    in
    ( initModel, Cmd.none )



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }



---- UPDATE ----


type Msg
    = SaveItem String
    | CurrentItem String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveItem toAdd ->
            ( { model | toDoList = toAdd :: model.toDoList }, Cmd.none )

        CurrentItem item ->
            ( { model | toDoText = item }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "To do list" ]
        , input [ placeholder "Type your To do here..", value model.toDoText, onInput CurrentItem ] []
        , button [ onClick (SaveItem model.toDoText) ] [ text "Add" ]
        , viewItems model.toDoList
        ]


viewItems : List String -> Html Msg
viewItems items =
    div []
        [ text "Items"
        , ul [] (List.map viewItem items)
        ]


viewItem : String -> Html Msg
viewItem item =
    div [] [ text item ]

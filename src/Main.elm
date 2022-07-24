module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, h2, img, input, text, ul)
import Html.Attributes exposing (disabled, placeholder, src, value)
import Html.Events exposing (onClick, onInput)


type alias ToDo =
    { text : String }



---- MODEL ----


type alias Model =
    { toDo : ToDo
    , toDoList : List String
    }


init : ( Model, Cmd Msg )
init =
    let
        toDo =
            { text = "" }

        initModel =
            { toDo = toDo
            , toDoList = [ "" ]
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
            let
                toDo =
                    model.toDo

                updatedModel =
                    { model
                        | toDoList = toAdd :: model.toDoList
                        , toDo = { toDo | text = "" }
                    }
            in
            ( updatedModel, Cmd.none )

        CurrentItem item ->
            let
                toDo =
                    model.toDo
            in
            ( { model | toDo = { toDo | text = item } }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "To do list" ]
        , input [ placeholder "Type your To do here..", value model.toDo.text, onInput CurrentItem ] []
        , button [ disabled (canSubmit model.toDo.text), onClick (SaveItem model.toDo.text) ] [ text "Add" ]
        , h2 [] [ text "Items" ]
        , viewItems model.toDoList
        ]


canSubmit : String -> Bool
canSubmit todo =
    String.isEmpty todo


viewItems : List String -> Html Msg
viewItems items =
    div [] [ ul [] (List.map viewItem items) ]


viewItem : String -> Html Msg
viewItem item =
    div [] [ text item ]

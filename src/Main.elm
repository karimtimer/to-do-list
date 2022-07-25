module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, h2, img, input, text, ul)
import Html.Attributes exposing (disabled, placeholder, src, value)
import Html.Events exposing (onClick, onInput)


type alias ToDo =
    { text : String }



---- MODEL ----


type alias Model =
    { toDo : Maybe ToDo
    , toDoList : List String
    }


init : ( Model, Cmd Msg )
init =
    let
        initModel =
            { toDo = Nothing
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
                        , toDo = Nothing
                    }
            in
            ( updatedModel, Cmd.none )

        CurrentItem item ->
            let
                toDo =
                    model.toDo
            in
            case toDo of
                Just t ->
                    ( { model | toDo = Just { t | text = item } }, Cmd.none )

                Nothing ->
                    ( { model | toDo = Nothing }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "To do list" ]
        , viewTodoToAdd model.toDo
        , button [ disabled (isEmpty model.toDo), onClick (SaveItem model.toDo.text) ] [ text "Add" ]
        , h2 [] [ text "Items" ]
        , viewItems model.toDoList
        ]


viewTodoToAdd : Maybe ToDo -> Html Msg
viewTodoToAdd toDo =
    case toDo of
        Just t ->
            input [ placeholder "Type your To do here..", value t.text, onInput CurrentItem ] []

        Nothing ->
            input [ placeholder "Type your To do here..", value "", onInput CurrentItem ] []


isEmpty : Maybe ToDo -> Bool
isEmpty toDo =
    case toDo of
        Just t ->
            String.isEmpty t.text

        Nothing ->
            True


viewItems : List String -> Html Msg
viewItems items =
    div [] [ ul [] (List.map viewItem items) ]


viewItem : String -> Html Msg
viewItem item =
    div [] [ text item ]

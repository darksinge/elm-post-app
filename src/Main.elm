module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Events exposing (..)
import Url




-- MAIN


main =
  Browser.application
  { init = init
  , onUrlChange = UrlChanged
  , onUrlRequest = LinkClicked
  , subscriptions = subscriptions
  , update = update
  , view = view
  }




-- MODEL




type alias Model =
  { key : Nav.Key
  , url : Url.Url
  , value : Int
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  ( Model key url 0, Cmd.none )




-- SUBSCRIPTIONS



subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none




-- UPDATE



type Msg
  = Inc
  | Dec
  | UrlChanged Url.Url
  | LinkClicked Browser.UrlRequest




update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Inc ->
      ( { model | value = model.value + 1 }, Cmd.none )
    Dec ->
      ( { model | value = model.value - 1 }, Cmd.none )
    UrlChanged url ->
      ( model, Cmd.none )
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )
        
        Browser.External href ->
          ( model, Nav.load href )




-- VIEW



view : Model -> Browser.Document Msg
view model =
  { title = "Counter"
  , body = 
    [ div [] [ viewCounter model.value ] ]
  }
  


viewCounter : Int -> Html Msg
viewCounter value =
  div [] 
  [ button [ onClick Dec ] [ text "-" ]
  , div [] [ text (String.fromInt value) ]
  , button [ onClick Inc ] [ text "+" ]
  ]

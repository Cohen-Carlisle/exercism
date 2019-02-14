module TwoFer exposing (twoFer)

twoFer : Maybe String -> String
twoFer maybeName =
  let
    name = maybeName |> Maybe.withDefault "you"
  in
  "One for " ++ name ++ ", one for me."

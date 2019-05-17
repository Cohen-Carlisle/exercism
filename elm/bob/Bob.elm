module Bob exposing (hey)
import Regex

hey : String -> String
hey remark =
    if yelling remark && questioning remark then
        "Calm down, I know what I'm doing!"

    else if yelling remark then
        "Whoa, chill out!"

    else if questioning remark then
        "Sure."

    else if silent remark then
        "Fine. Be that way!"

    else
        "Whatever."


yelling : String -> Bool
yelling remark =
    let
        hasUpperCaseRegex =
            Regex.fromString "[A-Z]" |> Maybe.withDefault Regex.never

        hasUpperCase =
            Regex.contains hasUpperCaseRegex remark

        noLowerCase =
            (remark |> String.toUpper) == remark
    in
    hasUpperCase && noLowerCase


questioning : String -> Bool
questioning remark =
    remark |> String.endsWith "?"


silent : String -> Bool
silent remark =
    String.trim remark == ""

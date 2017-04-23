{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Clay
import qualified Clay.Media        as Media
import           Data.Monoid
import qualified Data.Text.Lazy.IO as Text
import           Prelude           hiding (div, rem, span, (**))

stylesheet :: Css
stylesheet = do
    star ? do
        boxSizing borderBox
        ":before" & boxSizing borderBox
        ":after" & boxSizing borderBox
    baseLine (px 16) (rem 1.6)
    body ? do
        fontFamily ["Helvetica Nueue", "Helvetica", "Arial"] [sansSerif]
        background white
        color "#444444"
        position relative
        minHeight (pct 100)
        noPadding
        paddingBottom (rem 2)
        noMargin
        h1 ? headingFont
        h2 ? headingFont
        h3 ? headingFont
        h4 ? headingFont
        h5 ? headingFont
        h6 ? headingFont
        a ? do
            color "#444444"
            position relative
            textDecorationLine none
            ":hover" & do
                color "#000"
                before & do
                    visibility visible
                    transform (scaleX 1)
            before & do
                content $ stringContent ""
                position absolute
                width (pct 100)
                height (px 1)
                bottom (px 0)
                left (px 0)
                backgroundColor "#000"
                visibility hidden
                transform (scaleX 0)
                transition "all" (sec 0.2) easeInOut (sec 0)
    div # "#footer" ? do
        width (pct 100)
        position absolute
        bottom (px 0)
        fontSize (rem 0.8)
        paddingLeft (px 10)
        paddingRight (px 10)
        color "#ccc"
        a ? color "#ccc"
    section # "#container" ?
        container (px 900)
    div # "#navigation" ? do
        div # ".navigation-fixed-content" ? do
            position fixed
            query Clay.all [Media.maxWidth collapseWidth] $ position relative
        width (px 130)
        paddingTop (rem 2)
        ul ? do
            listStyleType none
            noPadding
    div # "#content" ? do
        paddingTop (rem 2)
        ul # ".post-list" ? do
            listStyleType none
            noPadding
            span # ".date" ? do
                fontSize (rem 0.9)
                color "#666"

        paddingLeft (px 100)
        query Clay.all [Media.maxWidth collapseWidth] noPadding

collapseWidth :: Size LengthUnit
collapseWidth = px 640

headingFont :: Css
headingFont = do
    fontFamily ["Georgia"] [serif]
    fontWeight normal

centered :: Css
centered = sym2 margin  (px 0) auto

clearfix :: Css
clearfix = pseudo ":after" & do
            content (stringContent "")
            display displayTable
            clear both

container :: Size LengthUnit -> Css
container w = do
        centered
        clearfix
        query  Clay.all [Media.minWidth w] (width w)
        query Clay.all [Media.maxWidth w] (width $ pct 100)

baseLine :: Size a -> Size a -> Css
baseLine fs lh = html ? do
        height (pct 100)
        boxSizing borderBox
        fontSize fs
        lineHeight lh

main :: IO ()
main = Text.putStr $ renderWith compact [] stylesheet

noPadding :: Css
noPadding = padding (px 0) (px 0) (px 0) (px 0)

noMargin :: Css
noMargin = margin (px 0) (px 0) (px 0) (px 0)

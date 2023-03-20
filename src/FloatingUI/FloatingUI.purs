module FloatingUI.FloartingUI
  ( ArrowOptions
  , ArrowPosition
  , AutoUpdateOptions
  , Middleware
  , Options
  , Position
  , arrow
  , autoUpdate
  , computePosition
  , offset
  , shift
  )
  where

import Prelude

import Data.Nullable (Nullable)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFn3, runEffectFn3)
import Effect.Uncurried (EffectFn4, runEffectFn4)
import Prim.Row (class Union)
import Promise (Promise)
import Promise.Aff as Promise
import Web.DOM (Element)

type Position = { x :: Int, y :: Int, arrow :: Nullable ArrowPosition }

type ArrowPosition = { x :: Nullable Int, y :: Nullable Int }

foreign import data Middleware :: Type

foreign import offset :: Int -> Middleware

type ShiftOptions = ( padding :: Int )
foreign import shiftImpl :: forall options. options -> Middleware

shift :: forall head tail. Union head tail ShiftOptions => { | head } -> Middleware
shift = shiftImpl

type ArrowOptions = ( element :: Element, padding :: Int )
foreign import arrowImpl :: forall options. options -> Middleware

arrow :: forall head tail. Union head tail ArrowOptions => { | head } -> Middleware
arrow = arrowImpl


type Options = (middleware :: Array Middleware, placement :: String)

type AutoUpdateOptions = {}

foreign import computePositionImpl :: forall options. EffectFn3 Element Element options (Promise Position)

computePosition ∷ forall head tail. Union head tail Options => Element → Element → { | head } → Aff Position
computePosition referenceEl floatingEl options = runEffectFn3 computePositionImpl referenceEl floatingEl options #
  Promise.toAffE

foreign import autoUpdateImpl :: EffectFn4 Element Element (Effect Unit) AutoUpdateOptions (Effect Unit)

autoUpdate :: Element → Element → Effect Unit -> AutoUpdateOptions → Effect (Effect Unit)
autoUpdate referenceEl floatingEl update options = runEffectFn4 autoUpdateImpl referenceEl floatingEl update options

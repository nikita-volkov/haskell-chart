-----------------------------------------------------------------------------
-- |
-- Module      :  Graphics.Rendering.Chart.Plot.Hidden
-- Copyright   :  (c) Tim Docker 2006
-- License     :  BSD-style (see chart/COPYRIGHT)
--
-- Plots that don't show, but occupy space so as to effect axis
-- scaling
--
-- Note that template haskell is used to derive accessor functions
-- (see 'Data.Accessor') for each field of the following data types:
--
--     * 'PlotHidden'
--
-- These accessors are not shown in this API documentation.  They have
-- the same name as the field, but with the trailing underscore
-- dropped. Hence for data field f_::F in type D, they have type
--
-- @
--   f :: Data.Accessor.Accessor D F
-- @
--

{-# OPTIONS_GHC -XTemplateHaskell #-}

module Graphics.Rendering.Chart.Plot.Hidden(
    PlotHidden(..),
) where

import Data.Accessor.Template
import qualified Graphics.Rendering.Cairo as C
import Graphics.Rendering.Chart.Types
import Graphics.Rendering.Chart.Renderable
import Graphics.Rendering.Chart.Plot.Types

-- | Value defining some hidden x and y values. The values don't
--   get displayed, but still affect axis scaling.
data PlotHidden x y = PlotHidden {
    plot_hidden_x_values_ :: [x],
    plot_hidden_y_values_ :: [y]
}

instance ToPlot PlotHidden where
    toPlot ph = Plot {
        plot_render_     = \_ -> return (),
        plot_legend_     = [],
        plot_all_points_ = (plot_hidden_x_values_ ph, plot_hidden_y_values_ ph)
    }

----------------------------------------------------------------------
-- Template haskell to derive an instance of Data.Accessor.Accessor
-- for each field.

$( deriveAccessors ''PlotHidden )


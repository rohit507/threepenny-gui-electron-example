module Example where

import Intro hiding (on)
import qualified Graphics.UI.Threepenny      as UI
import           Graphics.UI.Threepenny.Core
import Data.IORef

start :: Int -> IO ()
start port = startGUI defaultConfig { jsPort = Just port } setup

setup :: Window -> UI ()
setup window = do
  button <- UI.button # set UI.text "Click me!"
  _ <- getBody window #+ [element button]
  count :: IORef Int <- liftIO $ newIORef 0

  on UI.click button $ const $ do
    liftIO $ modifyIORef count (+ 1)
    n <- liftIO $ readIORef count
    element button # set UI.text ("I have been clicked " <> show n <> " times!")

--   Copyright 2013 Mario Pastorelli (pastorelli.mario@gmail.com) Samuel Gélineau (gelisam@gmail.com)
--
--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.

{-# LANGUAGE NoImplicitPrelude #-}
module System.Console.Hawk.IO 
  (getInput
  ,printOutput)
where

import Control.Exception
  (handle)
import Data.ByteString.Lazy.Char8
import Data.Maybe
  (Maybe
  ,maybe)
import GHC.IO.Exception
  (IOErrorType(ResourceVanished)
  ,IOException(ioe_type))
import System.IO
  (IO
  ,hFlush
  ,hPrint
  ,stderr
  ,stdout)
import Prelude hiding (getContents,putStrLn,readFile)

getInput :: Maybe FilePath
         -> IO ByteString
getInput = maybe getContents readFile

printOutput :: ByteString
            -> IO ()
printOutput s = handle ioHandler (putStrLn s >> hFlush stdout)
  where ioHandler e = case ioe_type e of
                        ResourceVanished -> return ()
                        _ -> hPrint stderr e

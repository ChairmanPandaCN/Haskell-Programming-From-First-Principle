{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_wordnumber (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/wordnumber/.stack-work/install/x86_64-linux-tinfo6/ee7761630ce40de9f3b50b4279e61ea217302be96b42f8b93de96045d63a5a1a/8.8.3/bin"
libdir     = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/wordnumber/.stack-work/install/x86_64-linux-tinfo6/ee7761630ce40de9f3b50b4279e61ea217302be96b42f8b93de96045d63a5a1a/8.8.3/lib/x86_64-linux-ghc-8.8.3/wordnumber-0.1.0.0-FUvwIPZ7cHI7D0KU8piWVo"
dynlibdir  = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/wordnumber/.stack-work/install/x86_64-linux-tinfo6/ee7761630ce40de9f3b50b4279e61ea217302be96b42f8b93de96045d63a5a1a/8.8.3/lib/x86_64-linux-ghc-8.8.3"
datadir    = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/wordnumber/.stack-work/install/x86_64-linux-tinfo6/ee7761630ce40de9f3b50b4279e61ea217302be96b42f8b93de96045d63a5a1a/8.8.3/share/x86_64-linux-ghc-8.8.3/wordnumber-0.1.0.0"
libexecdir = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/wordnumber/.stack-work/install/x86_64-linux-tinfo6/ee7761630ce40de9f3b50b4279e61ea217302be96b42f8b93de96045d63a5a1a/8.8.3/libexec/x86_64-linux-ghc-8.8.3/wordnumber-0.1.0.0"
sysconfdir = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/wordnumber/.stack-work/install/x86_64-linux-tinfo6/ee7761630ce40de9f3b50b4279e61ea217302be96b42f8b93de96045d63a5a1a/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "wordnumber_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "wordnumber_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "wordnumber_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "wordnumber_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "wordnumber_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "wordnumber_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)

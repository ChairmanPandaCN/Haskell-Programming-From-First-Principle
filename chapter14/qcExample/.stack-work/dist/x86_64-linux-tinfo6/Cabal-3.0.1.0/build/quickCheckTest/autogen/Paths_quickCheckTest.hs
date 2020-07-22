{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_quickCheckTest (
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

bindir     = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/qcExample/.stack-work/install/x86_64-linux-tinfo6/62d3b9c13e664827bc5c024cbfdcbadb6cb2f4b25639a3412f822a1dc179279f/8.8.3/bin"
libdir     = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/qcExample/.stack-work/install/x86_64-linux-tinfo6/62d3b9c13e664827bc5c024cbfdcbadb6cb2f4b25639a3412f822a1dc179279f/8.8.3/lib/x86_64-linux-ghc-8.8.3/quickCheckTest-0.1.0.0-KxEoN11UmPCAv6osMhBGD7-quickCheckTest"
dynlibdir  = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/qcExample/.stack-work/install/x86_64-linux-tinfo6/62d3b9c13e664827bc5c024cbfdcbadb6cb2f4b25639a3412f822a1dc179279f/8.8.3/lib/x86_64-linux-ghc-8.8.3"
datadir    = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/qcExample/.stack-work/install/x86_64-linux-tinfo6/62d3b9c13e664827bc5c024cbfdcbadb6cb2f4b25639a3412f822a1dc179279f/8.8.3/share/x86_64-linux-ghc-8.8.3/quickCheckTest-0.1.0.0"
libexecdir = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/qcExample/.stack-work/install/x86_64-linux-tinfo6/62d3b9c13e664827bc5c024cbfdcbadb6cb2f4b25639a3412f822a1dc179279f/8.8.3/libexec/x86_64-linux-ghc-8.8.3/quickCheckTest-0.1.0.0"
sysconfdir = "/home/chmnpanda/Desktop/code/Haskell-Book/chapter14/qcExample/.stack-work/install/x86_64-linux-tinfo6/62d3b9c13e664827bc5c024cbfdcbadb6cb2f4b25639a3412f822a1dc179279f/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "quickCheckTest_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "quickCheckTest_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "quickCheckTest_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "quickCheckTest_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "quickCheckTest_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "quickCheckTest_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)

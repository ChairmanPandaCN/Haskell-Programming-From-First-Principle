{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_monoidAssoc (
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

bindir     = "/home/chmnpanda/Desktop/code/Haskell-Programming-From-First-Principle/chapter15/monoidAssoc/.stack-work/install/x86_64-linux-tinfo6/483fc7f1424283274843084af5a1854fcf5e14ee0f41df927c8f58662f4dadce/8.8.3/bin"
libdir     = "/home/chmnpanda/Desktop/code/Haskell-Programming-From-First-Principle/chapter15/monoidAssoc/.stack-work/install/x86_64-linux-tinfo6/483fc7f1424283274843084af5a1854fcf5e14ee0f41df927c8f58662f4dadce/8.8.3/lib/x86_64-linux-ghc-8.8.3/monoidAssoc-0.1.0.0-EiG8VIOPKRmGb7GT3pDgg9-monoidAssoc"
dynlibdir  = "/home/chmnpanda/Desktop/code/Haskell-Programming-From-First-Principle/chapter15/monoidAssoc/.stack-work/install/x86_64-linux-tinfo6/483fc7f1424283274843084af5a1854fcf5e14ee0f41df927c8f58662f4dadce/8.8.3/lib/x86_64-linux-ghc-8.8.3"
datadir    = "/home/chmnpanda/Desktop/code/Haskell-Programming-From-First-Principle/chapter15/monoidAssoc/.stack-work/install/x86_64-linux-tinfo6/483fc7f1424283274843084af5a1854fcf5e14ee0f41df927c8f58662f4dadce/8.8.3/share/x86_64-linux-ghc-8.8.3/monoidAssoc-0.1.0.0"
libexecdir = "/home/chmnpanda/Desktop/code/Haskell-Programming-From-First-Principle/chapter15/monoidAssoc/.stack-work/install/x86_64-linux-tinfo6/483fc7f1424283274843084af5a1854fcf5e14ee0f41df927c8f58662f4dadce/8.8.3/libexec/x86_64-linux-ghc-8.8.3/monoidAssoc-0.1.0.0"
sysconfdir = "/home/chmnpanda/Desktop/code/Haskell-Programming-From-First-Principle/chapter15/monoidAssoc/.stack-work/install/x86_64-linux-tinfo6/483fc7f1424283274843084af5a1854fcf5e14ee0f41df927c8f58662f4dadce/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "monoidAssoc_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "monoidAssoc_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "monoidAssoc_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "monoidAssoc_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "monoidAssoc_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "monoidAssoc_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)

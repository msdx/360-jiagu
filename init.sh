binDir=""
case "`uname`" in
  Linux* )
    binDir="linux"
    ;;
  Darwin* )
    binDir="darwin"
    ;;
  CYGWIN* )
    binDir="windows"
    ;;
  MINGW* )
    binDir="windows"
    ;;
esac
if [ ! -n "$binDir" ]; then
  echo "We do not support `uname`"
  exit 1;
fi
if [ -f "java/bin" ]; then
  rm bin
fi
cp -rf java/$binDir java/bin

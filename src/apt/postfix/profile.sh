export PATH="/var/vcap/packages/postfix/apt/usr/bin:/var/vcap/packages/postfix/apt/usr/sbin:$PATH"
export LD_LIBRARY_PATH="/var/vcap/packages/postfix/apt/usr/lib/postfix:${LD_LIBRARY_PATH:-}"
export INCLUDE_PATH="/var/vcap/packages/postfix/apt/usr/include:${INCLUDE_PATH:-}"
export CPATH="$INCLUDE_PATH"
export CPPPATH="$INCLUDE_PATH"

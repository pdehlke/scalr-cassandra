set -o nounset
set -o errexit

export DEBIAN_FRONTEND="noninteractive"

command -v curl 2>&1 > /dev/null || {
  apt-get install -y curl
}

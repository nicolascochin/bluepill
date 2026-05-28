# Exit immediately if a command exits with a non-zero status
set -e

# Give people a chance to retry running the installation
trap 'echo "BluePill installation failed! You can retry by running: source ${BLUEPILL_LOCAL}/install.sh"' ERR

BLUEPILL_LOCAL="${BLUEPILL_LOCAL:-${HOME}/.local/share/bluepill}"

# Install everything
for f in ${BLUEPILL_LOCAL}/install/*.sh; do
  echo -e "\nRunning installer: $f"
  source "$f"
done

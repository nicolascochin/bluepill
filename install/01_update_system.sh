echo "Checking if a system update is available"

if rpm-ostree upgrade --check 2> /dev/null | grep -q "AvailableUpdate"
then     
  echo "Updating the system"
  rpm-ostree upgrade --reboot
else     
  echo "System is up 2 date"
fi

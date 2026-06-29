check_system_update() {
  local rpm_exit

  if rpm-ostree upgrade --check >/dev/null 2>&1; then
    rpm_exit=0
  else
    rpm_exit=$?
  fi

  case "$rpm_exit" in
    77)
      # Système à jour
      return 0
      ;;
    0)      
      echo "An update is available. Please update and retry." >&2
      return 1
      ;;
    *)
      echo "System is busy (e.g. upgrade in progress). Retry later." >&2
      return 1
      ;;
    esac
}

run_logged "🔍 Checking if the system is up to date" check_system_update || exit 1

{{- if .kubernetes -}}
if set -q TMUX
  # Unset conflicting global variables.
  set globalsToUnset DBUS_SESSION_BUS_ADDRESS DBUS_SESSION_BUS_ID DBUS_SESSION_BUS_WINDOWID GNOME_KEYRING_CONTROL SSH_AUTH_SOCK
  set globals (set -gx | cut -d' ' -f 1)
  for var in $globalsToUnset
    if contains -- $var $globals
      set -e $var
    end
  end
end
{{- end -}}
# http://zsh.sourceforge.net/Contrib/startup/users/debbiep/dot.zshenv

rationalize-path () {             
  # Note that this works only on arrays, not colon-delimited strings.
  # Not that this is a problem now that there is typeset -T.
  local element
  local build
  build=()
  # Evil quoting to survive an eval and to make sure that
  # this works even with variables containing IFS characters, if I'm
  # crazy enough to setopt shwordsplit.
  eval '
  foreach element in "$'"$1"'[@]"
  do
    if [[ -d "$element" ]]
    then
      build=("$build[@]" "$element")
    fi
  done
  '"$1"'=( "$build[@]" )
  '
}

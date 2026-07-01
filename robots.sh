# robots.sh — aliases for moi robots. Source from ~/.zshrc:  source ~/robots.sh
: "${MOI_HOME:=$HOME/Nextcloud}"
MOI_HOME="${MOI_HOME/#\~/$HOME}"   # expand a literal leading ~ if present
export MOI_HOME

# Each robot loads its persona via --append-system-prompt and gets read/write
# access to the moi tree via --add-dir. Run from any directory.
robot() { local name="$1"; shift; claude --dangerously-skip-permissions --append-system-prompt "$(cat "$MOI_HOME/Robots/$name/CLAUDE.md")" --add-dir "$MOI_HOME" "$@"; }

alias zeni='robot zeni'      # finance
alias lumen='robot lumen'    # photographer
alias bonsai='robot bonsai'  # gardener
alias souk='robot souk'      # inventory & marketplace
alias umami='robot umami'    # kitchen
alias kura='robot kura'      # archivist
alias milo='robot milo'      # physical trainer
alias rem='robot rem'        # sleep & dreams
alias eros='robot eros'      # sexual health
alias mole='robot mole'      # chemistry
alias stanza='robot stanza'  # interior decorator
alias obi='robot obi'        # fashion & wardrobe
alias vitals='robot vitals'  # medical & health tracking
alias psyche='robot psyche'  # mental health & neurodiversity
alias bodhi='robot bodhi'    # spiritual & contemplative
alias daemon='robot daemon'  # software engineer (Rust/Python/Linux)
alias bolt='robot bolt'      # mechanical/electrical maker
alias domus='robot domus'    # architect
alias iris='robot iris'      # messenger / relay across platforms
alias scoop='robot scoop'    # journalist / news & RSS
alias demos='robot demos'    # political / civic engagement
alias kino='robot kino'      # movies / cinema
alias vinyl='robot vinyl'    # DJ / music library
alias praxis='robot praxis'  # teacher / learning by doing
alias maestro='robot maestro' # orchestrator — oversees & routes to all bots

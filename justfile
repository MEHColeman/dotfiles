# Personal justfile at ~/.justfile — the terminus of `just`'s upward search.
# Run from anywhere with the `j` alias (plain `just`, walks up the tree).
# Use `jg <recipe>` to explicitly target this file via `just -g`.
#
# For per-project justfiles to fall back here when a recipe isn't found,
# put `set fallback := true` at the top of the project's justfile.

# Default recipe: list all recipes when you just run `j`.
default:
    @just --list

# --- examples — replace with your own ---

# Start a local static server in the current directory on port 8000.
serve port="8000":
    python3 -m http.server {{port}}

# Show your public IP.
myip:
    curl -s https://ifconfig.me; echo

# Pi Coding Agent — extension stacks live in ~/.agents/pi-extensions/
# (symlinked from coding_agents repo). Add new modes by adding new recipes.

# Default pi: most-used stack — UI widget, persona switcher, replay,
# discipline (purpose+tasks), safety, ad-hoc subagents, journal capture.
pi:
    pi \
        -e ~/.agents/pi-extensions/tool-counter-widget.ts \
        -e ~/.agents/pi-extensions/system-select.ts \
        -e ~/.agents/pi-extensions/session-replay.ts \
        -e ~/.agents/pi-extensions/purpose-gate.ts \
        -e ~/.agents/pi-extensions/tilldone.ts \
        -e ~/.agents/pi-extensions/damage-control.ts \
        -e ~/.agents/pi-extensions/subagent-widget.ts \
        -e ~/.agents/pi-extensions/pi-pi.ts \
        -e ~/.agents/pi-extensions/journal.ts

# Pi for development: default + agent-team dispatcher + agent-chain pipelines.
pi-dev:
    pi \
        -e ~/.agents/pi-extensions/tool-counter-widget.ts \
        -e ~/.agents/pi-extensions/system-select.ts \
        -e ~/.agents/pi-extensions/session-replay.ts \
        -e ~/.agents/pi-extensions/purpose-gate.ts \
        -e ~/.agents/pi-extensions/tilldone.ts \
        -e ~/.agents/pi-extensions/damage-control.ts \
        -e ~/.agents/pi-extensions/subagent-widget.ts \
        -e ~/.agents/pi-extensions/pi-pi.ts \
        -e ~/.agents/pi-extensions/journal.ts \
        -e ~/.agents/pi-extensions/agent-team.ts \
        -e ~/.agents/pi-extensions/agent-chain.ts

# Pi for research: exploratory, surfaces .claude/.gemini/.codex commands,
# drops shell-discipline gates that aren't useful for search-heavy work.
pi-research:
    pi \
        -e ~/.agents/pi-extensions/tool-counter-widget.ts \
        -e ~/.agents/pi-extensions/system-select.ts \
        -e ~/.agents/pi-extensions/session-replay.ts \
        -e ~/.agents/pi-extensions/subagent-widget.ts \
        -e ~/.agents/pi-extensions/pi-pi.ts \
        -e ~/.agents/pi-extensions/journal.ts \
        -e ~/.agents/pi-extensions/cross-agent.ts \
        -e ~/.agents/pi-extensions/minimal.ts

# Pi for consulting: lean, conversational, decision-capture focused.
pi-consulting:
    pi \
        -e ~/.agents/pi-extensions/system-select.ts \
        -e ~/.agents/pi-extensions/session-replay.ts \
        -e ~/.agents/pi-extensions/purpose-gate.ts \
        -e ~/.agents/pi-extensions/journal.ts \
        -e ~/.agents/pi-extensions/damage-control.ts \
        -e ~/.agents/pi-extensions/minimal.ts

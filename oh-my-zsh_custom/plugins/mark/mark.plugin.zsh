notes() { vi ~/notes/$1;  }
_notes() { _files -W ~/notes -/; }
compdef _notes notes

mgage() { cd ~/dev/mgage/$1;  }
_mgage() { _files -W ~/dev/mgage -/; }
compdef _mgage mgage

msp() { cd ~/dev/msp/$1;  }
_msp() { _files -W ~/dev/msp -/; }
compdef _msp msp

bw() { cd ~/dev/bw/$1;  }
_bw() { _files -W ~/dev/bw -/; }
compdef _bw bw

projects() { cd ~/dev/bw/projects/$1;  }
_projects() { _files -W ~/bw/projects -/; }
compdef _projects projects

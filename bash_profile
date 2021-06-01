export PS1="\[\033[38;5;221m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\[$(tput sgr0)\]\[\033[38;5;192m\]\w\[$(tput sgr0)\]\[\033[38;5;6m\]]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
export PS1="\[\e[38;5;221m\]\W\[\e[m\] "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:~/.local/bin
alias ls='ls -GFh'
alias omni='cd ~/Documents/Transmira'
alias ll='ls -l'
alias server='py -m SimpleHTTPServer'
alias sshpi='ssh pi@192.168.0.107' # 10.0.0.19'
alias tf='terraform'
alias fion='cd ~/Documents/fion'
alias sq=sequelize
alias fiond='tmux at -t fion'
alias py='python3'
alias fionc='ssh -i ~/Downloads/forge.cer ubuntu@ec2-54-92-202-105.compute-1.amazonaws.com'
source ~/.bashrc
function cl {
 cd $1;
 ls -l;
}

function bs-react {
  echo 'Bootstrapping a React environment for you preloaded with webpack, babel, and eslint'
  cp -r ~/Documents/learn/front-end/bootstrap-react-webpack-babel/ .;
  rm -rf node_modules/;
  rm -rf .git;
  npm init -y 
  npm install;
  echo 'Done.'
   echo 'Dont forget to change the package name in package.json'
}

function k {
  if [ "$1" = "d" ]; then
    kubectl describe "${@:2}"
  elif [ "$1" = "del" ]; then
    kubectl delete "${@:2}"
  elif [ "$1" = "c" ]; then
     kubectl create "${@:2}"
  elif [ "$1" = "g" ]; then
     kubectl get "${@:2}"
  elif [ "$1" = "r" ]; then
     kubectl run "${@:2}"
  elif [ "$1" = "e" ]; then
     kubectl exec "${@:2}"
  elif [ "$1" = "a" ]; then
     kubectl apply "${@:2}"
  elif [ "$1" = "x" ]; then
     kubectl explain "${@:2}"
  elif [ "$1" = "ed" ]; then
     kubectl edit "${@:2}"
  else
    kubectl "$@"
  fi
}
function fmt {
  js-beautify -o "$1" "$1"
}

function bb {
  kubectl run test --image=busybox --rm -it --restart=Never -- $@
}

function killport {
  kill -9 $(lsof -t -i:$1)
}

function recompile {
  cd functions/;yarn compile;cd ..;yarn start-functions
}

function create_react_component {
mkdir $1
cd $1
  cat >> index.js << EOF
  import $1 from './$1'

  export default $1
EOF

  cat >> $1.js << EOF
import React from 'react';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({

}));


const $1 = () => {

  const classes = useStyles();
  return (
    <div/>
  );
};


export default $1;
EOF

cat >> $1.stories.js << EOF
import React from 'react';
import { createMuiTheme, MuiThemeProvider } from '@material-ui/core/styles';
import {
  withKnobs, text, boolean, number
} from '@storybook/addon-knobs';
import themeOverrides from '../../constants/theme';
import $1 from '.';

const theme = createMuiTheme(themeOverrides);

export default {
  title: '$1',
  decorators: [withKnobs, (story) => (
    <div style={{
    }}
    >
        {story()}
    </div>
  )],
};

export const withDefault = () => (
  <MuiThemeProvider theme={theme}>
    <$1/>
  </MuiThemeProvider>
);
EOF
}

function create_neu_component {
mkdir $1
cd $1
  cat >> index.js << EOF
  import $1 from './$1'

  export default $1
EOF

  cat >> $1.js << EOF
import React from 'react';
import styled from 'styled-components';

const $1 = () => {

  return (
    <div/>
  );
};


export default $1;
EOF

cat >> $1.stories.js << EOF
import React from 'react';
import {
  withKnobs, text, boolean, number
} from '@storybook/addon-knobs';
import $1 from '.';


export default {
  title: '$1',
  decorators: [withKnobs, (story) => (
    <div style={{
      minHeight: '100vh',
      minWidth: '100vw',
      background: '#ccd2ed',
    }}
    >
        {story()}
    </div>
  )],
};

export const withDefault = () => (
    <$1/>
);
EOF
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mikeyturck/google-cloud-sdk/path.bash.inc' ]; then . '/Users/mikeyturck/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mikeyturck/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/mikeyturck/google-cloud-sdk/completion.bash.inc'; fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
#refer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
. $(pack completion)
. "$HOME/.cargo/env"

complete -C /opt/homebrew/bin/terraform terraform

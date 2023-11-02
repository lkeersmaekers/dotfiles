# dotfiles

from https://www.atlassian.com/git/tutorials/dotfiles

ssh issues https://stackoverflow.com/a/2643584/52598

     -- New installations
     -- ssh-keygen
     -- cat ~/.ssh/id_rsa.pub
     -- Add public key to account
     --    https://github.com/settings/keys
     --    https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

      git clone --bare git@github.com:lkeersmaekers/dotfiles $HOME/.cfg
      function config {
         /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
      }
      mkdir -p .config-backup
      config checkout
      if [ $? = 0 ]; then
        echo "Checked out config.";
        else
          echo "Backing up pre-existing dot files.";
          config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
      fi;
      config checkout
      config config status.showUntrackedFiles no

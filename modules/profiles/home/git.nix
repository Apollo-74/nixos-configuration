{ config, ... }: {
  programs. git = {
    enable = true;
    config = {
      init.defaultBranch = "master";

      user = {
        name = config.users.users.default.name;
        email = "Demogorgon-74@ya.ru";
      };

      clone.filterSubmodules = true;

      url = {
        "git@github.com:".pushInsteadOf = "https://github.com/";
        "git@gist.github.com:".pushInsteadOf = "https://gist.github.com/";
      };

      pager.difftool = true;

      diff = {
        tool = "difftastic";
      };

      difftool = {
        prompt = false;
        "difftastic".cmd = ''difft "$LOCAL" "$REMOTE"'';
      };

      commit.verbose = true;

      push = {
        autoSetupRemote = true;
        default = "current";
      };

      remote.pushdefault = "origin";

      alias = {
        st = "status";
        cm = "commit";
        sw = "switch";
        dt = "difftool";
        fx = "commit --fixup";
        au = "remote add -f upstream";
        rb = "rebase --autosquash --autostash --interactive";
        prb = "pull --rebase --autostash";
        cb = "switch -c";
        bd = "branch -D";
        l = "log --graph --pretty='%C(bold yellow)%h%Creset * %C(bold magenta)%an%Creset * %C(blue)%ar%Creset: %s %C(auto)%d%Creset'";
        lg = "log --graph --pretty=format:'%C(bold yellow)%h%Creset * %C(bold magenta)%an%Creset * %C(blue)%ar%Creset *%C(auto)%d%Creset%n%n%B'";
        # no blobs and no checkout, because checkout has been taught to bulk
        # pre-fetch all required missing blobs in a single batch
        clone-big = "clone --filter=blob:none --no-checkout";
      };
    };
  };
}

# Beaver

Originally inspired by https://github.com/kunchenguid/firstmate/

Firstmate is amazing, but honestly it does way more than what I need it for.  So this is a smaller & opinionated single player version for speed & token efficiency.  You can spawn multiple beavers to work concurrently, and I typically pair this setup with [switcheroo](https://github.com/khooeee/switcheroo/).

Start your coding agent in the beaver folder with all your Github repos under the projects directory, and begin working across multiple projects from the same session easily.

You can also have concurrent sessions in the same beaver folder as well doing different things because all changes happen in linked worktrees by default.

## Setup

```sh
cd
git clone git@github.com:khooeee/beaver.git
```

Let's say you have your code in `~/code`.  Create your projects symlink as:

```sh
cd ~/beaver
ln -s ../code projects
```

If you `mkdir ~/beaver/projects` and place all your code there, you might experience a problem where you might want to work on a project without using beaver. You start a coding session from that specific project directory with Claude Code, expecting beaver AGENTS.md to not be active.  Claude Code and Pi has slightly different behavior from Codex or Cursor CLI where it will walk upwards from your working directory to load AGENTS.md and start automatically creating worktrees, etc.

Add Beaver's helpers to PATH for your shell:

```sh
# Bash
echo 'export PATH=~/beaver/bin:$PATH' >> ~/.bashrc
echo 'alias cb="cd ~/beaver"' >> ~/.bashrc
echo 'alias cbp="cd ~/beaver/projects"' >> ~/.bashrc


# Zsh
echo 'export PATH=~/beaver/bin:$PATH' >> ~/.zshrc
echo 'alias cb="cd ~/beaver"' >> ~/.zshrc
echo 'alias cbp="cd ~/beaver/projects"' >> ~/.zshrc
```

Add `TERMINOLOGY.md` if you have terms that refer to some aspect of your project (i.e. basically a shortcut for a project subdirectory).

See bin folder for relevant helper scripts that will be very useful for day-to-day use.

## Default Conventions

- Any requested code change will open a PR immediately, and any related changes will commit and push to the PR immediately.
- When a PR is merged or closed, it will delete all associated worktrees & branches immediately. If your main worktree is on the same branch, it will also switch back to the default branch and fast forward it to latest.
- When you ask to checkout a branch or PR, it means checkout to the main worktree.  This operation will also fast-forward or rebase on latest in the default branch.
- When you ask to work in the main worktree, it will fetch and fast-forward or rebase that worktree onto the latest origin default branch before making changes.

## Cleanup

It's expected that there will be some leftover local branches & worktrees after your work.  You can either leave these alone, or cleanup after yourself.  However, it's better to cleanup after yourself so your agent doesn't spend time enumerating them while investigating your repos.

```sh
b-cleanup # will show you all local non-main branches & worktrees and ask you for confirmation before cleaning up
```

The reason why we made cleanup a manual process was that in order to implement a proper cleanup process, we didn't want to be too aggressive (e.g. cleanup after every operation). Nor do we want to wait 30mins before deleting them (which incurs a cost for the agent in checking at every turn).  Hence, we leave that up to you.

## Why the name beaver?

I love beavers.  They are one of the most famous builders in the animal kingdom.  They build dams, lodges, canals and food caches.  Like me, they just love to build!

Licensed under the [MIT License](LICENSE).

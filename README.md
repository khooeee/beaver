# Beaver

This is a single player coding agent project manager focused on speed & token efficiency.  I typically pair this setup with switcheroo.  Firstmate inspired the creation of this project.

To get started, start your coding agent in the beaver folder with all your Github repos under the projects directory, and begin working across multiple projects from the same session easily.

You can run multiple sessions in the same beaver folder doing different things at the same time because all code changes happen in linked worktrees by default.

## Setup

```sh
cd
git clone git@github.com:khooeee/beaver.git
```

Let's say you have your code in `~/code`.  Create the projects symlink with:

```sh
cd ~/beaver
ln -s ../code projects
```

Rationale: Claude Code and Pi will walk upwards and load `AGENTS.md`.  If you created the symlink `~/code` to point to `~/beaver/projects` instead, you would likely find your Claude Code or Pi session in `~/code/projectName` odd, as it starts to create worktrees for your changes as if it was following beaver's rules.

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

Add `TERMINOLOGY.md` if you have terms that refer to some aspect of your project (i.e. it's useful as a shortcut for a project subdirectory).

## Scripts

```sh
b-status
```

Shows each project's current branch. The DIRTY column has an `x` when that worktree has uncommitted changes.

```sh
b-checkout-main
```

Checks out each project's default branch and fast-forwards it from origin. A project with uncommitted changes stays on its current branch.

```sh
b-branches-and-worktrees
```

Lists leftover local branches, remote-tracking branches, and linked worktrees. Branches other than each project's default branch are the ones that show up.

```sh
b-cleanup-branches-and-worktrees
```

Shows that same list, then waits for you to type `y` before deleting those local branches, remote-tracking branches, and linked worktrees. Branches on the remotes stay.

## Default Conventions

- Any requested code change will create a worktree, push the relevant changes & open a PR immediately.  Any further changes will commit and push to the PR.
- When the PR is merged or closed, it will delete all associated worktrees & branches.  If your main worktree is on the same branch, it will also switch back to the default branch and fast forward it to latest.
- When you ask to checkout a branch or PR, it means to checkout that branch on the main worktree.  This operation will also fast-forward or rebase on the default branch's latest SHA.

## Cleanup

It's expected that there will be some leftover local branches, remote-tracking branches, and worktrees after your work.  You can either leave these alone, or cleanup after yourself.  However, it's better to cleanup after yourself so your agent doesn't spend time enumerating them while investigating your repos.

```sh
b-cleanup-branches-and-worktrees
```

The reason why we made cleanup a manual process was because a smart cleanup process would require alot of checks often.  This would slow down your coding agent too much, a big no no in our book for now.  Hence, we leave that up to you.

## Why the name beaver?

I love beavers.  They are one of the most famous builders in the animal kingdom.  They build dams, lodges, canals and food caches.  Like me, they love to build!

Licensed under the MIT License.

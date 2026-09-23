# Beaver

This is a single player coding agent project manager focused on speed & token efficiency.  I typically pair this setup with birdsong.  Firstmate inspired the creation of this project.

To get started, start your coding agent in the beaver folder with all your Github repos under the projects directory, and begin working across multiple projects from the same session easily.

You can run multiple sessions in the same beaver folder doing different things at the same time because all code changes happen in linked worktrees by default.

## Setup

```sh
cd
git clone git@github.com:khooeee/beaver.git
```

Put your actual code files in `~/beaver-code`.  Create the projects symlink with:

```sh
cd ~/beaver
ln -s ../beaver-code projects
```

Rationale: Claude Code and Pi will walk upwards and load `AGENTS.md`.  If your code was in `~/beaver/projects` and you created the symlink `~/beaver-code` instead, you would likely find that when you start your Claude Code or Pi session in `~/beaver-code/projectName`, it starts to create worktrees for your changes as if it was following beaver's rules which is likely what you didn't intend.

Add `TERMINOLOGY.md` if you have terms that refer to some aspect of your project (i.e. it's useful as a shortcut for a project subdirectory).

## Default Conventions

- Any requested code change will create a worktree, push the relevant changes & open a PR immediately.  Any further changes will commit and push to the PR.
- When the PR is merged or closed, it will delete all associated worktrees & branches.  If your main worktree is on the same branch, it will also switch back to the default branch and fast forward it to latest.
- When you ask to checkout a branch or PR, it means to checkout that branch on the main worktree.  This operation will also fast-forward or rebase on the default branch's latest SHA.

## Why the name beaver?

I love beavers.  They are one of the most famous builders in the animal kingdom.  They build dams, lodges, canals and food caches.  Like me, they love to build!

Licensed under the MIT License.

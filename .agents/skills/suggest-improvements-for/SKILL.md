---
name: suggest-improvements
description: >-
  Suggests 10 improvements to a specified project grounded in that project's
  VISION.md. Use when the user asks to suggest improvements, product ideas,
  next steps, or gaps against vision, or invokes suggest-improvements.
---

# Suggest Improvements

Propose **exactly 10** improvements for a specified project, scored against that project's `VISION.md`.

## Resolve the project

1. Identify the target from the user's request (name, path, or shorthand). If `TERMINOLOGY.md` exists at the Beaver workspace root, use it only for names relevant to this request.
2. Locate the project under `./projects/<project>` when working from Beaver, or use the specified repo path. Do not treat Beaver itself as the target unless the user named Beaver.

## Require VISION.md

Look for `VISION.md` at the **project root** (the specified project's root, not Beaver's, unless Beaver is the target).

If `VISION.md` is missing, **stop**. Ask the user to create it first. Do not invent a vision, do not suggest improvements, and do not substitute README, issues, or chat context for the vision.

## Suggest from the vision

When `VISION.md` exists:

1. Read it in full. Treat north star, metrics, and constraints as the scoring rubric.
2. Inspect the project enough to see how the current product, code, and workflow diverge from that vision.
3. Propose **10** improvements. Each one must:
   - Move the project toward the vision (or remove a concrete obstacle named in it)
   - Be specific to this project, not generic engineering advice
   - Be actionable: what to change and why it matters against the vision
4. Do not implement unless the user asks.

## Output

Lead with the project name and a one-line restatement of the vision.

Then list items **1–10**. For each:

- **Title** — short
- **Why** — one or two sentences tying the gap to `VISION.md`
- **Do** — the smallest useful next step

Prefer the ten highest-leverage moves. Mix product, workflow, and technical items when the vision calls for it. Do not pad to 10 with unrelated polish.

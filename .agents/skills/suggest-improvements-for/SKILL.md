---
name: suggest-improvements-for
description: >-
  Suggests 10 improvements to a specified project, grounded in goals inferred
  from that project's README and code. Use when the user asks to suggest
  improvements, product ideas, next steps, or gaps, or invokes
  suggest-improvements.
---

# Suggest Improvements

Propose **exactly 10** improvements for a specified project. Infer the project's goals from its README and code.

## Resolve the project

1. Identify the target from the user's request (name, path, or shorthand). If `TERMINOLOGY.md` exists at the Beaver workspace root, use it only for names relevant to this request.
2. Locate the project under `./projects/<project>` when working from Beaver, or use the specified repo path. Do not treat Beaver itself as the target unless the user named Beaver.

## Infer goals

Read the project before suggesting anything.

1. Read the README at the project root in full (common names: `README.md`, `README`). If none exists, continue from the code and other docs that state purpose.
2. Inspect enough of the code, tests, and configuration to see what the product actually does, who it is for, and what it treats as constraints.
3. From that reading, infer the goals: intended outcome, audience, and the constraints the project already commits to. Use those as the scoring rubric.
4. If the README and the code disagree, prefer the behavior the code implements, and note the mismatch only when it changes a suggestion.

## Suggest from those goals

Propose **10** improvements. Each one must:

- Move the project toward a goal you inferred, or remove a concrete obstacle to one
- Be specific to this project, not generic engineering advice
- Be actionable: what to change and why it matters against those goals

Do not implement unless the user asks.

## Output

Lead with the project name and a one-line restatement of the inferred goals.

Then list items **1–10**. For each:

- **Title** — short
- **Why** — one or two sentences tying the gap to a goal inferred from the README or code
- **Do** — the smallest useful next step

Prefer the ten highest-leverage moves. Mix product, workflow, and technical items when the inferred goals call for it. Do not pad to 10 with unrelated polish.

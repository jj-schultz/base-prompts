Write or update a repo-local skill instruction file in `./.ai_coding/ai_coding_common`.

The text after `$SKILL_WRITER` is the skill-writing brief.

Goal: produce skill instructions that maximize LLM comprehension, execution accuracy, and low ambiguity.

## Required workflow

1. Resolve the target skill.
   - If the brief names an existing skill marker, read `instructions--skills.md` and the mapped skill file first.
   - If the brief requests a new skill, create `skill--<skill_name>.md` in `./.ai_coding/ai_coding_common` and add the marker-to-file mapping in `instructions--skills.md`.
   - Match the local naming and dispatch conventions already used in this directory.

2. Gather only the needed context.
   - Read the active `todo.md`.
   - Read nearby skills that are closest in behavior, scope, or output format.
   - Reuse local wording and structure when it improves consistency.
   - Do not invent capabilities that are not supported by the brief or repository conventions.

3. Write for LLM execution, not human narration.
   - Start with a direct statement of the skill's job.
   - Use short ordered steps when sequence matters.
   - State required inputs, required outputs, hard constraints, and allowed scope explicitly.
   - Prefer imperative verbs, concrete file paths, and deterministic instructions.
   - Remove filler, motivational language, and rationale history.
   - Keep the skill concise; include examples only when they materially reduce ambiguity.

4. Optimize for comprehension and accuracy.
   - Eliminate vague references such as `it`, `this`, `things`, or `handle that` when a concrete noun is available.
   - Make branching rules explicit so an agent can tell when to create, update, append, or stop.
   - If the skill is non-mutating or scope-limited, state exactly which files may be edited.
   - If the skill requires a specific heading or append-only output format, define it exactly.
   - If validation is required, say what must be validated and when.

5. Keep the skill coherent with the repo.
   - Align with the repository's top-level instructions and avoid contradicting existing mandatory rules.
   - Do not duplicate global guidance unless repeating it prevents likely failure in this specific workflow.
   - When updating an existing skill, preserve correct behavior and tighten wording instead of rewriting gratuitously.

## Output requirements

- For a new skill, create the skill file and wire it into `instructions--skills.md`.
- For an existing skill, update the existing skill file and adjust `instructions--skills.md` only if dispatch metadata changed.
- The final skill text must be concise, directly executable, and easy for an LLM to scan in one pass.

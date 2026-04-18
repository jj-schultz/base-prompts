$QUESTION

how do i install this plug in pycharm?
[plugin](../../ai_coding/plugin)

## answer

You don't install the source folder directly in PyCharm. You install the built plugin ZIP.

Fastest path:

1. Open PyCharm `Settings` / `Preferences`.
2. Go to `Plugins`.
3. Click the gear icon.
4. Choose `Install Plugin from Disk...`.
5. Select `ai_coding/plugin/build/distributions/ai-coding-todo-skills-plugin-0.1.7.zip`.
6. Restart PyCharm.

Notes:

- The plugin name is `AI Coding Todo Skills`.
- This repo already has the ZIP built, so you probably do not need to compile anything first.
- If you do want to rebuild it, run `cd ai_coding/plugin && ./build_plugin.sh`. That script also increments the plugin version before building.
- Do not point PyCharm at `ai_coding/plugin/` itself. PyCharm wants the built ZIP or JAR artifact.
- The plugin declares `since-build="243"` and is currently built against PyCharm Professional `2024.3.5`, so PyCharm 2024.3.x is the safest target. Older versions are unlikely to load it.

## files touched

- `.ai_coding/todo/todo.md` - lines 6-29: appended the PyCharm install answer, rebuild note, compatibility note, and this file summary. No other files were modified.

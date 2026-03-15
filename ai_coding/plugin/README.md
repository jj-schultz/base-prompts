# AI Coding Todo Skills Plugin

IntelliJ Platform plugin that autocompletes AI coding skill commands inside `todo*.md` files.

## Behavior

- Reads commands from the active project's `.ai_coding/ai_coding_common/instructions--skills.md`
- Restricts autocomplete to filenames that start with `todo` and end with `.md`
- Shows help text in the completion popup using the first non-empty line from each referenced skill file
- Triggers completion automatically when `$` is typed in a matching file

## Development

Requirements:

- JDK 21

Run the sandbox IDE from this directory:

```bash
./gradlew runIde
```

If you prefer the IDE UI, open this directory as a Gradle project and run the `runIde` task.

Build the plugin ZIP from this directory:

```bash
./build_plugin.sh
```

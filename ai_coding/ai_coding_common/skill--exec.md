Interpret the text following the `$EXEC` skill as a request to execute an existing command or script that satisfies the stated intent.

# Required Workflow
1. Read the full todo text after the `$EXEC` line and identify the intended outcome plus any explicit constraints.
2. Inspect the repository for an existing command, script, package script, Make target, or documented workflow that already satisfies that intent. Prefer existing automation over writing new code.
3. Only if no existing command or script can satisfy the intent may you create a new script.
4. If you create a new script, save it under `./tmp-scripts/` by default because these scripts are usually one-offs. Only choose another location if the repository already has a stronger established convention for this exact kind of script. Follow existing naming, shell, and dependency patterns, and keep the script narrowly scoped to the requested execution task.
5. Before running any command or script, ask the user for permission to execute it.
6. The permission request must include:
   - the exact command or script you plan to run
   - why it is the best match for the requested intent
   - the concrete risks or side effects, including file writes, network calls, service changes, long runtimes, or destructive operations when applicable
7. Only run the command if the user explicitly agrees. If the user does not agree, do not execute it.
8. After execution, report the outcome concisely and surface any follow-up action required.

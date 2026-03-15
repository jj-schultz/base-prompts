First, identify the desired functionality by one or both of the following methods
-  If there is text in the todo file after the `$GAP` line use this as the 'desired' functionality
-  or if a 'goal.md' file exists in the same directory as the todo file, use the contents of this file as the 'desired functionality'

# When performing a gap analysis
1.  review the curent state of the code and identify if code currently supports the "Desired Functionality".   Any difference between what is currently implemented in the code and the "Desired Functionality" is considered a 'gap'
2. If there is no gap in functionality, append to the todo a high level overview of the implementation and the significant related files.  
3. If there is a gap, append to the todo.md file a plan for closing the gap
4. VERY IMPORTANT:  **only** make a plan for fixing what is described in the "Desired Functionality".  Do not attempt to fix or add functionality for anything that is not described.

# How to write a plan for closing the gap
1. Before you write the plan, research the existing codebase to see what methods might be reusable (small backwards compatible modifications are ok) - look to reuse as much existing code as possible.
2. Write a step by step plan that codex or claude code will follow to close the gap 
3. VERY IMPORTANT:  **only** make a plan for fixing what is described in the "Desired Functionality".  Do not attempt to fix or add functionality for anything that is not described.


# Reasoning Guide
- Take as much time as you need.  The more reasoning the better
- The plan must be accurate and detailed enough LLM to use autonomously in a vaccuum 
- Optimize for LLM comprension and execution
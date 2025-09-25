# Base Prompts

This repo holds a collection of the base prompts I put together for my personal use

## ChatGPT Global prompts
To use, open ChatGPT customization settings, and add the prompt to the section "What traits should ChatGPT have?"

#### [chatgpt_personalization.md](chatgpt_personalization.md)
This is the base prompt I use to customize ChatGPT’s behavior.  It covers tone, style, priorities, what I value, and how I want the model to communicate with me. 

## ChatGPT Project Prompts
To use these 'Project Prompts', create a new ChatGPT project and add the prompt as the project instructions

#### [daily_journal.md](daily_journal.md)
A journaling prompt that helps with daily reflection. Supports capturing what happened, what I learned, what I was feeling, and how things connect to broader goals.  Calls me out when necessary and provides critical feedback

**Daily Journal setup instructions**
1. Copy the text from [daily_journal.md](daily_journal.md) into the “Project Instructions” box when creating your `Daily Journal` ChatGPT project. This is the main set of instructions that guides how the journaling project works. The other files give it context, memory, and inspiration, but this one is the foundation.
2. Make a file called 'daily_journal_goals.md'. This is where you’ll keep track of your bigger goals, so your daily notes can link back to what matters most in the long run.
3. Make a file called 'daily_journal_inspirations.md'. Fill it with quotes, ideas, or themes that motivate you. Think of it as a library of inspiration to draw from.
4. Make a file called 'daily_journal_additional_context.md'. Use it to jot down background details or reminders that will help connect your journal entries over time.
5. Add those three files, plus everything inside [daily_journal--project_files](daily_journal--project_files), as “files” in the `Daily Journal` ChatGPT project.

Every morning in this project, I start a chat with a journal entry broken into three sections:
1.  Recap of yesterday (bulleted list of stuff that happened yesterday and how I felt about it)
2.  Today's agenda (bulleted list of my high level goals for today)
3.  Current mood (how I'm feeling 'right now')

#### [teacher.md](teacher.md)
Generic prompt that puts the model in “explainer” mode. Designed for thoughtful, layered teaching. Emphasis on walking step by step through ideas.

To use, just start a chat with a document or an url, and then let the learning begin!

#### [teacher--tech_topics.md](teacher--tech_topics.md)
**Works great with ChatGPT's Voice Mode (fun to use while driving)**
A specialization of the teacher prompt for technical domains—especially software engineering and machine learning. Supports explanation scaffolds, analogies, and gradual depth increases.

When I use this one, I'll open Voice Mode for this project while driving, and I'll just start asking questions about a topic I'm interested in

#### [article_parser.md](article_parser.md)
Takes long-form articles or newsletter content and extracts summaries and recommends if I should read them or not. I use this to pre-parse articles or newsletters to help me know what would be considered a valuable use of my time to read

#### [autobiographer.md](autobiographer.md)
**Works great with ChatGPT's Voice Mode (fun to use while driving)**
Used to turn journal entries or personal recollections into coherent autobiographical summaries. Designed to maintain voice, accuracy, and narrative continuity across time.

#### [boat_maintenance.md](boat_maintenance.md)
Specialist advisor for maintaining the 2022 MasterCraft X24 with the Ilmor 6.2L GDI. Use it when troubleshooting or planning service to get feasibility checks, safety notes, OEM-aware steps, and clear escalation guidance.

#### [dictation_cleaner.md](dictation_cleaner.md)
Paste raw speech-to-text here to have it lightly cleaned. The assistant preserves structure and vocabulary while fixing obvious transcription errors, punctuation, and my known misrecognitions, then returns a copy-ready block.

#### [sleep_analyzer.md](sleep_analyzer.md)
Sleep analysis project tuned for Withings Sleep Tracking Mat reports. Upload nightly screenshots to get structured summaries, metric breakdowns, 7/14-day trend commentary, and evidence-based recommendations adjusted to my habits.

#### [teacher--highschool_geometry.md](teacher--highschool_geometry.md)
Mastery-based geometry tutor for a high school sophomore. Run incremental lessons, scaffolded practice, and teacher-led quizzes; it never hands over answers and only advances when the student demonstrates real understanding.

#### [article_parser_2.md](article_parser_2.md)
An alternate article parsing workflow that ups the rigor. Share long-form pieces or links to get a 1-10 score, a decisive Read/Don't Read call, a critique of weak arguments, and distilled lessons mapped to my priorities.

#### [blogger.md](blogger.md)
Project instructions for my blogging co-pilot across Erie Iron, Collaya, ML, and leadership topics. Start a project with this prompt to receive the default deliverables (titles, hook, outline, artifacts, risks, examples, TLDR, LinkedIn post, SEO plan) and use the slash commands for drafting and edits.

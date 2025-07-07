# Base Prompts

This repository contains system prompts designed for use with large language models (LLMs) in various personalized and functional roles. Each prompt defines a specific behavioral scaffold or processing mode that can be injected into an LLM to shape its behavior, memory, and response style.

## 📄 Prompt Descriptions

### `chatgpt_personalization.md`
Defines user preferences, communication style, and assistant behavior. This is the foundational prompt used to personalize all interactions with ChatGPT—covering tone, formatting, honesty, and user expectations.

### `daily_journal.md`
Used to guide an LLM journaling agent in recording, organizing, and reflecting on the user's daily experiences. Supports structured formats and prompt chaining for reflection, learning capture, and emotional state tracking.

### `teacher.md`
A general teaching-mode prompt that guides the LLM to act as a thoughtful instructor. Encourages clarity, step-by-step logic, and encourages the user to develop deep understanding over superficial answers.

### `teacher--tech_topics.md`
A specialization of the `teacher.md` prompt tailored for technology subjects. Includes domain-specific scaffolding for engineering, software systems, and ML instruction, emphasizing layered explanations and analogies.

### `article_parser.md`
This prompt parses long-form text (e.g., articles or newsletters) and converts them into summarized, tagged, and scored outputs. Used in automated systems to generate content ratings and summaries 

### `autobiographer.md`
Directs the model to act as a personal historian, generating structured autobiographical summaries from journal entries or user memories. Emphasizes coherence across time, tone matching, and preserving narrative identity.

### `resume_builder`
Instructs the LLM to extract, organize, and polish information suitable for resumes or professional bios. Tailored for collaborative editing where the model iterates on job history and positioning.

---

## 🧠 Purpose

This repo acts as a composable library of high-quality LLM base prompts for:
- Personal assistant configuration
- Agent behavior modeling
- Workflow-specific automation
- Consistent persona shaping

## 📁 Usage

These prompts can be directly embedded into:
- Custom LLM-based agents
- Prompt chaining frameworks
- Journaling or summarization tools
- ChatGPT Custom Instructions



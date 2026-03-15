# Grant One-Pager LLM Agent 

## 1. Objective

produces high-quality, funder-aligned, one-page grant application summaries. The output must be concise, evidence-based, numerically consistent, and tightly mapped to funder priorities.

------------------------------------------------------------------------

## 2. Target Output Specification

**Length:** 450-650 words (approximately one page)\
**Voice:** Funder-facing, concrete, non-hype\
**Structure:** Fixed headings, in this exact order

1.  Project Title (\<=12 words)\
2.  One-Sentence Summary (\<=30 words)\
3.  Need / Problem (2-3 sentences + 1 statistic with citation)\
4.  Proposed Solution (3-5 sentences)\
5.  Activities and Timeline (3 bullets)\
6.  Outcomes and Measurement (3 bullets: metric, baseline, target)\
7.  Team and Partners (2-3 sentences)\
8.  Budget Snapshot (3 lines: total request, top 3 cost categories,
    match/in-kind)\
9.  Why This Funder (2 sentences explicitly mapped to funder
    priorities)\
10. Risks and Mitigations (2 bullets)\
11. Sustainability / Next Step (2 sentences)

### Hard Rules

-   Every claim must tie to an activity, metric, or citation.
-   Avoid vague verbs (e.g., "leverage", "innovative") unless explicitly
    defined.
-   All numbers must be internally consistent (timeline, budget,
    targets).
-   Do not invent facts. If required data is missing, request
    clarification.

------------------------------------------------------------------------

## 3. Required Inputs

The agent must request the following inputs before drafting:

### Funder

-   Name
-   Program
-   3-5 stated priorities
-   Maximum award
-   Duration
-   Eligibility constraints

### Applicant

-   Organization mission
-   Years active
-   2-3 proof points or outcomes
-   Geography served
-   Target population

### Project

-   Problem statement
-   Intervention
-   Activities
-   Timeline
-   Partners
-   Risks
-   Sustainability plan

### Evidence

-   3-7 citations (URL + short note)
-   Any internal data

### Budget

-   Total request amount
-   Match/in-kind amount
-   Top cost categories with justification

### Evaluation

-   Baseline data
-   Targets
-   Measurement method
-   Reporting cadence

------------------------------------------------------------------------

## 4. Agent Architecture

1.  **Planner**\
    Maps funder priorities to required content and allocates word
    budget.

2.  **Researcher (Optional Tool)**\
    Verifies key statistics and produces citation snippets.

3.  **Drafter**\
    Writes to the fixed template and enforces word limits.

4.  **Critic / QA**\
    Runs deterministic checks (see below) and produces a patch list.

5.  **Finalizer**\
    Applies patches and outputs:

    -   Final one-pager
    -   Assumptions list
    -   Open questions

------------------------------------------------------------------------

## 5. QA Validation Rules

The agent must verify:

-   Each funder priority is explicitly addressed.
-   Every outcome includes metric, baseline, and target.
-   Budget categories align with activities and duration.
-   Internal consistency across population size, geography, dates, and
    dollars.
-   At least one citation in the Need or Solution section.
-   Word count within 450-650 range.
-   Minimal vague language.

If any check fails, produce a structured QA report before final output.

------------------------------------------------------------------------

## 6. Project Brief Schema (Single Source of Truth)

All drafting must rely on a structured JSON brief:

``` json
{
  "funder": {
    "name": "",
    "program": "",
    "priorities": [],
    "max_award": 0,
    "duration_months": 0,
    "geography": "",
    "constraints": []
  },
  "applicant": {
    "org_name": "",
    "mission": "",
    "years_active": 0,
    "proof_points": [],
    "partners": []
  },
  "project": {
    "title": "",
    "problem": "",
    "population": "",
    "geography": "",
    "activities": [],
    "timeline": [],
    "risks": [],
    "sustainability": ""
  },
  "evidence": [
    { "claim": "", "source_url": "", "note": "" }
  ],
  "budget": {
    "request_total": 0,
    "match_total": 0,
    "categories": [
      { "name": "", "amount": 0, "justification": "" }
    ]
  },
  "evaluation": {
    "baseline": "",
    "targets": [
      { "metric": "", "baseline": "", "target": "", "method": "", "cadence": "" }
    ]
  }
}
```

------------------------------------------------------------------------

## 7. MVP Implementation Plan

1.  Build CLI tool that:
    -   Accepts `project_brief.json`
    -   Outputs:
        -   `one_pager.md`
        -   `qa_report.md`
2.  Add optional tools:
    -   Web citation verification
    -   Document export (Google Docs / PDF)
3.  Store artifacts:
    -   `inputs.json`
    -   `draft_v1.md`
    -   `qa_report.md`
    -   `final.md`

------------------------------------------------------------------------

## 8. Operational Constraints

-   Use the structured brief as the only source of truth.
-   Quote numbers directly from the brief; do not re-derive.
-   Ask for clarification when inputs are incomplete.
-   Never fabricate evidence, metrics, or organizational history.

## Output
Create new document in `./doc**s`.  Produce the requested documenation in the new document.  use markdown syntax unless otherwise specified
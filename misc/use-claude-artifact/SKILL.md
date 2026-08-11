---
name: use-claude-artifact
description: >
  When the user asks for HTML output for code review materials, explanations of plans or discussions,
  or design verification, create the HTML as a Claude artifact instead of a file in the repository.
  Use when the user says things like "create it as HTML", "as an artifact", "HTML for review",
  or "HTML for design check".
---

# Use Claude Artifact

When the user asks for HTML output for review materials, explanations, or design checks, create it as a Claude artifact — do not write a file into the repository.

## Procedure

1. Analyze the request (review materials / plan or discussion explanation / design check)
2. Create the HTML as an artifact

## Gotchas

- This skill only defines where the HTML goes. Follow artifact defaults or any style the user specifies
- Do not commit the HTML to the repository unless the user explicitly asks (it is almost always for temporary viewing)
- Even when asked to "create it as HTML", do not write a `.html` file into the workspace — always deliver it as an artifact

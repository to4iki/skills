---
name: implementation-notes
description: >
  Implement a spec while keeping a running implementation-notes.html with
  decisions, deviations, tradeoffs, and open questions. Use for
  /implementation-notes, @implementation-notes, implementation-notes.html,
  or when the user wants a spec implemented with a work log.
---

# Implementation Notes

Implement the spec and keep `implementation-notes.html` updated as you go so the user can follow how the implementation interprets, decides on, and diverges from the spec without reading every diff.

## Invocation

```
/implementation-notes <SPEC>
```

`<SPEC>` is what to implement — a file path, URL, issue/PR reference, or inline requirements in the same message.

If the user invokes the skill without `<SPEC>`, ask what to implement before coding.

## Notes file

- Default: `implementation-notes.html` at the project root (self-contained; no external assets).
- Purpose: leave a human-readable HTML file that lets the user review spec interpretation, implementation differences, and open questions.
- Capture anything the implementation diverges from, interprets, or adds to the spec as notes the user should know about.

Capture as you work — not only at the end — especially:

- Design decisions: choices you made where the spec was ambiguous
- Deviations: places where you intentionally departed from the spec, and why
- Tradeoffs: alternatives you considered and why you picked what you did
- Open questions: anything you'd want the user to confirm or revise
- Verification results (commands run and results)

Link to files; don't paste large code blocks.

## HTML usage

Do not make `implementation-notes.html` a plain text document wrapped in HTML. Use HTML, CSS, SVG, and JavaScript when they make the notes easier to review.

Read `references/html-output.md` when detailed representation patterns are useful.

## When done

Point the user to the notes file and call out open questions and verification results first.

## Gotchas

- Do not wait until the end to write notes; update continuously as decisions happen
- Do not dump large code blocks into the notes; link to paths instead

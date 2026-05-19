---
name: implementation-notes
description: >
  Implement a spec while keeping a running implementation-notes.html with
  decisions, deviations, tradeoffs, and open questions. Use for
  /implementation-notes, @implementation-notes, implementation-notes.html,
  or when the user wants a spec implemented with a work log.
---

# Implementation Notes

Implement the spec and keep `implementation-notes.html` updated as you go so the user can follow without reading every diff.

## Invocation

```
/implementation-notes <SPEC>
```

`<SPEC>` is what to implement — a file path, URL, issue/PR reference, or inline requirements in the same message.

If the user invokes the skill without `<SPEC>`, ask what to implement before coding.

## Notes file

- Default: `implementation-notes.html` at the project root (self-contained; no external assets).
- Use Markdown only if the user asks.

Capture as you work — not only at the end — especially:

- Design decisions (ambiguous spec)
- Deviations from spec (intentional, with why)
- Tradeoffs (alternatives and why you chose one)
- Unresolved questions (needs user input)

Link to files; don't paste large code blocks.

## When done

Point the user to the notes file and call out anything still open.

# HTML output guidance

Create `implementation-notes.html` as a human-readable HTML artifact, not just a work log. Use richer HTML only when it lowers the cost of reviewing spec interpretation, implementation differences, verification, and open questions.

## Representation patterns

- Use `<table>` for tabular information such as requirements, decisions, verification results, and risks.
- Use CSS to make design or state differences visible through spacing, hierarchy, comparison layouts, responsive behavior, and restrained color.
- Use SVG and HTML for workflows, dependencies, screen structure, and state transitions.
- Use `<pre><code>` for code snippets, and use `<script type="application/json">` or `<script type="text/plain">` when embedded examples or data should stay easy to inspect or reuse.
- Use HTML elements, CSS, and JavaScript for interactions that help review, such as comparisons, disclosures, filters, tabs, or copyable output.
- Use absolute positioning, canvas, or SVG for spatial data and layout exploration.
- Use `<img>` when images help understanding. Keep the HTML self-contained where practical; use relative paths or data URLs when assets are needed.

## Judgment

- Avoid complex UI that is only decorative.
- Choose the representation that makes spec differences, design decisions, open questions, and verification results easiest to review.
- Prefer a self-contained HTML file and keep external asset dependencies minimal.

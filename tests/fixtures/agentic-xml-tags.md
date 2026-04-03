# Agentic AI XML Tag Rendering

This file tests the custom XML tag styling used in agentic AI prompts and documentation.

---

## Basic Tags

<example>
This is an example block. It should have a green-tinted border and a label in the top-left corner.
</example>

<instructions>
These are instructions. They should render as a bordered block with a label.
</instructions>

<rule>
This is a rule block with a label.
</rule>

<context>
This provides context for a task or conversation.
</context>

<important>
This is marked as important. It should have a yellow/orange border tint.
</important>

---

## AI Conversation Tags

<system-prompt>
You are a helpful assistant that follows instructions carefully.
</system-prompt>

<user-prompt>
Please explain how Quick Look extensions work on macOS.
</user-prompt>

<assistant-response>
Quick Look extensions allow apps to provide rich previews of file types in Finder. They use the QLPreviewingController protocol.
</assistant-response>

---

## Tool Use Tags

<tool-use>
Running swift test in the MarkdownRenderer directory.
</tool-use>

<tool-result>
All 139 tests passed.
</tool-result>

---

## Thinking Tags

<thinking>
These blocks should render with a dashed border and slightly reduced opacity, indicating internal reasoning.
</thinking>

<reflection>
Reflection blocks also use dashed borders. They represent meta-cognitive processes.
</reflection>

<planning>
Planning blocks outline the approach before execution. Also dashed style.
</planning>

---

## Additional Tags

<constraints>
Must use Swift 5.9. Must target macOS 26.0. No CDN dependencies.
</constraints>

<guidelines>
Follow the coding standards in CONTRIBUTING.md. All changes need tests.
</guidelines>

<persona>
You are a senior macOS developer with expertise in Quick Look extensions and WKWebView.
</persona>

<task>
Implement GitHub-style alert rendering in the markdown post-processor.
</task>

<step>
Step 1: Parse blockquotes for alert markers. Step 2: Convert to styled div elements. Step 3: Add CSS for each alert type.
</step>

<output-format>
Return the rendered HTML as a string, ready for injection into the template.
</output-format>

<example-agent>
This is an example-agent block. It demonstrates agent behavior patterns.
</example-agent>

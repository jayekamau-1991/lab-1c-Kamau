## Basic Formatting Syntax[^1][^2]

***

# Heading 1 – Main Title

```markdown
# YOUR TEXT HERE
```

## Heading 2 – Section

```markdown
## YOUR TEXT HERE
```

### Heading 3 – Subsection

```markdown
### YOUR TEXT HERE
```

#### Heading 4 – Sub-subsection

```markdown
### YOUR TEXT HERE
```

##### Heading 5 – Minor Heading

```markdown
##### YOUR TEXT HERE
```

###### Heading 6 – Smallest Heading

```markdown
###### YOUR TEXT HERE
```

###### Bold

```markdown
**YOUR TEXT HERE**
```

Use bold for **important** words.

###### Italic

```markdown
*YOUR TEXT HERE*
```

Use italics *more* emphasis.

###### Bold and Italic

```markdown
***YOUR TEXT HERE***
```

Bold ***and*** italics together.

###### Strikethrough

```markdown
~~YOUR TEXT HERE~~
```

You can also ~~use~~ strikethrough words.

###### Subscript

```markdown
H<sub>2</sub>O
```

Renders as H<sub>2</sub>O

###### Superscript

```markdown
X<sup>2</sup>
```

Renders as X<sup>2</sup>

######

Underline

```markdown
<ins>YOUR TEXT HERE</ins>
```

Underline <ins>important</ins> concepts.

###### Highlight

```markdown
==YOUR TEXT HERE==
```

Highlight ==key words== like this.

###### Code Block

````markdown
Use triple back ticks for code in its own block. Specify a languge for sytax hilighting.
```python
x = "Hello, World!"
if x == "Hello, World!":
	print(x)
	print("Goodbye World.")
```
Note: Most Markdown rendererers (GitHub, Obsidian, VS Code, etc.,) support common languages for syntax hilighting.
`text`, `markdown`, `bash`, `sh`, `zsh`, `powershell`, `python`, `javascript`, `swift`, `html`, `css`, `json`, `yaml`, `dockerfile`, `terraform`, `toml`, `etc.`
````

###### Inline Link

```markdown
[YOUR TEXT HERE](URL LINK OR RELATIVE PATH)
```

[A link to Google.com](https://www.google.com/)

###### Linked Heading

```markdown
# This is my first linked heading

## Linked Heading 2

### Here's Another Linked Heading

# My last linked heading

YOUR TEXT HERE: [Link Text](#this-is-my-first-linked-heading)
YOUR TEXT HERE: [Link Text](#linked-heading-2)
YOUR TEXT HERE: [Link Text](#heres-another-linked-heading)
YOUR TEXT HERE: [Link Text](#my-last-linked-heading)

Note: Text in `()` must be all lowercase and should match the text in the heading. Keep in mind:
	- Spaces, dashes and punctuation must be replaced with `-`
	- Consecutive hyphens must be collapsed into a single `-`
```

[Jump to the Top of this Document](#heading-1-main-title)<br>
[Jump to References](#references)

###### Footnotes

```markdown
Sample text with a footnote[^1]
Another line with a footnote[^2]

<ins>Footnotes</ins>
[^1]: YOUR-REFERENCE-HERE
[^2]: YOUR-SECOND-REFERENCE-HERE
The same rules for lowercase, punctuation and spaces apply.
```

Sample text with a footnote[^1]<br>
Another line with a footnote[^2]

<ins>Footnotes</ins>
[^1]: YOUR-REFERENCE-HERE
[^2]: YOUR-SECOND-REFERENCE-HERE

###### Ordered List

```markdown
Use `1.`, `2.`, `3.` etc., to make ordered lists.
1. First Item
2. Second Item
3. Third Item
```

1. First Item
2. Second Item
3. Third Item

###### Callouts

```markdown
Note: Aliases usually render the same style of callout, but the icon may vary. Check your Markdown renderer (e.g., Obsidian, GitHub, MkDocs) to confirm which callout types are supported.

> [!NOTE]  
> YOUR TEXT HERE (Blue info box).

> [!INFO]  
> YOUR TEXT HERE (Alias of NOTE).

> [!TIP]  
> YOUR TEXT HERE (Green suggestion box).

> [!IMPORTANT]  
> YOUR TEXT HERE (Purple/blue highlight box).

> [!WARNING]  
> YOUR TEXT HERE (Yellow warning box).

> [!CAUTION]  
> YOUR TEXT HERE (Orange caution box).

> [!SUCCESS]  
> YOUR TEXT HERE (Green check box).

> [!QUESTION]  
> YOUR TEXT HERE (Teal Q&A box).

> [!QUOTE]  
> YOUR TEXT HERE (Styled blockquote).

> [!ABSTRACT]  
> YOUR TEXT HERE (Collapsible summary style).

> [!SUMMARY]  
> YOUR TEXT HERE (Alias of ABSTRACT).

> [!TLDR]  
> YOUR TEXT HERE (Alias of ABSTRACT).

> [!BUG]  
> YOUR TEXT HERE (Red bug report box).

> [!EXAMPLE]  
> YOUR TEXT HERE (Light gray example box).

> [!FAILURE]  
> YOUR TEXT HERE (Red box).

> [!ERROR]  
> YOUR TEXT HERE (Alias of FAILURE).

> [!DANGER]  
> YOUR TEXT HERE (Alias of FAILURE).
```

> [!NOTE]<br>
> ***Everything*** in Linux is case sensitive. This includes commands.

> [!TIP]<br>
> Navigate quickly to home the directory with `cd`.

> [!BUG]<br>
> Keep your software up to date to install patches and fix known bugs.

> [!WARNING]<br>
> The `rm -f` command forces the action, and suppresses confirmation prompts. Only use if you know what you're doing, and use with caution.

###### Nested List

```markdown
You can create a nested list by indenting one or more list items below another item
1. First Item
	- Sub Item 1
2. Second Item
	- Sub Item 2
3. Third Item
   - Sub Item 3
```

1. First Item
	- Sub Item 1
2. Second Item
	- Sub Item 2
3. Third Item
   - Sub Item 3

###### Task List

```markdown
Start a list item with `-[ ]` to create a task list. Use `[x]` to mark tasks as complete.
- [x] Update the firmware.
- [ ] Optimize Jenkins deployment.
- [ ] Process SQS DLQ.
```

- [x] Update the firmware.
- [ ] Optimize Jenkins deployment.
- [ ] Process SQS DLQ.

###### Emojis

```markdown
The simplest way to use emojis in Markdown is to insert them directly.

###### My Notes
🐳 Docker  
☸️ Kubernetes  
☁️ AWS / GCP  
🔐 Security

Note: Use the default emoji library in your OS, or use an emoji dictionary like https://emojihub.org to quickly copy and paste.
```

###### My Notes

🐳 Docker<br>
☸️ Kubernetes<br>
☁️ AWS / GCP<br>
🔐 Security

###### Block Quote

```markdown
> QUOTE
— Author

Note: Use an en dash, not a regular dash.
```

> There’s always a solution for every obstacle. Go find it.<br>
— Master Roshi (Dragon Ball)

###### Comment

```markdown
<!-- COMMENT -->

Note: Comments are hidden from the output, but can be seen in the editor.
```

<!-- This information is hidden -->

###### Images

```markdown
![ALT TEXT or DESCRIPTION](IMAGE-URL OR RELATIVE PATH)

Note: `ALT TEXT or DESCRIPTION` appears if the image can't load. Also helps screen readers for accessiblity.
```

![Mini Goku - Super Saiyan 4](https://static.wikia.nocookie.net/dragonball/images/9/94/SSJ4_Mini_Goku_character_sheet_by_Akira_Toriyama.png/revision/latest/scale-to-width-down/1000?cb=20250224231206)

###### HTML Images (more control)

```html
Scaled width: Adjusts based on container size, maxes at X%. Balanced method that's good for adapting to different devices.
<img src="IMAGE-URL OR RELATIVE PATH" alt="ALT TEXT or DESCRIPTION" width="X%">

Fixed width: Always shows the image at Xpx wide.
<img src="IMAGE-URL OR RELATIVE PATH" alt="ALT TEXT or DESCRIPTION" width="X">
```

<img src="https://static.wikia.nocookie.net/dragonball/images/9/94/SSJ4_Mini_Goku_character_sheet_by_Akira_Toriyama.png/revision/latest/scale-to-width-down/1000?cb=20250224231206" alt="Mini Goku - Super Saiyan 4 Scaled 50%" width="50%">

###### Collapsable Sections

```markdown
<details>
<summary>YOUR COLLAPSABLE SECTION</summary>

YOUR TEXT GOES HERE

</details>

Note: Change `</details>` to `</details open>` to make the section display as open by default.

```text

<details>
<summary>This text is collapsable</summary>

It contains long form information and can also support lists and tables. <br>
Additional lines can be added by using line breaks.

</details>

###### Tables[^3]
```markdown
| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

Note: You can create tables manually, but it's easier to copy and paste directly from markdown. If you use an editor like Obsidian, once the table renders, you can right click to quickly format, add/remove rows, and sort.
```

**Goku's World Martial Arts Tournament Record**

| Tournament              | Opponent                   | Result |
| ----------------------- | -------------------------- | ------ |
| 21st World Martial Arts | Jackie Chun (Master Roshi) | ❌ Loss |
| 22nd World Martial Arts | Tien Shinhan               | ❌ Loss |
| 23rd World Martial Arts | Piccolo Jr.                | ✅ Win  |

----

## <ins>References</ins>

[^1]: <https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax>

[^2]: <https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax>

[^3]: <https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-tables>

For more markdown resources and help writing on GitHub view: <https://docs.github.com/en/get-started/writing-on-github>

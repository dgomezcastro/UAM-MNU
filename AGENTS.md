# Notes for agents working in this repository

## Use the Oxford comma

In a list of three or more items, put a comma before the final "and" or "or":
write "Céa, Aubin--Nitsche, and Strang", not "Céa, Aubin--Nitsche and Strang".
This applies to everything you write in the repository: the lecture notes, the slides, the README, and the comments.

## LaTeX sources are formatted with latexindent

The author writes in an editor (LaTeX Workshop) that runs `latexindent` on every save.
A `.tex` file that is not in latexindent's format is rewritten the next time the author saves it,
and the diff of that save mixes whitespace noise with the real change.

**Rule: after editing a `.tex` file, format it with latexindent, with the same settings as the editor,
so that a further run changes nothing.**

### How to run it

The editor uses latexindent's default settings (there is no `latexindent.yaml` or `localSettings.yaml`
in the repository) and passes the indentation of the file being saved:

```sh
latexindent -s -wd -c "${TMPDIR:-/tmp}/" -y="defaultIndent: '    '" path/to/file.tex
```

- `-wd` overwrites the file only if the result is different.
- `-c` sends the backup (`.bak0`) and `indent.log` to a temporary directory instead of the repository.
- `defaultIndent` must be the indentation the file already has: four spaces everywhere,
  except `slides/slides.tex` and `slides/galerkin/session03.tex`, which use two.
- Do not add `-m` or any other setting: the result would differ from what the editor produces.
- `latexindent` comes with TeX Live. If it is not on the `PATH`, it is in the same directory as `latexmk`.

### What it changes

Only whitespace:

- the body of every environment, of `\[ ... \]`, and of multi-line `{...}` and `[...]` groups
  is indented one level;
- the continuation lines of an `\item` are indented six spaces, so that they start under the text of the item;
- in `tabular`, `align`, `cases`, `pmatrix`, and similar environments, the `&` and the `\\`
  are aligned in columns.

It does not rewrap text and does not move line breaks, so the lines of a paragraph can be broken freely.

### In practice

- Do not align or indent by hand in a different way: it will be undone at the next save.
- Format the files you edit, not the whole repository.
- A few files were written without latexindent and are not in its format yet.
  If you edit one of them, formatting also changes lines you did not touch.
  That is expected: keep those changes, and say so when you report.
- Check before finishing:
    - a second run of the command above leaves the file unchanged;
    - `git diff -w` shows only the changes you meant to make;
    - `mnu.pdf` or `slides/slides.pdf` builds as before (formatting must not change the output).

## Check the line breaks in the PDF

After adding or changing text, build the PDF and do a pass over the pages you touched,
looking for awkward line breaks. Do it before reporting that the work is finished.

**This is especially important in the slides.** They are projected in class, every line is read by the audience,
and beamer sets the text ragged-right and without hyphenation, so each line breaks wherever it happens to be full.
After any change to a slide, check that slide, and check every slide of a session you have written or rewritten.

In the lecture notes the text is justified and hyphenated, and the problem is rarer,
but look at the pages you changed all the same.

### What to look for

- a single word, or a short tail, alone on the last line of a paragraph, a bullet, or a `\takeaway`;
- a parenthesis split in two, such as "(mean value / theorem)";
- a break right after a word that introduces what follows: "if / and only if", "So / *formula*", "Session / 10";
- a short formula or a reference separated from the words it belongs to;
- a two-line `\takeaway` with lines of very different length.

### How to fix them

- `\\` to break at a natural place: after a sentence, a colon, or a comma, or before "and", "but", or "then";
- `~` or `\mbox{...}` to keep a few words, or a short formula with its words, on the same line.

Do not reword the author's text, and do not change the style or the template, to fix a line break.
If a break cannot be fixed without rewording, or without adding a line to a slide that is already full,
leave it and say so when you report.

latexindent keeps these breaks: it does not remove or move a `\\`.

### Check again after fixing

- Read the slides you changed as images, not only as source,
  for example with `pdftoppm -r 100 -png -f N -l N slides/slides.pdf out`.
- The log must have no new `Overfull` warnings. A forced break can add a line to a slide that was already full,
  and a longer line just before a displayed formula increases the space above the formula.
  The slides currently build with no warnings at all: keep it that way.

## Slides: boxes that start with a formula

When the body of a box (`theorem`, `lemma`, `definition`, `example`, `remark`, or `proofsteps`)
starts with a displayed formula, look at the space between the title of the box and the formula.

- A formula in `\[ ... \]` that is clearly narrower than the box sits right under the title. That is the intended look.
- A formula almost as wide as the box, or an `align*`, is set with a much larger gap above it.
  Start the body with `\vspace{-\abovedisplayskip}` to remove it:

```latex
\begin{definition}[Fourier coefficients and truncation]
    \vspace{-\abovedisplayskip}
    \[
        ...
    \]
\end{definition}
```

Do not add it to a box that already looks right: the formula would move up into the title.

# Regex Parser?

This is all based on [Russ Cox' paper about fast-matching regular
expressions](http://swtch.com/~rsc/regexp/regexp1.html). It's a neat
paper, you should check it out.

# What's it do so far?

Read the code, there's not much of it. But the idea is, you hand-roll
a deterministic finite automata (see the Node class), and it has
methods for matching a string (returns a boolean), and generating
sample strings (by walking the finite automata).

# TODO

1. It's all in one file right now. Break it out into files.
1. Add some minitests.
1. Implement a pattern parser & builder.
1. Add non-literals to the patterns, so things like @.@, @[0-9]@, and @\d@ work.
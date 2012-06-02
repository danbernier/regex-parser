# Regex Parser?

This is all based on [Russ Cox' paper about fast-matching regular
expressions](http://swtch.com/~rsc/regexp/regexp1.html). It's a neat
paper, you should check it out.

## So Ruby regexes are slow?

Look in the notes folder to see my evidence. It seems to bear out Russ
Cox' point. So yes, it seems that in ruby, these kind of regexes are
slow.

# What's the goal?

It's all about playing with the ideas. There's no practical, useful
plan. If that happens, that's awesome, but it'll be later.

# What's it do so far?

Read the code, there's not much of it. But the idea is, you hand-roll
a deterministic finite automata (see the Node class), and it has
methods for matching a string (returns a boolean), and generating
sample strings (by walking the finite automata).

# TODO

1. Implement a pattern parser & builder.
1. Add non-literals to the patterns, so things like *.*, *[0-9]*, and *\d* work.
1. Right now, it's only deterministic FAs. To match the paper, it
   really needs to be non-deterministic, so I have to stop using a hash,
   or something.
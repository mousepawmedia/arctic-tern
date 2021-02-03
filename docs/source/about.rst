About Trilean
===================================

A trilean is an atomic data type with three distinct states: "true", "maybe",
and "false". It is designed to behave like a boolean, but with the
additional feature of "uncertainty."

In order to understand trilean, one must remember that "true" and "false"
are *certain* states, entirely distinct from and un-equivalent to "maybe".
All of trilean's behavior is based around this rule.

Why Use Trilean?
----------------------------------

The logic of trilean has historically been achieved in C++ using either
an enumeration or a pair of booleans. However, trilean offers a couple of
distinct advantages:

* A trilean variable is exactly one byte in size.
* All three states can be represented in a single variable.
* Trilean is fully compatible with boolean and its constants.
* Conditional logic with trilean is simpler and cleaner.

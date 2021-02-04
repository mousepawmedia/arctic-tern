Certainty
###############################

Because trilean stores its data in two bits, it is possible for a variable
to track its last certain state. In other words, if a trilean is "true" or
"false," and then is set to "maybe", that true/false value is still being
stored behind the scenes.

To make this useful, trilean offers a ``certain()`` function, which returns
the last certain state of the variable without actually modifying itself.

..  code-block:: c++

    tril foo = true;
    foo = maybe;

    bool bar = foo.certain();

    // bar is now 'true', while foo is still 'maybe'

This behavior can also be used to revert a trilean to its last certain state.

..  code-block:: c++

    tril foo = true;
    foo = maybe;
    foo = foo.certain();

    // foo is now 'true'

Implications
===================================

The concept of "certainty" technically allows one to recognize and use four
trilean states:

* Certain true (``if( foo )``)
* Uncertain true (``if( ~foo && foo.certain() )``)
* Uncertain false (``if (~foo && !foo.certain() )``)
* Certain false (``if (!foo)``)

Uncertainty Variables
===================================

The "magical" behavior of assigning the constant "maybe" not affecting the
previous certain state is achieved through "uncertainty" variables. Any time an
uncertainty is assigned to a trilean, only the uncertainty of the trilean
is affected.

The constant "maybe" is usually the only uncertainty object you will interact
with. However, it is possible to create your own ``certainty``. Be aware that
this data type does not provide any mechanism for modifying it after creation.

..  code-block:: c++

    uncertainty my_maybe(true);
    uncertainty my_certain(false);

As is expected, an uncertainty can never match "true" or "false", or be
directly cast to a boolean. However, the ``~`` operator works as with trileans.

..  code-block:: c++

    if(~my_maybe)
        // This passes.

    if(~my_certain)
        // This fails.

    if(~my_certain == false)
        // This passes.

The usefulness of an uncertainty variable is, quite probably, limited to
allowing manipulation of a trilean's certainty.

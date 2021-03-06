Using Trilean
###################################

Including Trilean
===================================

To include Trilean, use the following:

..  code-block:: c++

    #include "arctic-tern/tril.hpp"

"Maybe" Constant
===================================

Along with the normal ``true`` and ``false`` constants provided by C++,
trilean offers a ``maybe`` constant. This new constant is designed to
be distinct from ``true`` and ``false``, yet usable in the same manner
for trileans.

Defining and Assigning
===================================

Defining a new trilean variable is simple.

..  code-block:: c++

    tril foo = true;
    tril bar = maybe
    tril baz = false;

In addition to the three constants, you can assign other booleans and trileans.

..  code-block:: c++

    bool foo = true;
    tril bar = foo;
    tril baz = bar;

    // foo, bar, and baz are all 'true'

Conditionals
===================================

Obviously, one can compare a trilean against of its state constants
directly.

..  code-block:: c++

    tril foo = maybe;

    if(foo == true)
        // code if TRUE...
    else if(foo == maybe)
        // code if MAYBE...
    else if(foo == false)
        // code if FALSE...

However, one can also test a trilean in the same manner as a boolean.

..  code-block:: c++

    tril foo = maybe;

    if(foo)
        // code if TRUE...
    else if(~foo)
        // code if MAYBE...
    else if(!foo)
        // code if FALSE...

You will notice that, in addition to the familiar tests for "true"
(``if(foo)``) and "false" (``if(!foo)``), trilean has a third unary
operator, ``~``, for "maybe" (``if(~foo)``).

..  important:: Remember, neither the "true" or "false" conditions will ever
    match "maybe".

This basic behavior is what makes trilean so useful. For example, you may want
to repeat a block of code until you encounter specific scenarios to cause it
to either pass or fail, using something like ``while(~foo)``.

Comparisons
===================================

Trilean can be compared to booleans and other trileans using the ``==`` and
``!=`` operators.

..  code-block:: c++

    tril foo = true;
    tril bar = maybe;
    bool baz = true;

    if(foo == bar)
        // This fails.

    if(foo != bar)
        // This passes.

    if(foo == baz)
        // This passes.

    if(baz == foo)
        // This passes.

    if(baz == bar)
        // This fails.

Switch
===================================

The idea of allowing a trilean to cast to an integer was discussed and
debated in great deal. Finally, the decision was made to prevent casting
a trilean to anything but a boolean (discussed later).

This means that trileans **are not compatible with switch statements**.
While this may be initially disappointing to anyone used to using an
enumeration for three-state logic, one will notice that an if-statement covering
all three states of a trilean has at least 4 less lines of boilerplate.

..  code-block:: c++

    tril foo;

    /* This code demonstrates an if statement covering all three states
     * of a trilean. */

    if(foo)
    {
        // Some code.
    }
    else if(~foo)
    {
        // Some code.
    }
    else if(!foo)
    {
        // Some code.
    }


Gotchas
==================================

Casting to Bool
----------------------------------

In order to preserve the core logic that "maybe != true" in statements like
``if(foo)``, casting a trilean to a boolean causes "maybe" to be converted to
"false".

..  code-block:: c++

    tril foo = maybe;
    bool bar = foo;

    // bar is now 'false'

In most cases, it is recommended to use the ``certain()`` function.

..  note:: In case you were wondering, we ensured that "maybe != false" in comparisons
    and conditionals by separately overloading the ``!``, ``!=``, and ``==``
    operators.

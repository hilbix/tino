# C

Things I want to remember about C

## KNR

KNR-C is the original C standard.  It has a bit of different syntax compared to ANSI-C:

- T.B.D.

## C89 aka. C90 aka. ANSI-C

This is the standard this document is based on.   Everything else is compared in contrast to ANSI-C.

Principles (in this sequence):

- TABstops are on 8, else you must use spaces instead.
- Don't be a Nazi
- Keep things together which belong together
- KISS (Keep it stupid simple)
- DRY (Don't repeat yourself)

This means:

- TABs are on 8.  There is no way to escape that fact.  Ever.  For now and all possible future.  Period!
- Parantheses and Braces which belong together are kept on the same column or row, if possible
- You can collapse multiple closing parantheses and braces on one line
  - I know of no editor, which is able to understand that.  All unfold that when re-indenting.  Sigh.
- This also is for code blocks.  Things which can be grouped thus should be grouped in the source, too.
- Most functions should not spread more than a screenful, so they are easy to understand.
- Use descriptive names.  Use of short names as `a`, `i`, `*p`, etc. is encouraged.
- `use_underscores_in_names`.  UseCamelCaseOnlySparingly
- Uppercase is for `#define`s or `special_flags_in_name_PTR`
- use `void` instead of nothing, so you know, it was not forgotten
- Relax.  You can sacrifice everything if it makes things more readable.
  - Hence TAB=8, as any source using another TAB setting instantly becomes completely unreadable garbage.
- Try indenting continuation line marker (`\`) onto the same column.
  - Use TABs to separate it from the rest of the code
  - Luckily ~~`vim`~~ `emacs` exactly does so.
- Try to render table like data as TAB separated tables
- Format control flow differently, so it is better readable

Use of parantheses and braces:

	if (short_condition) { short_things; }
	if (condition)
	  {
	    things;
	  }
	if (first_condition
	    || second_condition
	    || third_condition
	   )
	  {
	    things;
	  }
	if (first_condition
	    || second_condition
	    || third_condition)		/* relaxed, as above looks plain shit	*/
	  {
	    things;
	  }
	if ((very_long_condition	/* Avoid if possible	*/
	     broken up in several
	     lines
	   ))
	  {
	    things;
	  }
	do
	  {
	    things;
	  } while (condition);
	 while (condition)
	  {
	    things;
	  }

However [control flow](https://stackoverflow.com/a/47574378/490291) should look different:

	TRY {
	  things;
	} CATCH (first) {
	  catch;
	} CATCH (second) {
	  catch2;
	} FINALLY {
	  block;
	} END

Notes:

- Above is pseudo code.  I never found a usable implementation of this for pure ANSI-C.
- [Guards are a far better way to do it](https://github.com/CppCon/CppCon2015/blob/master/Presentations/Declarative%20Control%20Flow/Declarative%20Control%20Flow%20-%20Andrei%20Alexandrescu%20-%20CppCon%202015.pdf)

Formatting of functions:

	returnvalue
	name(arguments)
	{
	  /* indented code */
	}

Formatting of complex data types:

	struct name
	  {
	    char	*str;
	    int		component;
	    union
	      {
		void	*v;
		int	a;
	      };
	  } names[] =
	  {
	    { "1",	1, NULL },
	    { "one",	1, NULL },
	    { "2",	2, function_2 },
	    { "two",	2, function_2 },
	    { 0 }
	  };


## C99

T.B.D.

## C11

T.B.D.

## C18

T.B.D.


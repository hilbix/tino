#!/usr/bin/env python3
#
# Example for transparent byte to string conversion.
# Of course, each newly born baby knows this, right?
#
# Not?  Well, then why don't they tell this at the first place?
#
# Strings are internally kept as UTF-8.  But bytes can contain non-UTF8-sequences.
# Hence you cannot decode them with 'UTF-8' as nearly all examples consider!
#
# The only correct transparent conversion of byte to string is into UNICODE Plane 0!
# But nobody tells you how to do this.
#
# Here it is, it is as simple as to use the 'ISO-8859-1' encoding.
#
# ONLY USE THIS FOR TRANSPARENT PROCESSINGS.
# If you need to interact (like with JSON), the default UTF-8 is your friend!

# Create a byte array with all possible values

b = bytearray()

for i in range(0,256):
	b.append(i)

# Convert BYTE to STRING, transparently:

a	= b.decode('iso-8859-1')

for i in range(0,256):
	if ord(a[i])!=i:
		raise f"wrong at {i}"

# Convert back STRING to BYTE, transparently:

c	= a.encode('iso-8859-1')

for i in range(0,256):
	if b[i] != c[i]:
		raise f"wrong encode/decode at {i}"

# Note
#
# This works HERE.  This also works if you need to stuff byte blobs into strings,
# for example to later encode it using JSON.
#
# But if you are sure the input already is UTF-8,
# then this fails, as it does not re-creates the codepoints,
# it, instead, creates the UTF-8 encoding byte for byte.
#
# Also the other way round is true.  If the string contains UTF-8,
# that is character oridnals above 255, then the conversion to bytes fails!
# But this is correct, as a byte only can encode values 0..255, but not above!
#
# So strings in Python are best converted natively (str.encode() with no arguments)
# into bytes.  Except when they are meant to transport a transparent buffer!


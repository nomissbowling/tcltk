*****************************************************************
TclExcept v2.0: Tcl-only exception handling and assertion package
*****************************************************************

INTRODUCTION

TclExcept is a Tcl package that provides C++ and Java-like exception handling, 
and assertions inside Tcl script. Since it is a Tcl-only extension, no 
compilation is required, and it should work with Tcl version 7.6 or newer and on 
any platform. The source file is 9kB. It has been tested on Tcl7.6, Tcl8.0.5 and 
Tcl8.2.2 on Windows95/NT and SunOS platforms.


WHERE TO GET TCLEXCEPT

	Home Page:
	http://www.purl.org/net/bonnet/Tcl/TclExcept/index.htm

	Distribution files:
	http://www.purl.org/net/bonnet/pub/TclExcept20.zip (sources)


INSTALLATION

Unpack the archive in the lib subdirectory of your Tcl distribution. To use it, 
just type:

	package require TclExcept

in every script that needs it, or in interactive mode.


DOCUMENTATION

The directory "doc" contains the documentation for TclExcept, in HTML format.


FUTURE

If I find some time, I'd like to package TclExcept so that it can be included in 
tcllib, the standard Tcl library provided with the core distribution.


CONTACT, COMMENTS, BUGS, etc.

* Please read the license (file license.txt), and especially the
  "beerware clause" ;-)
* Please send any bugs or comments to <frederic.bonnet@ciril.fr>. Bug
  reports and user feedback are the only way I intend to improve and
  correct TclExcept. If no one uses TclExcept, I see no reason why I should
  improve this extension except for my own use (for which TclExcept is more
  than adequate for now).
* Even if you have no comment, I'd appreciate that every TclExcept user
  send me a mail to the address mentioned above. That gives me
  information about the number of users which is an important part of my
  motivation. I won't use your address to send you unsollicited email,
  spam, or sell it to telemarketers, but only to keep track of users.
* If you find a bug, a short piece of Tcl that exercises it would be
  very useful, or even better, compile with debugging and specify where it
  crashed in that short piece of Tcl.

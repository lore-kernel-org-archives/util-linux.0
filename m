Return-Path: elseifthen@gmx.com
Subject: [PATCH] Docs: update howto-usage-function.txt
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c474adfe-dfcf-e767-842d-189cfc411a04@gmx.com>
Date: Sun, 23 Jul 2017 10:03:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
The following changes since commit aaf133265f9403801931b44c2ea29783f22eb374:

  libblkid: add HPE extended-XFS to known filesystems (2017-07-20 10:12:21 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170721

for you to fetch changes up to 930f62c658b7cbe5d1da6b36bdc3dd897d592ce3:

  Docs: update howto-usage-function.txt (2017-07-23 08:08:09 -0400)

----------------------------------------------------------------
J William Piggott (1):
      Docs: update howto-usage-function.txt

 Documentation/howto-usage-function.txt | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index a666d44..c108bfc 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -10,7 +10,7 @@ How a usage text is supposed to look
 
 The usage() output format is: Usage section, command description one-liner,
 Options section (see below), special sections like 'Available columns', and
-the last line is either the man page reference or and empty line. The output
+the last line is either the man page reference or an empty line. The output
 begins with, and each of the above are separated by, one empty line.
 
 The Usage section contains the synopsis line that describes how to compose
@@ -27,7 +27,7 @@ three consecutive dots means the unlimited repetition of the preceding.
 
 The short option is always written first, followed by the long option.  They
 are separated with a comma and one space.  Lonely short or long options do
-not affect where the writing of the option begins.
+not affect their alignment. That is, they must be in their respective column.
 
 Below, in between the snips, is an example of what the usage output should
 look like.
@@ -71,9 +71,7 @@ you need a longer description, use multiple lines and indentation.
 The description text begins from the point of the longest option plus two
 spaces. If adding a new option would necessitate a re-indentation of the
 descriptions, it either has to be done, or the new option should begin its
-description on the next line.  Usually the later is better. The --help and
---version options do not follow this rule, since they are defined as
-constants to ease translation work.
+description on the next line.  Usually the later is better.
 
 An argument is preferably worded appropriately.  For example, if an option
 expects a number as argument, '<num>' is a suitable argument indicator.
@@ -85,26 +83,28 @@ The order of the options has no special meaning, with the exception of
 Usage function
 --------------
 
-The standard usage() function takes either stderr or stdout as an argument.
-The argument will determine whether the program will exit with an error or
-with success.  The usage() function will never return.
+The usage() function will never return. It must only be called by -h/--help.
+All other cases use errtryhelp(EXIT_FAILURE).
 
 Section headers, man page, version, help, and other components of usage()
 have string constants defined in 'include/c.h' which must be used. See the
-example file listed at the top of this document.
+example file listed at the top of this document. The help and version options
+are combined into a single macro which takes an argument for the column that
+their descriptions will begin on: USAGE_HELP_OPTIONS(<num>).  This allows
+them to align properly with the other options.
 
-In the code all the strings with options have to start at the same position.
+In the code, all option strings must start at the same position.
 See here what this means:
 
-	fprintf(out, _(" -x[=<foo>]  default foo is %s"), x);
-	fputs(       _(" -y          some text"), out);
+	printf(out, _(" -x[=<foo>]  default foo is %s"), x);
+	puts(       _(" -y          some text"), out);
 
 Be nice to translators.  One gettext entry should be one option, no more,
 no less.  For example:
 
-	fputs(_(" --you-there  be nice\n"), out);
-	fputs(_(" -2 <whom>    translators\n"), out);
-	fputs(_(" -t, --hey    are doing a job that we probably cannot,"
+	puts(_(" --you-there  be nice\n"), out);
+	puts(_(" -2 <whom>    translators\n"), out);
+	puts(_(" -t, --hey    are doing a job that we probably cannot,"
 		"                or how is your klingon?\n"), out);
 
 When existing usage output is changed, and it happens to be one big text,

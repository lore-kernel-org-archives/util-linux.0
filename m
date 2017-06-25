Return-Path: elseifthen@gmx.com
Subject: [PATCH 3/4] Docs: update howto-usage-function.txt
To: Karel Zak <kzak@redhat.com>
References: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a6d94d92-ce85-da3e-dddd-88f530d8bb8a@gmx.com>
Date: Sun, 25 Jun 2017 17:50:20 -0400
MIME-Version: 1.0
In-Reply-To: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/howto-usage-function.txt | 75 ++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index 3496b49..1c5c4b8 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -1,3 +1,9 @@
+
+Example file
+------------
+
+Refer to the ./boilerplate.c example file while reading this howto.
+
 Well-known options
 ------------------
 
@@ -16,19 +22,22 @@ See Legacy options below.
 How a usage text is supposed to look
 ------------------------------------
 
-The usage output begins with an empty line, followed by 'Usage:', and
-then the synopsis on the line after that.  The synopsis and option-
-description lines are all indented by one space (0x40).
+The usage() output format is: Usage section, command description one-liner,
+Options section (see below), special sections like 'Available columns', and
+the last line is either the man page reference or and empty line. The output
+begins with, and each of the above are separated by, one empty line.
+
+The Usage section contains the synopsis line that describes how to compose
+the command. Sometimes you may need multiple synopsis lines (see below).
 
-The synopsis line describes how to compose the command.  Sometimes you
-may need multiple synopsis lines -- this is documented separately in the
-Synopsis section.
+Only the synopsis and option lines are indented. Indent is one space (0x40).
+Option lines do not use line-ending punctuation. Other sentences do.
 
-Notations.  Diamond brackets are used to mark an argument to be filled in.
-Square brackets are used to mark anything that is optional, such as optional
-command arguments, or optional option arguments.  In the later case the '='
-character is needed in front of the option argument, because one has to use
-it.  Three consecutive dots mean the unlimited repetition of the preceding.
+Notations: diamond brackets are used to mark an argument to be filled in;
+square brackets are used to mark anything that is optional, such as optional
+command arguments, or optional option arguments. In the later case the '='
+character is required in between the option and argument with no whitespace;
+three consecutive dots means the unlimited repetition of the preceding.
 
 The short option is always written first, followed by the long option.  They
 are separated with a comma and one space.  Lonely short or long options do
@@ -63,22 +72,21 @@ Options:
 For more details see program(1).
 -- snip
 
-Note that there are usage-function definitions in the 'c.h' include file
-which you must use.  The location of an example file is mentioned at the
-end of this text.
-
 
 Option descriptions
 -------------------
 
+This information also applies to other option-like arguments. That is,
+arguments starting with '-'. Such as: functions, commands, and so forth.
+
 An option description should not exceed the width of 80 characters.  If
 you need a longer description, use multiple lines and indentation.
 
 The description text begins from the point of the longest option plus two
-spaces.  In case adding a new option would necessitate a re-indentation of
-the descriptions, it either has to be done, or the new option should begin
-its description on the next line.  Usually the later is better.  The --help
-and --version options do not follow this rule, since they are defined as
+spaces. If adding a new option would necessitate a re-indentation of the
+descriptions, it either has to be done, or the new option should begin its
+description on the next line.  Usually the later is better. The --help and
+--version options do not follow this rule, since they are defined as
 constants to ease translation work.
 
 An argument is preferably worded appropriately.  For example, if an option
@@ -87,10 +95,6 @@ expects a number as argument, '<num>' is a suitable argument indicator.
 The order of the options has no special meaning, with the exception of
 --help and --version which are expected to be last ones in the list.
 
-The last line of the usage text is either empty, or a message informing
-about the manual page.  For example: 'For more details see example(1).'.
-Between the options and the man-page message there is an empty line.
-
 
 Usage function
 --------------
@@ -99,6 +103,10 @@ The standard usage() function takes either stderr or stdout as an argument.
 The argument will determine whether the program will exit with an error or
 with success.  The usage() function will never return.
 
+Section headers, man page, version, help, and other components of usage()
+have string constants defined in 'include/c.h' which must be used. See the
+example file listed at the top of this document.
+
 In the code all the strings with options have to start at the same position.
 See here what this means:
 
@@ -114,17 +122,17 @@ no less.  For example:
 		"                or how is your klingon?\n"), out);
 
 When existing usage output is changed, and it happens to be one big text,
-split it into chunks the size of one option.  The extra work this will
-entail for translators will pay off later, at the time of the next change,
-when they will not need to search in the long fuzzy text what was changed,
-where, how, and whether it was the only change.
+split it into chunks the size of one option. The extra work this will entail
+for translators will pay off later; the next string change will not force a
+search of the long fuzzy text for what was changed, where, how, and whether
+it was the only change.
 
 
 Synopsis
 --------
 
 You may need to use multiple synopsis lines to show that a command does
-fundamentally different things depending on options and/or arguments.
+fundamentally different things depending on the options and/or arguments.
 For example, ionice either changes the priority of a running command, or
 executes a program with a defined priority.  Therefore it is reasonable
 to have two synopsis lines:
@@ -133,9 +141,9 @@ to have two synopsis lines:
  ionice [options] <command> [<arg> ...]
 
 Note that the synopsis is not meant to be a repetition of the options
-segment.  The fundamental difference in execution is a bit difficult to
-define other than that usually the command author, package maintainer
-or patch submitter will know when it should be done that way.
+section. The fundamental difference in execution is a bit difficult to
+define. The command author, package maintainer or patch submitter will
+usually know when it should be done that way.
 
 
 Legacy options
@@ -152,8 +160,3 @@ additions.  A short list of examples:
   option resulting in a suggestion to try --help due to a getopt failure.
 
 
-Example file
-------------
-
-The file ./boilerplate.c is a minimal example of how to write
-a usage function, set up option parsing, version printing and so on.

Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/4] Docs: move option naming to howto-contribute.txt
To: Karel Zak <kzak@redhat.com>
References: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <5dbba0e9-b262-00db-3863-e4d71f68b2e6@gmx.com>
Date: Sun, 25 Jun 2017 17:51:49 -0400
MIME-Version: 1.0
In-Reply-To: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Creating and naming options is not done when writing usage().
A contributor may not even read howto-usage-function.txt, but
they should read howto-contribute.txt. So move option naming
and change information there.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/howto-contribute.txt     | 25 +++++++++++++++++++++++++
 Documentation/howto-usage-function.txt | 28 ----------------------------
 2 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index 245f9ab..e63d390 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -3,6 +3,7 @@ CONTENTS
  Patching Process
  Email Format
  Coding Style
+ Options
  Various Notes
  Standards Compliance
 
@@ -155,6 +156,30 @@ Coding Style
 	  multiple lines. In case the shorthand does not look good on one line
 	  use the normal "if () else" syntax.
 
+Options
+
+	* The rule of thumb for options is that once they exist, you may not
+	  change them, nor change how they work, nor remove them.
+
+	* The following options are well-known, and should not be used for any
+	  other purpose:
+
+		-h, --help     display usage and exit
+		-V, --version  display version and exit
+
+	* Some commands use peculiar options and arguments. These will continue
+	  to be supported, but anything like them will not be accepted as new
+	  additions. A short list of examples:
+
+		Characters other than '-' to start an option. See '+' in 'more'.
+
+		Using a number as an option. See '-<number>' in 'more'.
+
+		Long options that start with a single '-'. See 'setterm'.
+
+		'-?' is not a synonym for '--help', but is an unknown option
+		resulting in a suggestion to try --help due to a getopt failure.
+
 Various Notes
 
 	* util-linux does not use kernel headers for file system super
diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index 1c5c4b8..a666d44 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -4,20 +4,6 @@ Example file
 
 Refer to the ./boilerplate.c example file while reading this howto.
 
-Well-known options
-------------------
-
-The following options are well-known, and should not be used for any
-other purpose:
-
- -h, --help     display usage and exit
- -V, --version  display version and exit
-
-The rule of thumb with other options is that once they exist, you may
-not change them, nor change how they work, nor remove them.
-
-See Legacy options below.
-
 
 How a usage text is supposed to look
 ------------------------------------
@@ -146,17 +132,3 @@ define. The command author, package maintainer or patch submitter will
 usually know when it should be done that way.
 
 
-Legacy options
---------------
-
-Some commands use peculiar options and arguments.  These will continue
-to be supported, but anything like them will not be accepted as new
-additions.  A short list of examples:
-
-- Characters other than '-' to start an option.  See '+' in 'more'.
-- Using a number as an option.  See '-<number>' in 'more'.
-- Long options that start with a single '-'.  See 'setterm'.
-- '-?' is not expected to be a synonym of '--help', but is an unknown
-  option resulting in a suggestion to try --help due to a getopt failure.
-
-

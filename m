Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34275 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbcG0KfF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Jul 2016 06:35:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so5790048wma.1
        for <util-linux@vger.kernel.org>; Wed, 27 Jul 2016 03:35:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] getops: improve getopt-parse.bash example
Date: Wed, 27 Jul 2016 11:34:57 +0100
Message-Id: <20160727103457.3105-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use correct names of example scripts in the script.  Remove use of
backticks, they require quoting that makes the example harder to follow.
Split one-liners to one-command-at-a-time expressions.  Add continue keyword
to avoid additional case statement matching.  Be strict with quoting.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt-parse.bash | 78 ++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/misc-utils/getopt-parse.bash b/misc-utils/getopt-parse.bash
index aab8c62..923ddd8 100644
--- a/misc-utils/getopt-parse.bash
+++ b/misc-utils/getopt-parse.bash
@@ -3,45 +3,73 @@
 # A small example program for using the new getopt(1) program.
 # This program will only work with bash(1)
 # An similar program using the tcsh(1) script language can be found
-# as parse.tcsh
+# as getopt-parse.tcsh
 
 # Example input and output (from the bash prompt):
-# ./parse.bash -a par1 'another arg' --c-long 'wow!*\?' -cmore -b " very long "
+#
+# ./getopt-parse.bash -a par1 'another arg' --c-long 'wow!*\?' -cmore -b " very long "
 # Option a
 # Option c, no argument
-# Option c, argument `more'
-# Option b, argument ` very long '
+# Option c, argument 'more'
+# Option b, argument ' very long '
 # Remaining arguments:
-# --> `par1'
-# --> `another arg'
-# --> `wow!*\?'
+# --> 'par1'
+# --> 'another arg'
+# --> 'wow!*\?'
 
-# Note that we use `"$@"' to let each command-line parameter expand to a
-# separate word. The quotes around `$@' are essential!
-# We need TEMP as the `eval set --' would nuke the return value of getopt.
-TEMP=$(getopt -o ab:c:: --long a-long,b-long:,c-long:: \
-     -n 'example.bash' -- "$@")
+# Note that we use "$@" to let each command-line parameter expand to a
+# separate word. The quotes around "$@" are essential!
+# We need TEMP as the 'eval set --' would nuke the return value of getopt.
+TEMP=$(getopt -o 'ab:c::' --long '-long,b-long:,c-long::' -n 'example.bash' -- "$@")
 
-if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
+if [ $? -ne 0 ]; then
+	echo 'Terminating...' >&2
+	exit 1
+fi
 
-# Note the quotes around `$TEMP': they are essential!
+# Note the quotes around "$TEMP": they are essential!
 eval set -- "$TEMP"
+unset TEMP
 
-while true ; do
+while true; do
 	case "$1" in
-		-a|--a-long) echo "Option a" ; shift ;;
-		-b|--b-long) echo "Option b, argument \`$2'" ; shift 2 ;;
-		-c|--c-long)
+		'-a'|'--a-long')
+			echo 'Option a'
+			shift
+			continue
+		;;
+		'-b'|'--b-long')
+			echo "Option b, argument '$2'"
+			shift 2
+			continue
+		;;
+		'-c'|'--c-long')
 			# c has an optional argument. As we are in quoted mode,
 			# an empty parameter will be generated if its optional
 			# argument is not found.
 			case "$2" in
-				"") echo "Option c, no argument"; shift 2 ;;
-				*)  echo "Option c, argument \`$2'" ; shift 2 ;;
-			esac ;;
-		--) shift ; break ;;
-		*) echo "Internal error!" ; exit 1 ;;
+				'')
+					echo 'Option c, no argument'
+				;;
+				*)
+					echo "Option c, argument '$2'"
+				;;
+			esac
+			shift 2
+			continue
+		;;
+		'--')
+			shift
+			break
+		;;
+		*)
+			echo 'Internal error!' >&2
+			exit 1
+		;;
 	esac
 done
-echo "Remaining arguments:"
-for arg do echo '--> '"\`$arg'" ; done
+
+echo 'Remaining arguments:'
+for arg; do
+	echo "--> '$arg'"
+done
-- 
2.9.0


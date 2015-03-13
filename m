Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50110 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbbCMPJk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Mar 2015 11:09:40 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LcFTN-1ZFdG33TYD-00jcsM for
 <util-linux@vger.kernel.org>; Fri, 13 Mar 2015 16:09:38 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] tailf: deprecated
Date: Fri, 13 Mar 2015 16:09:36 +0100
Message-Id: <1426259377-15288-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1426259377-15288-1-git-send-email-sweet_f_a@gmx.de>
References: <1426259377-15288-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We want to remove it in 2 years, March 2017.
See discussion "tailf, really needed?"
http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/10967

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 Documentation/deprecated.txt |  5 +++++
 tests/expected/tailf/simple  |  1 +
 text-utils/tailf.1           |  6 ++++++
 text-utils/tailf.c           | 16 ++++++++++++----
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index fc31ece..11f4d1f 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -3,6 +3,11 @@ deprecated utils are in maintenance mode and we keep them in source tree for
 backward compatibility only.
 
 
+what:  tailf
+why:   "tail -f" is better nowadays, tailf has unfixed bugs
+
+--------------------------
+
 what:  sfdisk --show-size
 why:   this does not belong to fdisk, use "blockdev --getsz"
 
diff --git a/tests/expected/tailf/simple b/tests/expected/tailf/simple
index ddf72de..5edc76b 100644
--- a/tests/expected/tailf/simple
+++ b/tests/expected/tailf/simple
@@ -1,2 +1,3 @@
+tailf: warning: use of 'tailf' is deprecated, use 'tail -f' instead
 a b c d e f g h i j k l m n o p q r s t u v w x y z
 0 1 2 3 4 5 6 7 8 9
diff --git a/text-utils/tailf.1 b/text-utils/tailf.1
index d59c531..9c6bd6a 100644
--- a/text-utils/tailf.1
+++ b/text-utils/tailf.1
@@ -29,6 +29,12 @@ tailf \- follow the growth of a log file
 [option]
 .I file
 .SH DESCRIPTION
+.B tailf is deprecated.
+It may have unfixed bugs and will be removed in March 2017. Nowadays it's safe
+to use
+.B tail -f
+(coreutils) in contrast to the original documentation below.
+.PP
 .B tailf
 will print out the last 10 lines of the given \fIfile\fR and then wait
 for this \fIfile\fR to grow.  It is similar to
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 6039049..9c57fad 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -19,13 +19,18 @@
  * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * This command is deprecated.  The utility is in maintenance mode,
+ * meaning we keep them in source tree for backward compatibility
+ * only.  Do not waste time making this command better, unless the
+ * fix is about security or other very critical issue.
  *
- * less -F and tail -f cause a disk access every five seconds.  This
- * program avoids this problem by waiting for the file size to change.
- * Hence, the file is not accessed, and the access time does not need to be
- * flushed back to disk.  This is sort of a "stealth" tail.
+ * See Documentation/deprecated.txt for more information.
  */
 
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -246,6 +251,9 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	warnx(_("warning: "
+		"use of 'tailf' is deprecated, use 'tail -f' instead"));
+
 	if (!old_style_option(&argc, argv, &lines))
 		lines = DEFAULT_LINES;
 
-- 
1.8.4.5


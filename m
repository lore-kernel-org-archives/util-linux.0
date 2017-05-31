Return-Path: elseifthen@gmx.com
Subject: [PATCH 3/4] docs: update howto-contribute.txt
To: Karel Zak <kzak@redhat.com>
References: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <69045dce-51a3-193c-c1b1-37b5c1ccb272@gmx.com>
Date: Wed, 31 May 2017 14:53:29 -0400
MIME-Version: 1.0
In-Reply-To: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


This patch does not change any wording or grammar. It
only shuffles the order of things and adds a table of
contents. For example: it moves coding related bullet
points into the Coding Style Chapter; it groups email
related Chapters together, and so fourth.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/howto-contribute.txt | 123 ++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 58 deletions(-)

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index 729f4cb..fc2c503 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -1,31 +1,74 @@
-Patches
+CONTENTS
+ Sending Patches
+ Patching Process
+ Email Format
+ Coding Style
+ Various Notes
+ Standards Compliance
+ IRC Channel
+
+Sending Patches
 
 	* send your patches to the mailing list or to the project maintainer.
 	  See ../README.
 
-	* don't include generated (autotools) files in your patches.
-	  Hint: use 'git clean -Xd'.
-
-	* neutrality: the files in util-linux should be distribution-neutral.
-	  Packages like RPMs, DEBs, and the rest, are not provided. They should
-	  be available from the distribution.
-
 	* email is accepted as an inline patch with, or without, a git pull
 	  request. Pull request emails need to include the patch set for review
 	  purposes. See howto-pull-request.txt and source-code-management.txt
 	  for git repository instructions.
 
+	* email attachments are difficult to review and not recommended.
+	  Hint: use git send-email.
+
 	* one patch per email.
 	  See Email Format.
 
-	* email attachments are difficult to review and not recommended.
-	  Hint: use 'git send-email'.
-
 	* many small patches are preferred over a single large patch. Split
 	  patch sets based upon logical functionality. For example: #endif mark
 	  ups, compiler warnings, and exit code fixes should all be individual
 	  small patches.
 
+	* don't include generated (autotools) files in your patches.
+	  Hint: use 'git clean -Xd'.
+
+	* neutrality: the files in util-linux should be distribution-neutral.
+	  Packages like RPMs, DEBs, and the rest, are not provided. They should
+	  be available from the distribution.
+
+Patching Process
+
+	* announce it on the mailing list when you are going to work with some
+	  particular piece of code for a long time. This helps others to avoid
+	  massive merge conflicts. Small or quick work, does not need to be
+	  announced.
+
+	* make sure that after applying your patch the file(s) will compile
+	  without errors.
+
+	* test that the previously existing program behavior is not altered. If
+	  the patch intentionally alters the behavior explain what changed, and
+	  the reason for it, in the changelog/commit message.
+
+	* only submit changes that you believe are ready to merge. To post a
+	  patch for peer review only, state it clearly in the email and use
+	  the Subject: [PATCH RFC] ...
+
+	* incorporate reviewer comments in the patches. Resubmitting without
+	  changes is neither recommended nor polite.
+
+	* resubmission can be partial or complete. If only a few alterations are
+	  needed then resubmit those particular patches. When comments cause a
+	  greater effect then resubmit the entire patch set.
+
+	* When resubmitting use the email Subject: [PATCH v2] ...
+	  Hint: use the --subject-prefix='PATCH v2' option with 'git format-patch'
+
+	* using a git repository for (re)submissions can make life easier.
+	  See howto-pull-request.txt and source-code-management.txt.
+
+	* all patch submissions are either commented, rejected, or accepted.
+	  If the maintainer rejects a patch set it is pointless to resubmit it.
+
 Email Format
 
 	* Subject: [PATCH] subsystem: description.
@@ -82,16 +125,7 @@ Email Format
 
 	* Followed by the unified diff patch.
 
-Before sending a patch
-
-	* make sure that after applying your patch the file(s) will compile
-	  without errors.
-
-	* test that the previously existing program behavior is not altered. If
-	  the patch intentionally alters the behavior explain what changed, and
-	  the reason for it, in the changelog/commit message.
-
-Coding style
+Coding Style
 
 	* the preferred coding style is based on the linux kernel coding-style.
 	  Available here:
@@ -102,41 +136,6 @@ Coding style
 	  that something is not quite right, and you are unwilling to fix the
 	  issue in the submitted change.
 
-Patching process
-
-	* announce it on the mailing list when you are going to work with some
-	  particular piece of code for a long time. This helps others to avoid
-	  massive merge conflicts. Small or quick work, does not need to be
-	  announced.
-
-	* only submit changes that you believe are ready to merge. To post a
-	  patch for peer review only, state it clearly in the email and use
-	  the Subject: [PATCH RFC] ...
-
-	* incorporate reviewer comments in the patches. Resubmitting without
-	  changes is neither recommended nor polite.
-
-	* resubmission can be partial or complete. If only a few alterations are
-	  needed then resubmit those particular patches. When comments cause a
-	  greater effect then resubmit the entire patch set.
-
-	* When resubmitting use the email Subject: [PATCH v2] ...
-	  Hint: use the --subject-prefix='PATCH v2' option with 'git format-patch'
-
-	* using a git repository for (re)submissions can make life easier.
-	  See howto-pull-request.txt and source-code-management.txt.
-
-	* all patch submissions are either commented, rejected, or accepted.
-	  If the maintainer rejects a patch set it is pointless to resubmit it.
-
-Various notes
-
-	* util-linux does not use kernel headers for file system super
-	  blocks structures.
-
-	* patches relying on kernel features that are not in Linus Torvalds's
-	  tree are not accepted.
-
 	* do not use `else' after non-returning functions. For
 	  example:
 
@@ -155,7 +154,15 @@ Various notes
 	  multiple lines. In case the shorthand does not look good on one line
 	  use the normal "if () else" syntax.
 
-Standards compliance
+Various Notes
+
+	* util-linux does not use kernel headers for file system super
+	  blocks structures.
+
+	* patches relying on kernel features that are not in Linus Torvalds's
+	  tree are not accepted.
+
+Standards Compliance
 
 	Some of the commands maintained in this package have Open Group
 	requirements. These commands are:
@@ -183,7 +190,7 @@ Standards compliance
 
 		http://pubs.opengroup.org/onlinepubs/7908799/xcuix.html
 
-IRC channel
+IRC Channel
 
 	* #util-linux at freenode.net:
 

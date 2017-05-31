Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/4] docs: update howto-contribute.txt
To: Karel Zak <kzak@redhat.com>
References: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a5e7bda8-72bc-daf3-35f7-1409de027a6a@gmx.com>
Date: Wed, 31 May 2017 14:51:51 -0400
MIME-Version: 1.0
In-Reply-To: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Grammar fixes and some clarification changes.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/howto-contribute.txt | 154 +++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 73 deletions(-)

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index 6d3e789..729f4cb 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -1,43 +1,50 @@
 Patches
 
-	* send your patches to the mailing list or to the upstream maintainer
-	  (see the README file in project root directory).
+	* send your patches to the mailing list or to the project maintainer.
+	  See ../README.
 
-	* don't include generated (autotools) stuff to your patches (hint:
-	  use git clean -Xd)
+	* don't include generated (autotools) files in your patches.
+	  Hint: use 'git clean -Xd'.
 
-	* neutrality; The stuff in util-linux should be rather
-	  distribution-neutral. No RPMs/DEBs/... are provided - get yours
-	  from your distributor.
+	* neutrality: the files in util-linux should be distribution-neutral.
+	  Packages like RPMs, DEBs, and the rest, are not provided. They should
+	  be available from the distribution.
 
-	* patches are delivered via email or git remote repository only.
-	  Downloading them from internet servers is a pain.  See
-	  howto-pull-request.txt for remote repository instructions.
+	* email is accepted as an inline patch with, or without, a git pull
+	  request. Pull request emails need to include the patch set for review
+	  purposes. See howto-pull-request.txt and source-code-management.txt
+	  for git repository instructions.
 
-	* one patch per email, with the changelog in the body of the email.
+	* one patch per email.
+	  See Email Format.
 
-	* mail attachments are difficult. Tip:
-	  git send-email --to util-linux@vger.kernel.org origin/master..yourbranch
+	* email attachments are difficult to review and not recommended.
+	  Hint: use 'git send-email'.
 
-	* many small patches are favoured over one big. Break down is done on
-	  basis of logical functionality; for example #endif mark ups,
-	  compiler warning and exit codes fixes all should be individual
+	* many small patches are preferred over a single large patch. Split
+	  patch sets based upon logical functionality. For example: #endif mark
+	  ups, compiler warnings, and exit code fixes should all be individual
 	  small patches.
 
-	* 'Subject: [PATCH] subsystem: description'. See also 'Patching
-	  process'.
+Email Format
+
+	* Subject: [PATCH] subsystem: description.
+
+	* Start the message body with an explanation of the patch, that is, a
+	  changelog/commit entry.
 
 	* if someone else wrote the patch, they should be credited (and
-	  blamed) for it. To communicate this, add a line:
+	  blamed) for it. To communicate this, add a line like:
 
 	  From: John Doe <jdoe@wherever.com>
 
-	* add a Signed-off-by line (hint: use "git commit -s")
+	* add a Signed-off-by line.
+	  Hint: use git commit -s
 
 	  The sign-off is a simple line at the end of the explanation for the
 	  patch, which certifies that you wrote it or otherwise have the
 	  right to pass it on as a open-source patch. The rules are pretty
-	  simple: if you can certify the below:
+	  simple; if you can certify the following:
 
 	  By making a contribution to this project, I certify that:
 
@@ -64,92 +71,94 @@ Patches
 	       consistent with this project or the open source license(s)
 	       involved.
 
-	  then you just add a line saying
+	  Then you just add a line like:
 
 	       Signed-off-by: Random J Developer <random@developer.example.org>
 
-	  using your real name (sorry, no pseudonyms or anonymous
-	  contributions.)
+	  Use your real name (sorry, no pseudonyms or anonymous contributions.)
+
+	* Next a single line beginning with three hyphen-minus characters (---)
+	  and nothing else.
+
+	* Followed by the unified diff patch.
 
 Before sending a patch
 
-	* make sure that after patching source files will compile without
-	  errors.
+	* make sure that after applying your patch the file(s) will compile
+	  without errors.
 
-	* test that previously existed program behavior is not
-	  unintentionally alterred. If you alter the behavior tell about
-	  it in commit message.
+	* test that the previously existing program behavior is not altered. If
+	  the patch intentionally alters the behavior explain what changed, and
+	  the reason for it, in the changelog/commit message.
 
 Coding style
 
-	* the preferred coding style is based on the linux kernel
-	  Documentation/CodingStyle. For more details see:
+	* the preferred coding style is based on the linux kernel coding-style.
+	  Available here:
 
-	  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/CodingStyle
+	http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/process/coding-style.rst
 
-	* Use `FIXME:' and a good description if want to inform others
-	  something is not quite right, and you are unwilling to fix the
+	* use 'FIXME:' with a good description, if you want to inform others
+	  that something is not quite right, and you are unwilling to fix the
 	  issue in the submitted change.
 
 Patching process
 
-	* Tell in mail list when you are going to work with some particular
-	  piece of code for long time.  This helps other to avoid massive
-	  merge conflicts.  Small or quick work does not need to be
+	* announce it on the mailing list when you are going to work with some
+	  particular piece of code for a long time. This helps others to avoid
+	  massive merge conflicts. Small or quick work, does not need to be
 	  announced.
 
-	* Submit only changes that you think are ready to merge.  If you only
-	  want change review tell your intention clearly in change cover
-	  letter, and/or in each patch subject to review-only.
+	* only submit changes that you believe are ready to merge. To post a
+	  patch for peer review only, state it clearly in the email and use
+	  the Subject: [PATCH RFC] ...
 
-	* When getting comments align the changes with them.  Resubmission
-	  without changes is as good as ignoring advice, and is neither
-	  recommended nor polite.
+	* incorporate reviewer comments in the patches. Resubmitting without
+	  changes is neither recommended nor polite.
 
-	* Resubmission can be partial or complete.  If only few alterations
-	  are needed here and there resubmit particular patches.  When
-	  comments cause greater effect resubmit everything again.
+	* resubmission can be partial or complete. If only a few alterations are
+	  needed then resubmit those particular patches. When comments cause a
+	  greater effect then resubmit the entire patch set.
 
-	* Mark resubmission with [PATCH v2]. Hint:
-	  git format-patch origin/master..yourbranch --subject-prefix='PATCH v2'
+	* When resubmitting use the email Subject: [PATCH v2] ...
+	  Hint: use the --subject-prefix='PATCH v2' option with 'git format-patch'
 
-	* Use of remote repository for resubmission can be good idea.
-	  See also howto-pull-request.txt
+	* using a git repository for (re)submissions can make life easier.
+	  See howto-pull-request.txt and source-code-management.txt.
 
-	* All patch submissions, big or small, are either commented, reject,
-	  or merge.  When maintainer rejects a patch (series) it is pointless
-	  to resubmit.
+	* all patch submissions are either commented, rejected, or accepted.
+	  If the maintainer rejects a patch set it is pointless to resubmit it.
 
 Various notes
 
-	* The util-linux does not use kernel headers for file system super
+	* util-linux does not use kernel headers for file system super
 	  blocks structures.
 
-	* Patches relying on features that are not in Linus' tree
-	  are not accepted.
+	* patches relying on kernel features that are not in Linus Torvalds's
+	  tree are not accepted.
 
-	* Do not use `else' after non-returning functions. For
-	  example
+	* do not use `else' after non-returning functions. For
+	  example:
 
 	  if (this)
 		err(EXIT_FAIL, "this failed");
 	  else
 		err(EXIT_FAIL, "that failed");
 
-	  is wrong and should be wrote
+	  Is wrong and should be written:
 
 	  if (this)
 		err(EXIT_FAIL, "this failed");
 	  err(EXIT_FAIL, "that failed");
 
-	* When you use if shortshort hand make sure it is not wrapped to
-	  multiple lines. In case the shorthand does not look good on one
-	  line use normal "if () else" syntax.
+	* when you use 'if' short-shorthand make sure it does not wrap into
+	  multiple lines. In case the shorthand does not look good on one line
+	  use the normal "if () else" syntax.
 
-Standards compliancy
+Standards compliance
 
 	Some of the commands maintained in this package have Open Group
-	requirements. These commands are;
+	requirements. These commands are:
 
 		cal
 		col
@@ -164,11 +173,10 @@ Standards compliancy
 		pg
 		renice
 
-	If you change these tools please make sure a change does not
-	conflict with the latest standard.  For example it is
-	recommendable not to add short command line options before they
-	are part of standard.  Introducing new long options is
-	acceptable.
+	If you change these tools please make sure it does not create a conflict
+	with the latest standard. For example, it is not recommended to add
+	short command line options before they are part of the standard.
+	Introducing new long options is acceptable.
 
 		The Single UNIX(TM) Specification, Version 2
 		Copyright (C) 1997 The Open Group
@@ -177,10 +185,10 @@ Standards compliancy
 
 IRC channel
 
-	* We have a new #util-linux IRC channel at freenode.net.
+	* #util-linux at freenode.net:
 
 	  irc://chat.freenode.net/util-linux
 
-	  the channel is for developers or upstream maintainers.  User
-	  support is recommended to go to distribution channels or
-	  forums.
+	  This channel is for developers and project maintainers. For end users
+	  it is recommended to utilize the distribution's IRC channel or support
+	  forum.

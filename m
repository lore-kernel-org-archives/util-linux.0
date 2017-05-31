Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52862 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdEaSzT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 14:55:19 -0400
Subject: [PATCH 4/4] docs: move source-code-management.txt to README
To: Karel Zak <kzak@redhat.com>
References: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <f102195c-8fc3-43ff-2902-b8901cc24787@gmx.com>
Date: Wed, 31 May 2017 14:54:54 -0400
MIME-Version: 1.0
In-Reply-To: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


source-code-management.txt and README had similar content so combine
them in README.

Change Documentation/source-code-management.txt references to README.

Remove Documentation/source-code-management.txt.

Move IRC Channel information to README

Expand information about git branches and tags in README.

Add workflow to README; written by Karel Zak <kzak@redhat.com>

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/howto-contribute.txt       |  18 +----
 Documentation/release-schedule.txt       |   2 +-
 Documentation/source-code-management.txt |  38 ----------
 README                                   | 121 +++++++++++++++++++++++--------
 4 files changed, 96 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/source-code-management.txt

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index fc2c503..71b9ed7 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -5,17 +5,16 @@ CONTENTS
  Coding Style
  Various Notes
  Standards Compliance
- IRC Channel
 
 Sending Patches
 
-	* send your patches to the mailing list or to the project maintainer.
+	* send your patches to the mailing list.
 	  See ../README.
 
 	* email is accepted as an inline patch with, or without, a git pull
 	  request. Pull request emails need to include the patch set for review
-	  purposes. See howto-pull-request.txt and source-code-management.txt
-	  for git repository instructions.
+	  purposes. See howto-pull-request.txt and ../README for git repository
+	  instructions.
 
 	* email attachments are difficult to review and not recommended.
 	  Hint: use git send-email.
@@ -64,7 +63,7 @@ Patching Process
 	  Hint: use the --subject-prefix='PATCH v2' option with 'git format-patch'
 
 	* using a git repository for (re)submissions can make life easier.
-	  See howto-pull-request.txt and source-code-management.txt.
+	  See howto-pull-request.txt and ../README.
 
 	* all patch submissions are either commented, rejected, or accepted.
 	  If the maintainer rejects a patch set it is pointless to resubmit it.
@@ -190,12 +189,3 @@ Standards Compliance
 
 		http://pubs.opengroup.org/onlinepubs/7908799/xcuix.html
 
-IRC Channel
-
-	* #util-linux at freenode.net:
-
-	  irc://chat.freenode.net/util-linux
-
-	  This channel is for developers and project maintainers. For end users
-	  it is recommended to utilize the distribution's IRC channel or support
-	  forum.
diff --git a/Documentation/release-schedule.txt b/Documentation/release-schedule.txt
index 728de4d..0e12694 100644
--- a/Documentation/release-schedule.txt
+++ b/Documentation/release-schedule.txt
@@ -39,4 +39,4 @@ For all releases it is required that:
 See also
 --------
 
-Documentation/source-code-management.txt
+../README
diff --git a/Documentation/source-code-management.txt b/Documentation/source-code-management.txt
deleted file mode 100644
index ffa90d0..0000000
--- a/Documentation/source-code-management.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-SCM (source code management):
-
-    Primary repository:
-	git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git util-linux
-
-    Backup repository:
-	git clone git://github.com/karelzak/util-linux.git
-
-Note that GitHub repository may contain temporary development branches too.
-
-The kernel.org repository contains master (current development) and stable/*
-(maintenance) branches only. All master or stable/* changes are always pushed
-to the both repositories in the same time.
-
-Branches:
-
-    * maintenance (stable) branch
-	- created for every <major>.<minor> release
-	- branch name: stable/v<major>.<minor>
-
-    * master branch
-	- the status of this branch is: "it works for me". It
-	  means useful but not well tested patches.
-	- it's source for occasional snapshots
-	- for long-term development or invasive changes should be
-	  an active development forked into a separate branch
-	  (topic branches) from the tip of "master".
-
-Tags:
-
-    * A new tag object is created for:
-	- every release, tag name: v<version>, see "git tag -l" for
-          more information
-        - all tags are signed by maintainer's PGP key
-
-    * KNOWN BUGS:
-	- don't use tag v2.13.1 (created and published by mistake),
-          use v2.13.1-REAL.
diff --git a/README b/README
index 803f5dd..81e0504 100644
--- a/README
+++ b/README
@@ -1,67 +1,128 @@
 
-                                  util-linux
+				  util-linux
 
-              util-linux is a random collection of Linux utilities
+		util-linux is a random collection of Linux utilities
 
-     Note that in years 2006-2010 this project used the name "util-linux-ng".
+     Note: for the years 2006-2010 this project was named "util-linux-ng".
 
 MAILING LIST:
 
       E-MAIL: util-linux@vger.kernel.org
       URL:    http://vger.kernel.org/vger-lists.html#util-linux
 
+IRC CHANNEL:
 
-DOWNLOAD:
+      #util-linux at freenode.net:
 
-      https://www.kernel.org/pub/linux/utils/util-linux/
+      irc://chat.freenode.net/util-linux
 
+      The IRC channel and Mailing list are for developers and project
+      maintainers. For end users it is recommended to utilize the
+      distribution's support system.
 
 BUG REPORTING:
 
       E-MAIL: util-linux@vger.kernel.org
       Web:    https://github.com/karelzak/util-linux/issues
 
-      Note that upstream community has no resources to provide support for end
-      users with distribution specific issues. It's strongly recommended to 
-      report bugs to the distribution (downstream) maintainers by distribution
-      bug tracking systems. 
+      This project has no resources to provide support for distribution specific
+      issues. For end users it is recommended to utilize the distribution's
+      support system.
+
+NLS (PO TRANSLATIONS):
+
+      PO files are maintained by:
+	  http://translationproject.org/domain/util-linux.html
+
+VERSION SCHEMA:
+
+      Standard releases:
+	  <major>.<minor>[.<maint>]
+	     major = fatal and deep changes
+	     minor = typical release with new features
+	     maint = maintenance releases; bug fixes only
+
+      Development releases:
+	 <major>.<minor>-rc<N>
 
 SOURCE CODE:
 
-      See also Documentation/howto-contribute.txt
-               Documentation/source-code-management.txt
+ Download archive:
+	  https://www.kernel.org/pub/linux/utils/util-linux/
+
+ SCM (Source Code Management) Repository:
 
-      Web interface:
-          http://git.kernel.org/cgit/utils/util-linux/util-linux.git
-          https://github.com/karelzak/util-linux
+    Primary repository:
+	  git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
 
-      Checkout:
-          git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git util-linux
+    Backup repository:
+	  git clone git://github.com/karelzak/util-linux.git
 
-      Note that GitHub repository may contain temporary development branches too.
+    Web interfaces:
+	  http://git.kernel.org/cgit/utils/util-linux/util-linux.git
+	  https://github.com/karelzak/util-linux
+
+      Note: the GitHub repository may contain temporary development branches too.
 
       The kernel.org repository contains master (current development) and stable/*
       (maintenance) branches only. All master or stable/* changes are always pushed
-      to the both repositories in the same time.
+      to both repositories at the same time.
 
+    Repository Branches: 'git branch -a'
+	  master branch
+	   - current development
+	   - the source for stable releases when deemed ready.
+	   - day-to-day status is: 'it works for me'. This means that its
+	     normal state is useful but not well tested.
+	   - long-term development or invasive changes in active development are
+	     forked into separate 'topic' branches from the tip of 'master'.
 
-NLS (PO TRANSLATIONS):
+	  stable/ branches
+	   - public releases
+	   - branch name: stable/v<major>.<minor>.
+	   - created from the 'master' branch after two or more release
+	     candidates and the final public release. This means that the stable
+	     releases are committed, tagged, and reachable in 'master'.
+	   - these branches then become forked development branches. This means
+	     that any changes made to them diverge from the 'master' branch.
+	   - maintenance releases are part of, and belong to, their respective
+	     stable branch. As such, they are tags(<major>.<minor>.<maint>) and
+	     not branches of their own. They are not part of, visible in, or
+	     have anything to do with the 'master' development branch. In git
+	     terminology: maintenance releases are not reachable from 'master'.
+	   - when initially cloned (as with the 'git clone' command given above)
+	     these branches are created as 'remote tracking branches' and are
+	     only visible by using the -a or -r options to 'git branch'. To
+	     create a local branch use the desired tag with this command:
+	     'git checkout -b v2.29.2 v2.29.2'
 
-      PO files are maintained by:
-          http://translationproject.org/domain/util-linux.html
+    Tags: 'git tag'
+	   - a new tag object is created for every release.
+	   - tag name: v<version>.
+	   - all tags are signed by the maintainer's PGP key.
 
+    Known Bugs:
+	- don't use tag v2.13.1 (created and published by mistake),
+	  use v2.13.1-REAL instead.
 
-VERSION SCHEMA:
+WORKFLOW EXAMPLE:
 
-      Standard releases:
+ 1) development (branch: <master>)
 
-          <major>.<minor>[.<maint>[.<bugfix>]]
+ 2) master release (tags: v2.29-rc1, v2.29-rc2, v2.29, branch: <master>)
 
-             major = fatal and deep changes
-             minor = typical release with new features
-             maint = maintenance releases; bug fixes only
-             bugfix = unplanned releases for critical/security bugs
+ 3) development (work on v2.30, branch: <master>)
 
-      Development releases:
+ 4) fork -- create a new branch <stable/v2.29> based on tag v2.29
+
+     4a) new patches or cherry-pick patches from <master> (branch: <stable/v2.29>)
+
+     4b) stable release (tag: v2.29.1, branch: <stable/v2.29>)
+
+     4c) more patches; another release (tag: v2.29.2, branch: <stable/v2.29>)
+
+ 5) master release v2.30 (branch: <master>)
+    ...
+
+where 3) and 4) happen simultaneously.
 
-         <major>.<minor>-rc<N>

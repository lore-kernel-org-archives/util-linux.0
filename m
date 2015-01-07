Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:55668 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbbAGTZr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 Jan 2015 14:25:47 -0500
Received: by mail-wg0-f54.google.com with SMTP id z12so1773622wgg.41
        for <util-linux@vger.kernel.org>; Wed, 07 Jan 2015 11:25:45 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] docs: add howto-pull-request.txt
Date: Wed,  7 Jan 2015 19:25:39 +0000
Message-Id: <1420658739-2713-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1420658739-2713-1-git-send-email-kerolasa@iki.fi>
References: <1420658739-2713-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: http://comments.gmane.org/gmane.linux.utilities.util-linux-ng/10431
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/howto-contribute.txt   |   8 +-
 Documentation/howto-pull-request.txt | 286 +++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/howto-pull-request.txt

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index 554d6b3..6d3e789 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -10,8 +10,9 @@ Patches
 	  distribution-neutral. No RPMs/DEBs/... are provided - get yours
 	  from your distributor.
 
-	* patches are delivered via email only. Downloading them from
-	  internet servers is a pain.
+	* patches are delivered via email or git remote repository only.
+	  Downloading them from internet servers is a pain.  See
+	  howto-pull-request.txt for remote repository instructions.
 
 	* one patch per email, with the changelog in the body of the email.
 
@@ -112,6 +113,9 @@ Patching process
 	* Mark resubmission with [PATCH v2]. Hint:
 	  git format-patch origin/master..yourbranch --subject-prefix='PATCH v2'
 
+	* Use of remote repository for resubmission can be good idea.
+	  See also howto-pull-request.txt
+
 	* All patch submissions, big or small, are either commented, reject,
 	  or merge.  When maintainer rejects a patch (series) it is pointless
 	  to resubmit.
diff --git a/Documentation/howto-pull-request.txt b/Documentation/howto-pull-request.txt
new file mode 100644
index 0000000..924f22a
--- /dev/null
+++ b/Documentation/howto-pull-request.txt
@@ -0,0 +1,286 @@
+Introduction
+------------
+
+These instructions are wrote to contributors who tend to send lots of
+changes.  The basics from howto-contribute.txt file are assumed to be
+read and understood by the time this file becomes useful.
+
+
+Setup
+-----
+
+1. Find a git server that can be reached from anywhere in internet
+anonymously.  Github is for example a popular choice.
+
+2. Create your own util-linux contributor repository, and push a upstream
+clone to there.
+
+3. In these instructions the upstream remote repository is called
+'origin' and the 'yourgit' is the contributor repo.
+
+cd ~/projects
+git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
+cd util-linux
+git remote add yourgit git@github.com:yourlogin/util-linux.git
+git push yourgit
+
+
+Branches
+--------
+
+1. Use the name of the subsystem, such as blkid, libmount, misc-utils,
+that is the common thing for changes in in the change set.
+
+2. If the changes do not have anything in common use some random name,
+such as YYYY-MM-DD of the first patch in the branch.  Name of the branch
+does not really matter that much, with one exception.
+
+3. Do not use 'master' branch to your contributions.  The 'master' branch
+is needed to stay up to date with upstream.
+
+4. When done push your branch to your remote git server.
+
+git checkout master
+git branch textual
+# spent here most of the effort
+git push yourbranch textual:textual
+
+5. Do not worry if you used stupid-and-wrong branch name, it can be fixed
+before submission.
+
+git branch -m stupid-and-wrong brilliant
+git push yourgit brilliant:brilliant :stupid-and-wrong
+
+
+Stay up to date
+---------------
+
+1. Ensure you have the latest from all remote repositories.
+
+2. Merge upstream 'master' branch if needed to your local 'master'.
+
+3. Rebase your working contribution branches.
+
+4. Push the changes to 'yourgit'.
+
+git fetch --all
+git log --graph --decorate --pretty=oneline --abbrev-commit --all
+
+5. If you notice upstream has changed while you were busy with your
+changes rebase on top of the master, but before that:
+
+6. Push a backup of your branch 'textual' to 'yourgit', then
+
+git checkout master
+git merge origin/master
+git checkout textual
+git rebase master
+
+If rebase reports conflicts fix the conflicts.  In case the rebase
+conflict is difficult to fix rebase --abort is good option, or recover
+from 'yourgit', either way there is some serious re-work ahead with the
+change set.
+
+7. Assuming rebase went fine push the latest to 'yourgit'.
+
+git push yourgit master:master
+git push yourgit --force textual:textual
+
+The contributor branch tends to need --force every now and then, don't be
+afraid using it.
+
+8. Push error with master branch
+
+If 'master' needs --force then something is really messed up.  In that
+case it is probably the wise to abandon(*) local clone, and start all
+over from cloning upstream again.  Once the upstream is cloned add again
+'yourgit' remote and
+
+git push --mirror yourgit
+
+But be WARNED.  The --mirror will nuke all of your stuff had in
+'yourgit', that can cause data loss.  (*)So don't remove the local clone,
+just move the directory to broken repos area.
+
+
+Sending pull request
+--------------------
+
+1. When you are happy with your changes sleep over night.  This is not a
+speed competition, and for some reason looking the changes the next day
+often makes one to realize how things could be improved.  The best this
+way you avoid changing the changes (that is always confusing).
+
+2. Check the next day the changes compile without errors or warnings, and
+that regression tests run fine.
+
+make clean &&
+make -j3 &&
+make check
+
+Notice that regression tests will not cover all possible cases, so you
+most likely need to use the commands, features, and fixes you did
+manually.
+
+3. If you need to change something.
+
+git rebase -i master
+# change something
+git push -f yourgit textual:textual
+
+4. Assuming the changes look good send them to mail list.  Yes, the all
+of them!  Sending pull request with github is not visible for project
+contributors, and they will not have change to review your changes.
+
+Sending only the pull request, i.e., not each patch, to mail-list is also
+bad.  Nothing is as good as seeing the changes as they are, and being
+able to find them from with your favourite web search engine from
+mail-list archive.  Obviously the pull request content does not get
+indexed, and that is why it is worse.
+
+git format-patch --cover-letter master..textual
+git request-pull upstream/master git://github.com/yourlogin/util-linux.git textual > tempfile
+
+Take from the 'tempfile' the header:
+
+----------------------------------------------------------------
+The following changes since commit 17bf9c1c39b4f35163ec5c443b8bbd5857386ddd:
+
+  ipcrm: fix usage (2015-01-06 11:55:21 +0100)
+
+are available in the git repository at:
+
+  git://github.com/yourlogin/lelux-utiliteetit.git textual
+----------------------------------------------------------------
+
+and copy paste it to 0000-cover-letter.patch file somewhere near 'BLURB
+HERE'.  Rest of the 'request-pull' output should be ignored.
+
+In same go fix the Subject: line to have reasonable description, for
+example
+
+Subject: [PATCH 00/15] pull: various textual improvements
+
+
+Feedback and resubmissions
+--------------------------
+
+1. Since you sent each patch to mail-list you can see which ones got to
+be responded.  In case the feedback will result in changes to the
+submission then rebase, perform the changes, and push again to your
+remote.
+
+# you probably should use 'Stay up to date' instructions now
+git checkout textual
+git rebase master -i
+# edit something
+git add files
+git commit --amend
+# Add 'Reviewed-by:', 'Tested-by:', 'Signed-off-by:', 'Reference:', and
+# other lines near signoff when needed.  Attributing the reviewers is a
+# virtue, try to do it.
+git rebase --continue
+git push -f yourgit textual:textual
+
+2. Send a message to mail-list that the submitted change has changed, and
+that the new version can be found from
+
+https://github.com/yourlogin/util-linux/commit/0123456789abcdef0123456789abcdef01234567
+
+3. There is no need to update the pull request cover letter.  The project
+maintainer has done enough of this stuff to know what to do.
+
+
+Repository maintenance
+----------------------
+
+1. When your remote branch is merged, or you got final reject, it is time
+to clean it up.
+
+git branch textual -d
+git push yourgit :textual
+
+2. If you have other contributor repositories configured you may also
+want to clean up the branches the others are done with.
+
+for I in $(git remote); do
+  echo "pruning: $I"
+  git remote prune $I
+done
+
+3. When all of your contributions are processed you should tidy up the
+git's guts.
+
+git reflog expire --all
+git gc --aggressive --prune=now
+
+Warning.  That tidying is not good idea while you are actively working
+with the change set.  You never know when you need to recover something
+from reflog, so keep that option available until you know the reflog is
+not needed.
+
+
+More branches, on top of branches, on top of ...
+------------------------------------------------
+
+Here is a one way of laying out multiple branches.
+
+git log --graph --decorate --pretty=oneline --abbrev-commit --all
+* 13bfff3 (HEAD, docs-update) docs: small improvements to howto-contribute.txt
+* 5435d28 (sami/more, more) more: do not call fileno() for std{in,out,err} streams
+* 3e1ac04 more: remove unnecessary braces
+* c19f31c more: check open(3) return value
+* 651ec1b more: move skipping forewards to a function from command()
+* bf0c2a7 more: move skipping backwards to a function from command()
+* 53a438d more: move editor execution to a function from command()
+* b11628b more: move runtime usage output away from command()
+* 6cab04e more: avoid long else segment in prbuf()
+* a2d9fbb more: remove 'register' keywords
+* c6b2d29 more: remove pointless functions
+* b41fe34 more: remove function like preprocessor defines
+* 1aaa1ce more: use paths.h to find bourne shell and vi editor
+* 016a019 more: return is statement, not a function
+* ff7019a more: remove dead code and useless comments
+* 1705c76 more: add struct more_control and remove global variables
+* 3ad4868 more: reorder includes, declarations, and global variables
+* 7220e9d more: remove function declarations - BRANCH STATUS: WORK IN PROGRESS
+* 04b9544 (sami/script) script: add noreturn function attributes
+* e7b8d50 script: use gettime_monotonic() to get timing file timestamps
+* 11289d2 script: use correct input type, move comment, and so on
+* 524e3e7 script: replace strftime() workaround with CFLAGS = -Wno-format-y2k
+* 0465e7f script: move do_io() content to small functions
+* 751edca script: add 'Script started' line always to capture file
+* f831657 script: remove io vs signal race
+* eefc1b7 script: merge doinput() and output() functions to do_io()
+* 9eba044 script: use poll() rather than select()
+* a6f04ef script: use signalfd() to catch signals
+* 4a86d9c script: add struct script_control and remove global variables
+* d1cf19c script: remove function prototypes
+* 6a7dce9 (sami/2015wk00) fsck.minix: fix segmentation fault
+* 5e3bcf7 lslocks: fix type warning
+* 3904423 maint: fix shadow declarations
+* 17bf9c1 (upstream/master, sami/master, kzgh/master, master) ipcrm: fix usage
+[...]
+
+The above gives a hint to maintainer what is the preferred merge order.
+The branches '2015wk00' and 'script' are ready to be merged, and they
+were sent to mail-list.
+
+The 'more' branch was not submitted at the time of writing this text.
+Mark-up the branch is not ready is clearly marked in the commit subject,
+that will need some rebaseing to before submission.
+
+Good order of the branches is;
+
+1. First the minor & safe changes.
+2. Then the ready but less certain stuff.
+3. Followed by work-in-progress.
+
+If you go down this route you will get used to typing a lot of
+
+git rebase previous-branch
+git push -f yourgit branch:branch
+
+Alternatively rebase each branch on top of origin/master, which is not
+quite as good.  How do you ensure your own changes are not in conflict
+with each other?  And there is no hint of preferred merging order.
-- 
2.2.1


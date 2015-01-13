Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54661 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbbAMTKb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Jan 2015 14:10:31 -0500
Message-ID: <54B56D94.7030509@gmx.com>
Date: Tue, 13 Jan 2015 14:10:12 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] docs: fix-up man-pages flaged by checkmans.sh
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/sfdisk.8	Fix font escape
login-utils/vipw.8	Delete bogus macro
misc-utils/look.1	Delete bogus macro
sys-utils/prlimit.1	Delete bogus macro

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
The following changes since commit 2e5bf10e32b00c92a3f7fb8b38d793ea6fc1dff2:

  build-sys: add sfdisk.static (2015-01-13 16:59:03 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git checkman

 disk-utils/sfdisk.8 | 2 +-
 login-utils/vipw.8  | 1 -
 misc-utils/look.1   | 1 -
 sys-utils/prlimit.1 | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 03443d3..5f9eba4 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -264,7 +264,7 @@ The
 .I device
 field is optional.  \fBsfdisk\fRextracts the partition number from the
 device name.  It allows to specify the partitions in random order.
-This functionality is mostly used by \fb\-\-dump\fR.
+This functionality is mostly used by \fB\-\-dump\fR.
 Don't use it if you are not sure.
 
 The
diff --git a/login-utils/vipw.8 b/login-utils/vipw.8
index 3ee3082..9e4c9e2 100644
--- a/login-utils/vipw.8
+++ b/login-utils/vipw.8
@@ -69,7 +69,6 @@ The editor specified by the string
 .B EDITOR
 will be invoked instead of the default editor
 .BR vi (1).
-.El
 .SH SEE ALSO
 .BR passwd (1),
 .BR flock (2),
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index d54751c..e96a431 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -98,7 +98,6 @@ look -t: root:foobar /tmp/look.dict
 .nf
 .RE
 .SH FILES
-.IX Header "FILES"
 .IP "\fB/usr/share/dict/words\fR" 4
 the dictionary
 .IP "\fB/usr/share/dict/web2\fR" 4
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index c056272..e5c2071 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -89,7 +89,6 @@ Maximum number of file locks held.
 .IP "\fB\-y, \-\-rttime\fP[=\fIlimits\fR]"
 Timeout for real-time tasks.
 
-.RE
 .SH EXAMPLES
 .IP "\fBprlimit \-\-pid 13134\fP"
 Display limit values for all current resources.

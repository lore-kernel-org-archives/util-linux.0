Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:39116 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754558AbdFWVh2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:37:28 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 5/8] sys-utils/mount.8: Drop systemd paragraph from x-* entry
Date: Fri, 23 Jun 2017 14:30:23 -0700
Message-Id: <f6bcd3c58828ee2b3e321d6c3c0b6f002c63d400.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Removing the second paragraph from the x-* entry in favor of a "since
util-linux v2.30" parenthetical.  While the motivation for the
userspace storage is interesting, it's covered in more detail in the
0a14cc8b (libmount: revert X-* and x-* meaning, 2016-12-09) commit
message.

For example, the "keep existing fstab configurations usable" wording
I'm removing was a bit confusing, because fstabs using x-* and
expecting the options to be preserved in userspace were broken before
util-linux v2.30.  The clearer language from 0a14cc8b's commit message
is:

  The systemd and dracut users will get the new (=fixed) functionality
  without a change in fstab configuration.

It's not clear to me if there was an earlier version of util-linux
that also preserved x-* options.  Without that, the existing fstabs
using x-* and intending to have the options preserved *become* usable
with v2.30; they weren't usable before.

Also some minor grammar fixes to the first paragraph.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/mount.8 | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index d20e35d..2bcb12a 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1178,17 +1178,13 @@ nor sent to the mount.\fItype\fR helpers nor to the
 system call.  The suggested format is \fBX-\fIappname\fR.\fIoption\fR.
 .TP
 .B x-*
-The same as \fBX-*\fR options, but stored permanently in the user space. It
-means the options are also available for umount or another operations.  Note
-that maintain mount options in user space is tricky, because it's necessary use
-libmount based tools and there is no guarantee that the options will be always
-available (for example after a move mount operation or in unshared namespace).
-
-Note that before util-linux v2.30 the x-* options have not been maintained by
-libmount and stored in user space (functionality was the same as have X-* now),
-but due to growing number of use-cases (in initrd, systemd etc.) the
-functionality have been extended to keep existing fstab configurations usable
-without a change.
+The same as \fBX-*\fR options, but (since util-linux v2.30) stored
+permanently in the user space.  Storing the options means they are
+also available for umount and other operations.  Note that maintaining
+mount options in user space is tricky, because it's necessary use
+libmount-based tools and there is no guarantee that the options will
+be always available (for example after a move mount operation or in an
+unshared namespace).
 .TP
 .BR X-mount.mkdir [ = \fImode\fR ]
 Allow to make a target directory (mountpoint).  The optional argument
-- 
2.1.0.60.g85f0837


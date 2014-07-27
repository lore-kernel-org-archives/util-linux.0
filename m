Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:53295 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751304AbaG0S72 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 Jul 2014 14:59:28 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] docs: give the man page of utmpdump the proper User Commands header
Date: Sun, 27 Jul 2014 20:58:59 +0200
Message-Id: <1406487540-10491-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
References: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also bring the formatting closer to standard.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 login-utils/utmpdump.1 |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 933a3c9..68516d8 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -14,7 +14,7 @@
 .\" along with this program; if not, write to the Free Software
 .\" Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 .\"
-.TH UTMPDUMP "1" "July 2012" "util-linux" "System Administration"
+.TH UTMPDUMP 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 utmpdump \- dump UTMP and WTMP files in raw format
 .SH SYNOPSIS
@@ -29,16 +29,21 @@ reads from stdin unless a
 .I filename
 is passed.
 .SH OPTIONS
-.IP "\fB\-f\fR, \fB\-\-follow\fP"
+.TP
+.BR \-f , " \-\-follow"
 Output appended data as the file grows.
-.IP "\fB\-o\fR, \fB\-\-output\fP \fIfile\fR
+.TP
+.BR \-o , " \-\-output " \fIfile
 Write command output to \fIfile\fR instead of standard output.
-.IP "\fB\-r\fR, \fB\-\-reverse\fP
+.TP
+.BR \-r , " \-\-reverse"
 Undump, write back edited login information into the utmp or wtmp files.
-.IP "\fB\-h\fR, \fB\-\-help\fP"
-Display help text and exit.
-.IP "\fB\-V\fR, \fB\-\-version\fP"
+.TP
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH NOTES
 .B utmpdump
 can be useful in cases of corrupted utmp or wtmp entries.  It can dump
-- 
1.7.0.4


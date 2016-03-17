Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:59962 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932832AbcCQJjZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 05:39:25 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] chrt: remove duplicate words and tweak some phrasings in the man page
Date: Thu, 17 Mar 2016 10:39:10 +0100
Message-Id: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 schedutils/chrt.1 |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index 5d2057e..51d575b 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -42,41 +42,41 @@ or runs \fIcommand\fR with the given attributes.
 .SH POLICIES
 .TP
 \fB\-o\fR, \fB\-\-other\fR
-Set policy scheduling policy to
+Set scheduling policy to
 .BR SCHED_OTHER .
 This is the default Linux scheduling policy.
 .TP
-\fB\-f\fR, \fB\-\-fifo\fR 
-Set policy scheduling policy to SCHED_FIFO.
+\fB\-f\fR, \fB\-\-fifo\fR
+Set scheduling policy to \fBSCHED_FIFO\fR.
 .TP
 \fB\-r\fR, \fB\-\-rr\fR
 Set scheduling policy to
 .BR SCHED_RR .
-When policy is not defined the
+When no policy is defined, the
 .B SCHED_RR
-is used as default.
+is used as the default.
 .TP
 \fB\-b\fR, \fB\-\-batch\fR
 Set scheduling policy to
 .B SCHED_BATCH
-(Linux-specific, supported since 2.6.16). The priority argument has to be set to zero.
+(Linux-specific, supported since 2.6.16).  The priority argument has to be set to zero.
 .TP
 \fB\-i\fR, \fB\-\-idle\fR
 Set scheduling policy to
 .B SCHED_IDLE
-(Linux-specific, supported since 2.6.23). The priority argument has to be set to zero.
+(Linux-specific, supported since 2.6.23).  The priority argument has to be set to zero.
 .TP
 .BR -d ,\  --deadline
-Set policy scheduling policy to
+Set scheduling policy to
 .BR SCHED_DEADLINE
-(Linux-specific, supported since 3.14). The priority argument has to be set to
-zero. See also \fB\-\-sched\-runtime\fR, \fB\-\-sched\-deadline\fR and
-\fB\-\-sched\-period\fR. The relation between the options required by kernel is
+(Linux-specific, supported since 3.14).  The priority argument has to be set to zero.
+See also \fB\-\-sched\-runtime\fR, \fB\-\-sched\-deadline\fR and
+\fB\-\-sched\-period\fR.  The relation between the options required by the kernel is
 runtime <= deadline <= period.
 .B chrt
-copies \fIperiod\fR to \fIdeadline\fR if \fB\-\-sched\-deadline\fR is no specified and
-\fIdeadline\fR to \fIruntime\fR if \fB\-\-sched\-runtime\fR is no specified. It means at least
-\fB\-\-sched\-period\fR has to be specified. See
+copies \fIperiod\fR to \fIdeadline\fR if \fB\-\-sched\-deadline\fR is not specified and
+\fIdeadline\fR to \fIruntime\fR if \fB\-\-sched\-runtime\fR is not specified.
+It means that at least \fB\-\-sched\-period\fR has to be specified.  See
 .BR sched (7)
 for more details.
 
@@ -146,10 +146,10 @@ Only
 .BR SCHED_OTHER
 and
 .BR SCHED_RR
-are part of POSIX 1003.1b Process Scheduling. The other scheduling attributes
+are part of POSIX 1003.1b Process Scheduling.  The other scheduling attributes
 may be ignored on some systems.
 .P
-Linux default scheduling policy is
+Linux' default scheduling policy is
 .BR SCHED_OTHER .
 .SH SEE ALSO
 .BR taskset (1),
-- 
1.7.0.4


Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:50849 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbaF2PuT (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Jun 2014 11:50:19 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/7] docs: slightly improve wording and formatting in man page of findmnt
Date: Sun, 29 Jun 2014 17:49:41 +0200
Message-Id: <1404056983-10119-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
References: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 misc-utils/findmnt.8 |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 9c87432..ac5d908 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -1,5 +1,5 @@
 .\" -*- nroff -*-
-.TH FINDMNT 8 "April 2010" "util-linux" "System Administration"
+.TH FINDMNT 8 "June 2014" "util-linux" "System Administration"
 .SH NAME
 findmnt \- find a filesystem
 .SH SYNOPSIS
@@ -49,8 +49,8 @@ Use ascii characters for tree formatting.
 Print the SIZE, USED and AVAIL column in bytes rather than in a human-readable format.
 .TP
 .BR \-C , " \-\-nocanonicalize"
-Do not canonicalize paths at all. This option affects paths comparation
-and tags (LABEL, UUID, etc.) evaluation.
+Do not canonicalize paths at all.  This option affects the comparing of paths
+and the evaluation of tags (LABEL, UUID, etc.).
 .TP
 .BR \-c , " \-\-canonicalize"
 Canonicalize all printed paths.
@@ -65,9 +65,9 @@ Use \fB\-\-all\fP to print all filesystems.
 .TP
 .BR \-d , " \-\-direction \fIword\fP"
 The search direction, either
-.IR forward
+.B forward
 or
-.IR backward .
+.BR backward .
 .TP
 .BR \-e , " \-\-evaluate"
 Convert all tags (LABEL, UUID, PARTUUID or PARTLABEL) to the device names.
-- 
1.7.0.4


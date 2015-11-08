Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:56072 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbbKHLHv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2015 06:07:51 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] chfn: improve formatting and wording of the manpage
Date: Sun,  8 Nov 2015 11:54:14 +0100
Message-Id: <1446980055-2749-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
References: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 login-utils/chfn.1 |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index d5210b1..0cb5f28 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -6,7 +6,7 @@
 .\"  modify it under the terms of the GNU General Public License.
 .\"  There is no warranty.
 .\"
-.TH CHFN 1 "July 2014" "util-linux" "User Commands"
+.TH CHFN 1 "November 2015" "util-linux" "User Commands"
 .SH NAME
 chfn \- change your finger information
 .SH SYNOPSIS
@@ -78,21 +78,20 @@ distributed with another package (e.g. shadow-utils).  The following
 configuration items are relevant for
 .BR chfn (1):
 .PP
-.B CHFN_RESTRICT
-(string)
+.BI CHFN_RESTRICT " string"
 .RS 4
 Indicate which fields are changeable by \fBchfn\fR.
 
-The boolean setting "yes" means that Office, Office Phone and Home Phone items
-are changeable and boolean setting "no" means that Full Name, Office, Office
-Phone and Home Phone are changeable.
+The boolean setting \fB"yes"\fR means that only the Office, Office Phone and
+Home Phone fields are changeable, and boolean setting \fB"no"\fR means that
+also the Full Name is changeable.
 
-The another way is to specify changeable fields by abbreviations, f =
-Full Name, r = Office (room), w = Office (work) Phone, h = Home Phone. For
-example CHFN_RESTRICT "wh" allows to change work and home phone numbers.
+Another way to specify changeable fields is by abbreviations: f = Full Name,
+r = Office (room), w = Office (work) Phone, h = Home Phone.  For example,
+\fBCHFN_RESTRICT "wh"\fR allows changing work and home phone numbers.
 
-If the CHFN_RESTRICT is undefined then all finger information are read-only.
-This is default.
+If CHFN_RESTRICT is undefined, then all finger information is read-only.
+This is the default.
 .RE
 .PP
 .SH "EXIT STATUS"
-- 
1.7.0.4


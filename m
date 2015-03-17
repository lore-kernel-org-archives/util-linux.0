Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:51546 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267AbbCQUfY (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 16:35:24 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] hwclock: remove unneeded stuff from the man-page header
Date: Tue, 17 Mar 2015 21:34:52 +0100
Message-Id: <1426624493-2464-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1426624493-2464-1-git-send-email-bensberg@justemail.net>
References: <1426624493-2464-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/hwclock.8.in |   21 +++------------------
 1 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 9682244..145e089 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -1,24 +1,9 @@
 .\" hwclock.8.in -- man page for util-linux' hwclock
 .\"
-.\" 2015-01-07 J William Piggott
-.\" Authored new section: DATE-TIME CONFIGURATION.
-.\" Subsections: Keeping Time..., LOCAL vs UTC, POSIX vs 'RIGHT'.
-.\" Errata and drop outdated language.
-.\" Updates for v2.26
-.\"
-.\"
-.\" -------------------------------
-.\" Included for troff portability.
-.\" Continuation line for .TP header.
-.de TQ
-.  br
-.  ns
-.  TP \\$1\" no doublequotes around argument!
-..
-.
-.\" -------------------------------
+.\" Copyright 1996 Bryan Henderson <bryanh@giraffe-data.com>
+.\" Copyright 2015 J. William Piggott <elseifthen@gmx.com>
 .
-.TH HWCLOCK 8 "January 2015" "util-linux" "System Administration"
+.TH HWCLOCK 8 "March 2015" "util-linux" "System Administration"
 .SH NAME
 hwclock \- read or set the hardware clock (RTC)
 .SH SYNOPSIS
-- 
1.7.0.4


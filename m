Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:53358 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753505AbaHLUPc (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 16:15:32 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] docs: make the man-page licenses of chrt and taskset match their intent
Date: Tue, 12 Aug 2014 22:15:16 +0200
Message-Id: <1407874518-12776-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 schedutils/chrt.1    |    5 ++---
 schedutils/taskset.1 |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index 58c8911..6711fc6 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -3,9 +3,8 @@
 .\" Copyright (C) 2004 Robert Love
 .\"
 .\" This is free documentation; you can redistribute it and/or
-.\" modify it under the terms of the GNU General Public License as
-.\" published by the Free Software Foundation; either version 2 of
-.\" the License.
+.\" modify it under the terms of the GNU General Public License,
+.\" version 2, as published by the Free Software Foundation.
 .\"
 .\" The GNU General Public License's references to "object code"
 .\" and "executables" are to be interpreted as the output of any
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index fb5738c..e6a5624 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -3,9 +3,8 @@
 .\" Copyright (C) 2004 Robert Love
 .\"
 .\" This is free documentation; you can redistribute it and/or
-.\" modify it under the terms of the GNU General Public License as
-.\" published by the Free Software Foundation; either version 2 of
-.\" the License.
+.\" modify it under the terms of the GNU General Public License,
+.\" version 2, as published by the Free Software Foundation.
 .\"
 .\" The GNU General Public License's references to "object code"
 .\" and "executables" are to be interpreted as the output of any
-- 
1.7.0.4


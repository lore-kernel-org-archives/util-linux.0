Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mmjgroup.com ([192.34.35.33]:37549 "EHLO mmjgroup.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575AbXH2NIy (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 29 Aug 2007 09:08:54 -0400
Date: Wed, 29 Aug 2007 07:08:52 -0600
From: LaMont Jones <lamont@mmjgroup.com>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] flock.1: typo in man page
Message-ID: <20070829130852.GA21944@mix.mmjgroup.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is from a user report.

lamont

--opJtzjQTFsWo+cga
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-flock.1-typo-in-man-page.patch"

>From d55e373cf5d4c9e6e39ce847f1563e0c8c5cc193 Mon Sep 17 00:00:00 2001
From: A. Costa <agcosta@gis.net>
Date: Wed, 29 Aug 2007 07:07:10 -0600
Subject: [PATCH] flock.1: typo in man page

Signed-off-by: LaMont Jones <lamont@debian.org>
---
 sys-utils/flock.1 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 3b13efb..237e44c 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -45,7 +45,7 @@ or
 It locks a specified file, which is created (assuming appropriate
 permissions), if it does not already exist.
 .PP
-The second form is conveninent inside shell scripts, and is usually
+The second form is convenient inside shell scripts, and is usually
 used the following manner:
 .PP
 \fC(
-- 
1.5.2.3


--opJtzjQTFsWo+cga--

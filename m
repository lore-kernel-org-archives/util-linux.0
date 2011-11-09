Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:64951 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab1KIMd7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Nov 2011 07:33:59 -0500
Message-ID: <4EBA7332.9060108@bernhard-voelker.de>
Date: Wed, 09 Nov 2011 13:33:54 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] prlimit: fix noheadings option in man page
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

 From caf9bac1607faa0fc3d7fbb47e9b63652c98fa4f Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 9 Nov 2011 12:08:52 +0100
Subject: [PATCH] prlimit: fix noheadings option in man page

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.1 |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index da50987..a42efd9 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -42,7 +42,7 @@ Output version information and exit.
  Vebose mode.
  .IP "\fB\-\-raw\fP"
  Use the raw output format.
-.IP "\fB\-\-nohindings\fP"
+.IP "\fB\-\-noheadings\fP"
  Do not print a header line.
  .IP "\fB\-h, \-\-help\fP"
  Print a help text and exit.
-- 
1.7.3.4

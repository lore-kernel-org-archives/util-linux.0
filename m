Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:58518 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab1KNBsf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:35 -0500
Message-ID: <4EC07371.7080505@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:33 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 09/15] prlimit: fix typo in man page, option --verbose
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 09/15] prlimit: fix typo in man page, option --verbose

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.1 |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index a42efd9..cc40ac4 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -39,7 +39,7 @@ Use \fB\-\-help\fP to  get list of all supported columns.
  .IP "\fB\-V, \-\-version\fP"
  Output version information and exit.
  .IP "\fB\-\-verbose\fP"
-Vebose mode.
+Verbose mode.
  .IP "\fB\-\-raw\fP"
  Use the raw output format.
  .IP "\fB\-\-noheadings\fP"

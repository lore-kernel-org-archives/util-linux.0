Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:64371 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1KNBsq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:46 -0500
Message-ID: <4EC0737D.3090404@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:45 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 12/15] prlimit: add note to man page that setting limits without
 --pid is pointless.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 12/15] prlimit: add note to man page that setting limits without 
--pid is pointless.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.1 |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index cc40ac4..fa45aca 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -33,6 +33,9 @@ OPTIONS section.
  .SH GENERAL OPTIONS
  .IP "\fB\-p, \-\-pid\fP"
  Specify the process id, if none is given, it will use the running process.
+Please note that changing limits without specifying a PID is pointless,
+because then it will change the limit of the prlimit process which will
+shortly exit afterwards.
  .IP "\fB\-o, \-\-output \fIlist\fP"
  Define the output columns to use. If no output arrangement is 
specified, then a default set is used.
  Use \fB\-\-help\fP to  get list of all supported columns.

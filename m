Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:62441 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab1KNBsv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:51 -0500
Message-ID: <4EC07381.6050608@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:49 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 13/15] prlimit: enhance examples section of the man page
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 13/15] prlimit: enhance examples section of the man page

Add various examples to the man page, e.g. demonstrating setting
limits using short options, showing that the --pid option can be
used in random positions, how to use the "-1" notation for the
"unlimited" value, and that prlimit takes the values from the arguments
last set.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.1 |   13 ++++++++++---
  1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index fa45aca..ece6c05 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -88,13 +88,20 @@ Timeout for real-time tasks.
  .SH EXAMPLES
  .IP "\fBprlimit \-\-pid 13134\fP"
  Display limit values for all current resources.
-.IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
+.IP "\fBprlimit \--rss \-\-pid 13134 --nofile=1024:4095\fP"
  Display the limits of the RSS and set the soft and hard limits for the 
amount
  of open files to 1024 and 4095, respectively.
-.IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
+.IP "\fBprlimit \-\-pid 13134 -n512:\fP"
  Modify only the soft limit for the amount of processes.
-.IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
+.IP "\fBprlimit \-\-pid=$$ --nproc=unlimited\fP"
  Set the amount of processes for both soft and ceiling values to unlimited.
+.IP "\fBprlimit \-p$$ -n-1:\fP"
+Likewise, but only for the soft limit and using the "-1" notation.
+.IP "\fBprlimit \-p$$ -n:1000 -n\fP"
+Set the hard NPROC limit to 1000 and display its value.
+.IP "\fBprlimit \-p$$ -n100:200 -n300 -n400: -n:500\fP"
+Example to demonstrate that prlimit uses the values of the options last 
set.
+Here it will set the soft NPROC limit to 400 and the hard limit to 500.

  .SH "SEE ALSO"
  .BR prlimit (2),

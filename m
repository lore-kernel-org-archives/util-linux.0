Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:60710 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab2GCIcG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 3 Jul 2012 04:32:06 -0400
Message-ID: <4FF2AE03.1010507@bernhard-voelker.de>
Date: Tue, 03 Jul 2012 10:32:03 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] utmpdump: document optional filename argument
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The filename argument vanished from usage() in commit v2.21-791-gc8a6af0,
and I found it worthwhile to document the behavior in the man page
when filename is missing (i.e. stdin is used instead).

Have a nice day,
Berny


>From e7c7a6300a20f7fd8f1e2211ac856cbceba740d2 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Tue, 3 Jul 2012 09:42:55 +0200
Subject: [PATCH] utmpdump: document optional filename argument

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 login-utils/utmpdump.1 |    5 ++++-
 login-utils/utmpdump.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 65dfe32..4df49dd 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -21,10 +21,13 @@ utmpdump \- dump UTMP and WTMP files in raw format
 .SH SYNOPSIS
 .B utmpdump
 .RB [ \-frh ]
-.I filename
+.I [ filename ]
 .SH DESCRIPTION
 \fButmpdump\fP is a simple program to dump UTMP and WTMP files
 in raw format, so they can be examined.
+\fButmpdump\fP reads from stdin unless a
+.I filename
+is passed.
 .SH OPTIONS
 .IP "\fB\-f, \-\-follow\fP"
 output appended data as the file grows.
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index ac072d4..fd3e74a 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -190,7 +190,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);

 	fprintf(out,
-		_(" %s [options]\n"), program_invocation_short_name);
+		_(" %s [options] [filename]\n"), program_invocation_short_name);

 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --follow           output appended data as the file grows\n"
-- 
1.7.7


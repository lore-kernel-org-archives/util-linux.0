Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:40878 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940AbaGVWBY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:24 -0400
Received: by mail-we0-f182.google.com with SMTP id k48so280186wev.41
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/10] docs: make logger.1 facilities and levels easier to read
Date: Tue, 22 Jul 2014 23:00:54 +0100
Message-Id: <1406066459-4816-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Most people read vertical list lot quicker than horizontal.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.1 | 59 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index ea1e97d..3228196 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -160,32 +160,51 @@ to start with a hyphen (\-).
 Write this \fImessage\fR to the log; if not specified, and the
 .B \-f
 flag is not provided, standard input is logged.
-.PP
+.SH RETURN VALUE
 The
 .B logger
 utility exits 0 on success, and >0 if an error occurs.
-.PP
+.SH FACILITIES AND LEVELS
 Valid facility names are:
-.IR auth , \ authpriv
-(for security information of a sensitive nature),
-.IR cron , \ daemon , \ ftp , \ kern
-(can't be generated from user process),
-.IR lpr , \ mail , \ news , \ security
-(deprecated synonym for
-.IR auth ), \ syslog , \ user , \ uucp ,
-and
-.IR local0 \ to \ local7 ,
-inclusive.
+.TS
+tab(:);
+left l l.
+\fIauth\fR
+\fIauthpriv\fR:for security information of a sensitive nature
+\fIcron\fR
+\fIdaemon\fR
+\fIftp\fR
+\fIkern\fR:cannot be generated from user process
+\fIlpr\fR
+\fImail\fR
+\fInews\fR
+\fIsyslog\fR
+\fIuser\fR
+\fIuucp\fR
+\fIlocal0\fR
+to
+\fIlocal7\fR
+\fIsecurity\fR:deprecated synonym for \fIauth\fR
+.TE
 .PP
 Valid level names are:
-.IR alert , \ crit , \ debug , \ emerg , \ err , \ error
-(deprecated synonym for
-.IR err ), \ info , \ notice , \ panic
-(deprecated synonym for
-.IR  emerg ), \ warning , \ warn
-(deprecated synonym for
-.IR warning ).
-For the priority order and intended purposes of these levels, see
+.TS
+tab(:);
+left l l.
+\fIemerg\fR
+\fIalert\fR
+\fIcrit\fR
+\fIerr\fR
+\fIwarning\fR
+\fInotice\fR
+\fIinfo\fR
+\fIdebug\fR
+\fIpanic\fR:deprecated synonym for \fIemerg\fR
+\fIerror\fR:deprecated synonym for \fIerr\fR
+\fIwarn\fR:deprecated synonym for \fIwarning\fR
+.TE
+.PP
+For the priority order and intended purposes of these facilities and levels, see
 .BR syslog (3).
 .SH EXAMPLES
 logger System rebooted
-- 
2.0.2


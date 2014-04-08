Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21116 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308AbaDHHsx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:53 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387mqLa011353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:52 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTj004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:52 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/10] last: fix minor typos in the man page
Date: Tue,  8 Apr 2014 09:48:40 +0200
Message-Id: <1396943329-22347-2-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 login-utils/last.1 | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/login-utils/last.1 b/login-utils/last.1
index d0b9744..edaddd1 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -16,7 +16,7 @@
 .\"
 .TH "LAST, LASTB" "1" "October 2013" "util-linux" "User Commands"
 .SH NAME
-last, lastb \- show listing of last logged in users
+last, lastb \- show a listing of last logged in users
 .SH SYNOPSIS
 .B last
 .RI [ options ]
@@ -29,9 +29,9 @@ last, lastb \- show listing of last logged in users
 .RI [ tty ...]
 .SH DESCRIPTION
 .B last
-searches back through the file
+searches back through the
 .B /var/log/wtmp
-(or the file designated by the
+file (or the file designated by the
 .B \-f
 option) and displays a list of all users logged in (and out) since that
 file was created.  One or more
@@ -57,14 +57,14 @@ The pseudo user
 .B reboot
 logs in each time the system is rebooted.  Thus
 .B last reboot
-will show a log of all reboots since the log file was created.
+will show a log of all the reboots since the log file was created.
 .PP
 .B lastb
 is the same as
 .BR last ,
-except that by default it shows a log of the file
-.BR /var/log/btmp ,
-which contains all the bad login attempts.
+except that by default it shows a log of the
+.BR /var/log/btmp
+file, which contains all the bad login attempts.
 .SH OPTIONS
 .TP
 .BR \-a , " \-\-hostlast"
@@ -74,7 +74,7 @@ option.
 .TP
 .BR \-d , " \-\-dns"
 For non-local logins, Linux stores not only the host name of the remote
-host but its IP number as well.  This option translates the IP number
+host, but its IP number as well.  This option translates the IP number
 back into a hostname.
 .TP
 .BR \-f , " \-\-file " \fIfile\fR
@@ -92,29 +92,29 @@ Print full login and logout times and dates.
 .TP
 .BR \-i , " \-\-ip"
 Like
-.B \-\-dns
-but displays the host's IP number instead of name.
+.B \-\-dns ,
+but displays the host's IP number instead of the name.
 .TP
 .BI \- number
 .TQ
 .BR \-n , " -\-limit " \fInumber\fR
-This is a count telling
+Tell
 .B last
 how many lines to show.
 .TP
 .BR \-p , " \-\-present " \fItime\fR
 Display the users who were present at the specified time.  This is
 like using the options
+.BR \-\-since " and " \-\-until
+together with the same \fItime\fR.
 .TP
 .BR \-R , " \-\-nohostname"
 Suppresses the display of the hostname field.
-.BR \-\-since " and " \-\-until
-together with the same \fItime\fR.
 .TP
 .BR \-s , " \-\-since " \fItime\fR
-Display the state of logins since specified
+Display the state of logins since the specified
 .IR time .
-This is useful, e.g., to determine easily who was logged in at a
+This is useful, e.g., to easily determine who was logged in at a
 particular time.  The option is often combined with
 .BR \-\-until .
 .TP
@@ -133,7 +133,7 @@ or
 .IR iso .
 The
 .I notime
-variant will not print any timestamp at all,
+variant will not print any timestamps at all,
 .I short
 is the default, and
 .I full
-- 
1.8.5.1


Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:50069 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbaECCcu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 May 2014 22:32:50 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 20/21] login-utils/last.1: Improve the typesetting of the manual
Date: Sat,  3 May 2014 02:32:38 +0000
Message-Id: <1399084359-28425-4-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
References: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Warning from "groff -b -e -mandoc -t -z -ww < ...":

<standard input>:159: warning: can't find font `t'

  Input file is last.1

###

  Add a space character in front of an ellipsis

  Change '-' to '\-', if it indicates an option

  Change '\-' (minus) to '-' (code "hyphen-minus", rendered with the
glyph hyphen in troff), if it is a part of a compound name.
  A minus is not used in words.  People using UTF-8 and copy-and-paste
can(?) (may?) use "info", "man --ascii" or the command "man" should
have an option to display the '-' ("hyphen-minus") in names of options
with the code (character name) "hyphen-minus" (u002D) instead of
"u2010" (code (character) name "hyphen").

  Change word preferrable
to            preferable

  Change 'left' (causes the warning) to 'l' as a command in a table

  Change '-' to '\-', if it means a minus

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 login-utils/last.1 | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/login-utils/last.1 b/login-utils/last.1
index d0b9744..1398fd1 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -20,13 +20,13 @@ last, lastb \- show listing of last logged in users
 .SH SYNOPSIS
 .B last
 .RI [ options ]
-.RI [ username ...]
-.RI [ tty ...]
+.RI [ username " ...]
+.RI [ tty " ...]
 .br
 .B lastb
 .RI [ options ]
-.RI [ username ...]
-.RI [ tty ...]
+.RI [ username " ...]
+.RI [ tty " ...]
 .SH DESCRIPTION
 .B last
 searches back through the file
@@ -97,7 +97,7 @@ but displays the host's IP number instead of name.
 .TP
 .BI \- number
 .TQ
-.BR \-n , " -\-limit " \fInumber\fR
+.BR \-n , " \-\-limit " \fInumber\fR
 This is a count telling
 .B last
 how many lines to show.
@@ -122,7 +122,7 @@ particular time.  The option is often combined with
 Display the state of logins until the specified
 .IR time .
 .TP
-.BI \-\-time\-format " format"
+.BI \-\-time-format " format"
 Define the output timestamp
 .I format
 to be one of
@@ -142,7 +142,7 @@ is the same as the
 option.  The
 .I iso
 variant will display the timestamp in ISO-8601 format.  The ISO format
-contains timezone information, making it preferrable when printouts are
+contains timezone information, making it preferable when printouts are
 investigated outside of the system.
 .TP
 .BR \-w , " \-\-fullnames"
@@ -155,7 +155,7 @@ The options that take the
 .I time
 argument understand the following formats:
 .TS
-left l2 l.
+l l2 l.
 YYYYMMDDhhmmss
 YYYY-MM-DD hh:mm:ss
 YYYY-MM-DD hh:mm	(seconds will be set to 00)
@@ -167,7 +167,7 @@ yesterday	(time is set to 00:00:00)
 today	(time is set to 00:00:00)
 tomorrow	(time is set to 00:00:00)
 +5min
--5days
+\-5days
 .TE
 .SH NOTES
 The files
-- 
1.9.0


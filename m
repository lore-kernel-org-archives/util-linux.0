Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:56072 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360AbbKHLHw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2015 06:07:52 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/6] logger: sort the options in the manpage alphabetically
Date: Sun,  8 Nov 2015 11:54:11 +0100
Message-Id: <1446980055-2749-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
References: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/logger.1 |   93 +++++++++++++++++++++++++--------------------------
 1 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index dde0f61..d2b3b25 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -113,31 +113,6 @@ to see rest of the fields.
 Sets the RFC5424 MSGID field.  Note that the space character is not permitted
 inside of \fImsgid\fR.  This option is only used if \fB\-\-rfc5424\fR is
 specified as well; otherwise, it is silently ignored.
-
-.TP
-.BR \-\-no\-act
-Causes everything to be done except for writing the log message to the system
-log, and removing the connection or the journal.  This option can be used
-together with \fB\-\-stderr\fR for testing purposes.
-.TP
-.BR \-\-size " \fIsize
-Sets the maximum permitted message size to \fIsize\fR.  The default
-is 1KiB characters, which is the limit traditionally used and specified
-in RFC 3164.  With RFC 5424, this limit has become flexible.  A good assumption
-is that RFC 5424 receivers can at least process 4KiB messages.
-
-Most receivers accept messages larger than 1KiB over any type of syslog
-protocol.  As such, the \fB\-\-size\fR option affects logger in
-all cases (not only when \fB\-\-rfc5424\fR was used).
-
-Note: the message-size limit limits the overall message size, including
-the syslog header.  Header sizes vary depending on the selected options and
-the hostname length.  As a rule of thumb, headers are usually not longer than
-50 to 80 characters.  When selecting a maximum message size, it is important
-to ensure that the receiver supports the max size as well, otherwise messages
-may become truncated.  Again, as a rule of thumb two to four KiB message size
-should generally be OK, whereas anything larger should be verified to work.
-
 .TP
 .BR \-n , " \-\-server " \fIserver
 Write to the specified remote syslog \fIserver\fR
@@ -146,6 +121,16 @@ instead of to the system log socket.  Unless
 is specified, \fBlogger\fR will first try to use UDP,
 but if thist fails a TCP connection is attempted.
 .TP
+.BR \-\-no\-act
+Causes everything to be done except for writing the log message to the system
+log, and removing the connection or the journal.  This option can be used
+together with \fB\-\-stderr\fR for testing purposes.
+.TP
+.B \-\-octet\-count
+Use the RFC 6587 octet counting framing method for sending messages.
+When this option is not used, the default is no framing on UDP, and
+RFC6587 non-transparent framing (also known as octet stuffing) on TCP.
+.TP
 .BR \-P , " \-\-port " \fIport
 Use the specified \fIport\fR.  When this option is not specified, the
 port defaults to syslog for udp and to syslog-conn for tcp connections.
@@ -198,6 +183,9 @@ The RFC 5424 protocol has been the default for
 .B logger
 since version 2.26.
 .TP
+.BR \-s , " \-\-stderr"
+Output the message to standard error as well as to the system log.
+.TP
 .BR "\-\-sd\-id \fIname" [ @\fIdigits ]
 Specifies a structured data element ID for an RFC 5424 message header.  The
 option has to be used before \fB\-\-sd\-param\fR to introduce a new element.
@@ -236,28 +224,24 @@ produces:
 .fi
 .IP
 .TP
-.B \-\-octet\-count
-Use the RFC 6587 octet counting framing method for sending messages.
-When this option is not used, the default is no framing on UDP, and
-RFC6587 non-transparent framing (also known as octet stuffing) on TCP.
-.TP
-.BR \-s , " \-\-stderr"
-Output the message to standard error as well as to the system log.
-.TP
-.BR \-T , " \-\-tcp"
-Use stream (TCP) only.  By default the connection is tried to the
-.I syslog-conn
-port defined in /etc/services, which is often
-.IR 601 .
-.TP
-.BR \-t , " \-\-tag " \fItag
-Mark every line to be logged with the specified
-.IR tag .
-.TP
-.BR \-u , " \-\-socket " \fIsocket
-Write to the specified
-.I socket
-instead of to the system log socket.
+.BR \-\-size " \fIsize
+Sets the maximum permitted message size to \fIsize\fR.  The default
+is 1KiB characters, which is the limit traditionally used and specified
+in RFC 3164.  With RFC 5424, this limit has become flexible.  A good assumption
+is that RFC 5424 receivers can at least process 4KiB messages.
+
+Most receivers accept messages larger than 1KiB over any type of syslog
+protocol.  As such, the \fB\-\-size\fR option affects logger in
+all cases (not only when \fB\-\-rfc5424\fR was used).
+
+Note: the message-size limit limits the overall message size, including
+the syslog header.  Header sizes vary depending on the selected options and
+the hostname length.  As a rule of thumb, headers are usually not longer than
+50 to 80 characters.  When selecting a maximum message size, it is important
+to ensure that the receiver supports the max size as well, otherwise messages
+may become truncated.  Again, as a rule of thumb two to four KiB message size
+should generally be OK, whereas anything larger should be verified to work.
+
 .TP
 .BR \-\-socket\-errors [ =\fImode ]
 Print errors about Unix socket connections.  The \fImode\fR can be a value of
@@ -276,6 +260,21 @@ not communicated and will result to successful return value of
 .BR logger (1)
 invocation.
 .TP
+.BR \-T , " \-\-tcp"
+Use stream (TCP) only.  By default the connection is tried to the
+.I syslog-conn
+port defined in /etc/services, which is often
+.IR 601 .
+.TP
+.BR \-t , " \-\-tag " \fItag
+Mark every line to be logged with the specified
+.IR tag .
+.TP
+.BR \-u , " \-\-socket " \fIsocket
+Write to the specified
+.I socket
+instead of to the system log socket.
+.TP
 .B \-\-
 End the argument list.  This allows the \fImessage\fR
 to start with a hyphen (\-).
-- 
1.7.0.4


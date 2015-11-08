Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:62888 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750716AbbKHLHf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2015 06:07:35 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] logger: improve grammar and formatting of the manpage
Date: Sun,  8 Nov 2015 11:54:10 +0100
Message-Id: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/logger.1 |  103 ++++++++++++++++++++++++++-------------------------
 1 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 81751f2..dde0f61 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -31,7 +31,7 @@
 .\"
 .\"	@(#)logger.1	8.1 (Berkeley) 6/6/93
 .\"
-.TH LOGGER "1" "March 2015" "util-linux" "User Commands"
+.TH LOGGER "1" "November 2015" "util-linux" "User Commands"
 .SH NAME
 logger \- enter messages into the system log
 .SH SYNOPSIS
@@ -52,12 +52,12 @@ Use datagrams (UDP) only.  By default the connection is tried to the
 syslog port defined in /etc/services, which is often 514 .
 .TP
 .BR \-e , " \-\-skip-empty"
-When processing files, empty lines will be ignored. An empty line
-is defined to be a line without any characters. Thus a line consisting
+Ignore empty lines when processing files.  An empty line
+is defined to be a line without any characters.  Thus a line consisting
 only of whitespace is NOT considered empty.
-Note that when the \fR\-\-prio\-prefix\fR option is specified, the priority
-is not part of the line. Thus an empty line in this mode is a line that does
-not have any characters after the priority (e.g. "<13>").
+Note that when the \fB\-\-prio\-prefix\fR option is specified, the priority
+is not part of the line.  Thus an empty line in this mode is a line that does
+not have any characters after the priority prefix (e.g. \fB<13>\fR).
 .TP
 .BR \-f , " \-\-file " \fIfile
 Log the contents of the specified \fIfile\fR.
@@ -72,12 +72,12 @@ argument \fIid\fR is specified, then it is used instead of the logger
 command's PID.  The use of \fB\-\-id=$$\fR
 (PPID) is recommended in scripts that send several messages.
 
-Note that system logging infrastructure (for example systemd when listen on
-/dev/log) may follow local socket credentials to overwrite in the message
-specified PID.
+Note that the system logging infrastructure (for example \fBsystemd\fR when
+listening on /dev/log) may follow local socket credentials to overwrite the
+PID specified in the message.
 .BR logger(1)
-is able to to set the socket credentials to the \fIid\fR if you have
-root permissions and process with the specified PID exists, otherwise
+is able to set those socket credentials to the given \fIid\fR, but only if you
+have root permissions and a process with the specified PID exists, otherwise
 the socket credentials are not modified and the problem is silently ignored.
 .TP
 .BR \-\-journald [ =\fIfile ]
@@ -109,33 +109,33 @@ will display MESSAGE field.  Use
 .B journalctl --output json-pretty
 to see rest of the fields.
 .TP
-.BR \-\-msgid " \fIMSGID
-Sets the RFC5424 MSGID field. Note that the space character is not permitted
-inside of \fIMSGID\fR. This option is only used if \fB\-\-rfc5424\fR is
-specified as well. Otherwise, it is silently ignored.
+.BR \-\-msgid " \fImsgid
+Sets the RFC5424 MSGID field.  Note that the space character is not permitted
+inside of \fImsgid\fR.  This option is only used if \fB\-\-rfc5424\fR is
+specified as well; otherwise, it is silently ignored.
 
 .TP
 .BR \-\-no\-act
-Causes everything to be done except for the write the log message to the system
-log, remove connection or journal. This options is usable together with
-\fB\-\-stderr\fR for testing purpose.
+Causes everything to be done except for writing the log message to the system
+log, and removing the connection or the journal.  This option can be used
+together with \fB\-\-stderr\fR for testing purposes.
 .TP
 .BR \-\-size " \fIsize
-Sets the maximum permitted message size to \fIsize\fR. The default
+Sets the maximum permitted message size to \fIsize\fR.  The default
 is 1KiB characters, which is the limit traditionally used and specified
-in RFC 3164. With RFC 5424, this limit has become flexible. A good assumption
+in RFC 3164.  With RFC 5424, this limit has become flexible.  A good assumption
 is that RFC 5424 receivers can at least process 4KiB messages.
 
-Most receivers accept larger than 1KiB message over any type of syslog
-protocol. As such, the \fB\-\-size\fR option affects logger in
+Most receivers accept messages larger than 1KiB over any type of syslog
+protocol.  As such, the \fB\-\-size\fR option affects logger in
 all cases (not only when \fB\-\-rfc5424\fR was used).
 
-Note: the message size limit limits the overall message size, including
-the syslog header. Header sizes vary depending on options selected and hostname
-length. As a rule of thumb, headers are usually not longer than 50 to 80
-characters. When selecting maximum message size, it is important to ensure
-that the receiver supports the max size as well, otherwise messages may
-become truncated. Again, as a rule of thumb two to four KiB message size
+Note: the message-size limit limits the overall message size, including
+the syslog header.  Header sizes vary depending on the selected options and
+the hostname length.  As a rule of thumb, headers are usually not longer than
+50 to 80 characters.  When selecting a maximum message size, it is important
+to ensure that the receiver supports the max size as well, otherwise messages
+may become truncated.  Again, as a rule of thumb two to four KiB message size
 should generally be OK, whereas anything larger should be verified to work.
 
 .TP
@@ -183,10 +183,11 @@ the following values: \fBnotq\fR, \fBnotime\fR, \fBnohost\fR.
 The \fBnotq\fR value suppresses the time-quality structured data
 from the submitted message.  The time-quality information shows whether
 the local clock was synchronized plus the maximum number of microseconds
-the timestamp might be off. The time-quality is also automatically suppressed when
-\fB\-\-sd\-id timeQuality\fR is specified.
+the timestamp might be off.  The time quality is also automatically
+suppressed when \fB\-\-sd\-id timeQuality\fR is specified.
 
-The \fBnotime\fR value (which implies \fBnotq\fR) suppresses the complete sender timestamp that is in
+The \fBnotime\fR value (which implies \fBnotq\fR)
+suppresses the complete sender timestamp that is in
 ISO-8601 format, including microseconds and timezone.
 
 The \fBnohost\fR value suppresses
@@ -197,25 +198,27 @@ The RFC 5424 protocol has been the default for
 .B logger
 since version 2.26.
 .TP
-.BR "\-\-sd\-id " \fIname[@digits]
-Specifies structured data element ID for RFC 5424 message header. The option
-has to be used before \fB\-\-sd\-param\fR to introduce a new element. The
-number of structured data elements is unlimited. ID is case-sensitive and
-uniquely identify the type and purpose of the element. The same ID must not
-exist more than once in a message. The '@digit' is required for user defined non-standardized
-IDs.
+.BR "\-\-sd\-id \fIname" [ @\fIdigits ]
+Specifies a structured data element ID for an RFC 5424 message header.  The
+option has to be used before \fB\-\-sd\-param\fR to introduce a new element.
+The number of structured data elements is unlimited.  The ID (\fIname\fR plus
+possibly \fB@\fIdigits\fR) is case-sensitive and uniquely identifies the type
+and purpose of the element.  The same ID must not exist more than once in
+a message.  The \fB@\fIdigits\fR part is required for user-defined
+non-standardized IDs.
 
-\fBlogger\fR currently generates \fBtimeQuality\fR standardized element only. RFC
-5424 also describes elements \fBorigin\fR (with params: ip, enterpriseId, software
-and swVersion) and \fBmeta\fR (with params: sequenceId, sysUpTime and language).
-These IDs may be specified without the @digit suffix.
+\fBlogger\fR currently generates the \fBtimeQuality\fR standardized element
+only.  RFC 5424 also describes the elements \fBorigin\fR (with parameters
+ip, enterpriseId, software and swVersion) and \fBmeta\fR (with parameters
+sequenceId, sysUpTime and language).
+These element IDs may be specified without the \fB@\fIdigits\fR suffix.
 
 .TP
-.BR "\-\-sd\-param " \fIname="value"
-Specifies structured data element paramameter name and value. The option has to
-be used after \fB\-\-sd\-id\fR and may be specified more than once for the same
-element. Note that quotation marks are required and must be escaped on command
-line.
+.BR "\-\-sd\-param " \fIname ="\fIvalue\fB"
+Specifies a structured data element paramameter, a name and value pair.
+The option has to be used after \fB\-\-sd\-id\fR and may be specified more
+than once for the same element.  Note that the quotation marks around
+\fIvalue\fR are required and must be escaped on the command line.
 .IP
 .nf
 \fB    logger --rfc5424 --sd-id zoo@123                \\
@@ -234,9 +237,9 @@ produces:
 .IP
 .TP
 .B \-\-octet\-count
-Use the RFC 6587 octet counting framing method for sending messages. When
-this option is not used, the default is no framing on UDP, and RFC6587
-non-transparent-framing (also known as octet stuffing) on TCP.
+Use the RFC 6587 octet counting framing method for sending messages.
+When this option is not used, the default is no framing on UDP, and
+RFC6587 non-transparent framing (also known as octet stuffing) on TCP.
 .TP
 .BR \-s , " \-\-stderr"
 Output the message to standard error as well as to the system log.
-- 
1.7.0.4


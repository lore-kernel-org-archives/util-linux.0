Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:52289 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104AbaLNTqB (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Dec 2014 14:46:01 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/8] docs: adjust the grammar, text, sorting and formatting of logger man page
Date: Sun, 14 Dec 2014 20:45:30 +0100
Message-Id: <1418586333-5342-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
References: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The message argument is not an option and should not be listed among
those.  Describe the optional argument of --rfc5424 better.  Use the
= and no space for optional option arguments.  Don't italicize words
unnecessarily.  Use bold for literal things.  And sort the options
alphabetically (apart from -V and -h).

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/logger.1 |  258 +++++++++++++++++++++++----------------------------
 1 files changed, 116 insertions(+), 142 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 2a3b47c..197bb38 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -33,171 +33,145 @@
 .\"
 .\" Section on valid facility and level strings added by
 .\" and1000@debian.org, 26 Oct 1997.
-.TH LOGGER "1" "June 2014" "util-linux" "User Commands"
+.\"
+.TH LOGGER "1" "December 2014" "util-linux" "User Commands"
 .SH NAME
-logger \- a shell command interface to the syslog(3) system log module
+logger \- enter messages into the system log
 .SH SYNOPSIS
 .B logger
 [options]
 .RI [ message ]
 .SH DESCRIPTION
 .B logger
-makes entries in the system log.  It provides a shell command
+makes entries in the system log.  It provides a shell-command
 interface to the
 .BR syslog (3)
 system log module.
+.sp
+When the optional \fImessage\fR argument is present, it is written
+to the log.  If it is not present, and the \fB\-f\fR option is not
+given either, then standard input is logged.
 .SH OPTIONS
 .TP
-\fB\-d\fR, \fB\-\-udp\fR
-Use datagram (UDP) only.  By default the connection is tried to the
-.I syslog
-port defined in /etc/services, which is often
-.IR 514 .
+.BR \-d , " \-\-udp"
+Use datagrams (UDP) only.  By default the connection is tried to the
+syslog port defined in /etc/services, which is often 514 .
 .TP
-\fB\-h\fR, \fB\-\-help\fR
-Display help text and exit.
+.BR \-f , " \-\-file " \fIfile
+Log the contents of the specified \fIfile\fR.
+This option cannot be combined with a command-line message.
 .TP
-\fB\-i\fR, \fB\-\-id\fR[=\fBid\fR]
-Log the PID of the logger process with each line.  When optional
-argument
-.B id
-is specified then it is used instead of logger command PID.  Use of
-.B --id=$$
+.BR \-i , " \-\-id" [ = \fIid ]
+Log the PID of the logger process with each line.  When the optional
+argument \fIid\fR is specified, then it is used instead of the logger
+command's PID.  The use of \fB\-\-id=$$\fR
 (PPID) is recommended in scripts that send several messages.
 .TP
-\fB\-n\fR, \fB\-\-server\fR \fIserver\fR
-Write to the specified remote syslog
-.I server
+.BR \-\-journald [ =\fIfile ]
+Write a systemd journal entry.  The entry is read from the given \fIfile\fR,
+when specified, otherwise from standard input.
+Each line must begin with a field that is accepted by journald; see
+.BR systemd.journal-fields (7)
+for details.  The use of a MESSAGE_ID field is generally a good idea, as it
+makes finding entries easy.  Examples:
+.IP
+.nf
+\fB    printf \(dq%s\\n%s\\n%s\\n\(dq MESSAGE_ID=42 DOGS=bark \(dqCARAVAN=goes on\(dq | logger --journald
+\fB    logger --journald=entry.txt
+.fi
+.IP
+Notice that
+.B \-\-journald
+will ignore values of other options, such as priority.  If priority is
+needed it must be within input, and use PRIORITY field.  The simple
+execution of
+.B journalctl
+will display MESSAGE field.  Use
+.B journalctl --output json-pretty
+to see rest of the fields.
+
+.TP
+.BR \-n , " \-\-server " \fIserver
+Write to the specified remote syslog \fIserver\fR
 instead of to the builtin syslog routines.  Unless
-.B \-\-udp
-or
-.B \-\-tcp
+\fB\-\-udp\fR or \fB\-\-tcp\fR
 is specified, \fBlogger\fR will first try to use UDP,
 but if thist fails a TCP connection is attempted.
 .TP
-\fB\-P\fR, \fB\-\-port\fR \fIport\fR
-Use the specified
-.IR port .
-When
-.I port
-is not specified it defaults to
-.I syslog
-for udp and
-.I syslog-conn
-for tcp connections.
-.TP
-\fB\-f\fR, \fB\-\-file\fR \fIfile\fR
-Log the contents of the specified
-.IR file .
-This option cannot be combined with a command-line message.
+.BR \-P , " \-\-port " \fIport
+Use the specified \fIport\fR.  When this option is not specified, the
+port defaults to syslog for udp and to syslog-conn for tcp connections.
 .TP
-\fB\-p\fR, \fB\-\-priority\fR \fIpriority\fR
-Enter the message into the log with the specified
-.IR priority  .
+.BR \-p , " \-\-priority " \fIpriority
+Enter the message into the log with the specified \fIpriority\fR.
 The priority may be specified numerically or as a
-.I facility.level
+.IR facility . level
 pair.
-For example,
-.B -p
-.I local3.info
+For example, \fB\-p local3.info\fR
 logs the message as informational in the local3 facility.
-The default is
-.IR user.notice .
+The default is \fBuser.notice\fR.
 .TP
-\fB\-\-prio\-prefix\fR
+.B \-\-prio-prefix
 Look for a syslog prefix on every line read from standard input.
-This prefix is a number within angle brackets that contains both the facility
-and the level.  This decimal prefix is constructed by multiplying the
-facility by 8 and then adding the level.  Thus, for example, \fIlocal0.info\fR,
-facility=16 and level=6, becomes \fI<134>\fR.
-
+This prefix is a decimal number within angle brackets that encodes both
+the facility and the level.  The number is constructed by multiplying the
+facility by 8 and then adding the level.  For example, \fBlocal0.info\fR,
+meaning facility=16 and level=6, becomes \fB<134>\fR.
+.sp
 If the prefix contains no facility, the facility defaults to what is
 specified by the \fB\-p\fR option.  Similarly, if no prefix is provided,
-the line is logged using the \fB\-p\fR \fIpriority\fR.
-
+the line is logged using the \fIpriority\fR given with \fB\-p\fR.
+.sp
 This option doesn't affect a command-line message.
-
-.TP
-\fB\-\-rfc3164\fR
-Use RFC 3164 BSD syslog protocol to submit messages to remote server.
 .TP
-\fB\-\-rfc5424\fR [\fInotime\fR,\fInotq\fR,\fInohost\fR]
-Use RFC 5424 syslog protocol to submit messages to remote server.
-Optional argument
-.I notime
-will suppress submission of sender time stamp that is in ISO-8601 format,
-including microseconds and timezone.  When
-.I notime
-is specified the time quality structured data, that can be suppressed
-separately with
-.IR notq ,
-is excluded from output.  The time quality information tells if local
-clock was syncronized, and maximum number of microseconds the time stamp
-could be off.  Option argument
-.I nohost
-will suppress
-.IR gethostname (2)
-information from message header.
+.B \-\-rfc3164
+Use the RFC 3164 BSD syslog protocol to submit messages to a remote server.
+.TP
+.BR \-\-rfc5424 [ =\fIwithout ]
+Use the RFC 5424 syslog protocol to submit messages to a remote server.
+The optional \fIwithout\fR argument can be a comma-separated list of
+the following values: \fBnotq\fR, \fBnotime\fR, \fBnohost\fR.
+The \fBnotq\fR value suppresses the time-quality structured data
+from the submitted message.  (The time-quality information shows whether
+the local clock was syncronized plus the maximum number of microseconds
+the timestamp might be off.)  The \fBnotime\fR value (which implies
+\fBnotq\fR) suppresses the complete sender timestamp that is in
+ISO-8601 format, including microseconds and timezone.
+The \fBnohost\fR value suppresses
+.BR gethostname (2)
+information from the message header.
 .IP
 The rfc5424 protocol has been default for
 .B logger
 since version 2.26.
 .TP
-\fB\-s\fR, \fB\-\-stderr\fR
+.BR \-s , " \-\-stderr"
 Output the message to standard error as well as to the system log.
 .TP
-\fB\-T\fR, \fB\-\-tcp\fR
+.BR \-T , " \-\-tcp"
 Use stream (TCP) only.  By default the connection is tried to the
 .I syslog-conn
 port defined in /etc/services, which is often
 .IR 601 .
 .TP
-\fB\-t\fR, \fB\-\-tag\fR \fItag\fR
+.BR \-t , " \-\-tag " \fItag
 Mark every line to be logged with the specified
 .IR tag .
 .TP
-\fB\-u\fR, \fB\-\-socket\fR \fIsocket\fR
+.BR \-u , " \-\-socket " \fIsocket
 Write to the specified
 .I socket
 instead of to the builtin syslog routines.
 .TP
-\fB\-\-journald\fR [\fIfile\fR]
-Write systemd journal entry.  The entry is read from
-.I stdin
-or input
-.IR file .
-Each new line must begin with a field that is accepted by journald, see
-.IR systemd.journal-fields (7)
-for details.  Use of MESSAGE_ID field is generally good idea, as they
-make finding entries easy.
-.IP
-.nf
-$ printf "%s\\n%s\\n%s\\n" MESSAGE_ID=86184c3b1aa444f58ebe7b30fec1438b DOGS=bark "CARAVAN=goes on" | logger --journald
-$ logger --journald=entry.txt
-.fi
-.IP
-Notice that
-.B \-\-journald
-will ignore values of other options, such as priority.  If priority is
-needed it must be within input, and use PRIORITY field.  The simple
-execution of
-.B journalctl
-will display MESSAGE field.  Use
-.B journalctl --output json-pretty
-to see rest of the fields.
+.B \-\-
+End the argument list.  This allows the \fImessage\fR
+to start with a hyphen (\-).
 .TP
-\fB\-V\fR, \fB\-\-version\fR
+.BR \-V , " \-\-version"
 Display version information and exit.
 .TP
-\fB\-\-\fR
-End the argument list.  This is to allow the
-.I message
-to start with a hyphen (\-).
-.TP
-.I message
-Write this \fImessage\fR to the log; if not specified, and the
-.B \-f
-flag is not provided, standard input is logged.
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH RETURN VALUE
 The
 .B logger
@@ -208,22 +182,22 @@ Valid facility names are:
 .TS
 tab(:);
 left l l.
-\fIauth\fR
-\fIauthpriv\fR:for security information of a sensitive nature
-\fIcron\fR
-\fIdaemon\fR
-\fIftp\fR
-\fIkern\fR:cannot be generated from user process
-\fIlpr\fR
-\fImail\fR
-\fInews\fR
-\fIsyslog\fR
-\fIuser\fR
-\fIuucp\fR
-\fIlocal0\fR
+\fBauth
+\fBauthpriv\fR:for security information of a sensitive nature
+\fBcron
+\fBdaemon
+\fBftp
+\fBkern\fR:cannot be generated from user process
+\fBlpr
+\fBmail
+\fBnews
+\fBsyslog
+\fBuser
+\fBuucp
+\fBlocal0
   to:
-\fIlocal7\fR
-\fIsecurity\fR:deprecated synonym for \fIauth\fR
+\fBlocal7
+\fBsecurity\fR:deprecated synonym for \fBauth
 .TE
 .PP
 Valid level names are:
@@ -231,27 +205,27 @@ Valid level names are:
 .TS
 tab(:);
 left l l.
-\fIemerg\fR
-\fIalert\fR
-\fIcrit\fR
-\fIerr\fR
-\fIwarning\fR
-\fInotice\fR
-\fIinfo\fR
-\fIdebug\fR
-\fIpanic\fR:deprecated synonym for \fIemerg\fR
-\fIerror\fR:deprecated synonym for \fIerr\fR
-\fIwarn\fR:deprecated synonym for \fIwarning\fR
+\fBemerg
+\fBalert
+\fBcrit
+\fBerr
+\fBwarning
+\fBnotice
+\fBinfo
+\fBdebug
+\fBpanic\fR:deprecated synonym for \fBemerg
+\fBerror\fR:deprecated synonym for \fBerr
+\fBwarn\fR:deprecated synonym for \fBwarning
 .TE
 .PP
 For the priority order and intended purposes of these facilities and levels, see
 .BR syslog (3).
 .SH EXAMPLES
-logger System rebooted
+.B logger System rebooted
 .br
-logger \-p local0.notice \-t HOSTIDM \-f /dev/idmc
+.B logger \-p local0.notice \-t HOSTIDM \-f /dev/idmc
 .br
-logger \-n loghost.example.com System rebooted
+.B logger \-n loghost.example.com System rebooted
 .SH SEE ALSO
 .BR syslog (3),
 .BR syslogd (8),
-- 
1.7.0.4


Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:61879 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbaGVWBw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:52 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so284889wes.23
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Kodiak Firesmith <ksf@sei.cmu.edu>
Subject: [PATCH 08/10] docs: add logger protocol notes to manual page
Date: Tue, 22 Jul 2014 23:00:57 +0100
Message-Id: <1406066459-4816-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Inform about rfc5424 support, how to control what it includes to
submission, and that it is the new default when sending syslog messages
to remote server without specifying protocol.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/logger |  2 +-
 misc-utils/logger.1    | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/bash-completion/logger b/bash-completion/logger
index 6b4c7df..0a66af3 100644
--- a/bash-completion/logger
+++ b/bash-completion/logger
@@ -37,7 +37,7 @@ _logger_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="--journald --udp --id --file --help --server --port --priority --stderr --tag --socket --version"
+			OPTS="--journald --udp --id --file --help --server --port --priority --rfc3164 --rfc5424 --stderr --tag --socket --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 3228196..214e870 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -33,7 +33,7 @@
 .\"
 .\" Section on valid facility and level strings added by
 .\" and1000@debian.org, 26 Oct 1997.
-.TH LOGGER "1" "April 2013" "util-linux" "User Commands"
+.TH LOGGER "1" "June 2014" "util-linux" "User Commands"
 .SH NAME
 logger \- a shell command interface to the syslog(3) system log module
 .SH SYNOPSIS
@@ -104,6 +104,32 @@ specified by the \fB\-p\fR option.  Similarly, if no prefix is provided,
 the line is logged using the \fB\-p\fR \fIpriority\fR.
 
 This option doesn't affect a command-line message.
+
+.TP
+\fB\-\-rfc3164\fR
+Use RFC 3164 BSD syslog protocol to submit messages to remote server.
+.TP
+\fB\-\-rfc5424\fR [\fInotime\fR,\fInotq\fR,\fInohost\fR]
+Use RFC 5424 syslog protocol to submit messages to remote server.
+Optional argument
+.I notime
+will supress submission of sender time stamp that is in ISO-8601 format,
+including microseconds and timezone.  When
+.I notime
+is specified the time quality structured data, that can be suppressed
+separately with
+.IR notq ,
+is excluded from output.  The time quality information tells if local
+clock was syncronized, and maximum number of microseconds the time stamp
+could be off.  Option argument
+.I nohost
+will suppress
+.IR gethostname (2)
+information from message header.
+.IP
+The rfc5424 protocol has been default for
+.B logger
+since version 2.26.
 .TP
 \fB\-s\fR, \fB\-\-stderr\fR
 Output the message to standard error as well as to the system log.
-- 
2.0.2


Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36935 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbDFVu4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Apr 2015 17:50:56 -0400
Received: by wiaa2 with SMTP id a2so161861wia.0
        for <util-linux@vger.kernel.org>; Mon, 06 Apr 2015 14:50:55 -0700 (PDT)
Date: Mon, 6 Apr 2015 22:50:46 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Patrick Plagwitz <patrick.plagwitz@fau.de>
cc: util-linux@vger.kernel.org
Subject: Re: logger: Segmentation fault when reading from stdin and writing
 to socket
In-Reply-To: <5521E92D.2090404@fau.de>
Message-ID: <alpine.LNX.2.03.1504062226540.593@iki.fi>
References: <5521E92D.2090404@fau.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 6 Apr 2015, Patrick Plagwitz wrote:

> I have noticed a bug within the development version of the logger
> utility (misc-utils/logger.c).
> When reading messages from stdin (so that logger_stdin is called) and
> outputting to a TCP/UDP socket (inet_socket) logger SEGFAULTs:
> 
> $ echo foo | logger -n localhost
> Segmentation fault (core dumped)
> 
> This bug happens because, in this combination, the syslog header isn't
> generated before calling strlen() on it and has probably been introduced
> somewhere when separating writing the header and writing the message.
> Calling generate_syslog_header in logger_open also for inet sockets
> fixes this.
> The attached patch does just that.
> 
> On an unrelated note, the write_output function leaks memory by not
> freeing the buf local variable.

Hi Patrick and others,

The below appears to fix the issue. And this reminds me logger(1) ought to 
have 'remote' logging tests writing to netcat(1) server.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 6 Apr 2015 22:42:54 +0100
Subject: [PATCH] logger: generate header when reading message from stdin

This change fixes crashing error, that ought not to be simply avoided.

$ echo foo | logger -n localhost
Segmentation fault (core dumped)

If the ctl->hdr is just checked not to be NULL syslog message will not
have valid header, so generating such is not optional when reading
message from stdin and writing it to remote destination.

Reported-by: Patrick Plagwitz <patrick.plagwitz@fau.de>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index edc9483..753cd7f 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -582,14 +582,14 @@ static void logger_open(struct logger_ctl *ctl)
 		ctl->fd = inet_socket(ctl->server, ctl->port, ctl->socket_type);
 		if (!ctl->syslogfp)
 			ctl->syslogfp = syslog_rfc5424_header;
-		return;
-	}
-	if (!ctl->unix_socket)
-		ctl->unix_socket = _PATH_DEVLOG;
+	} else {
+		if (!ctl->unix_socket)
+			ctl->unix_socket = _PATH_DEVLOG;
 
-	ctl->fd = unix_socket(ctl, ctl->unix_socket, ctl->socket_type);
-	if (!ctl->syslogfp)
-		ctl->syslogfp = syslog_local_header;
+		ctl->fd = unix_socket(ctl, ctl->unix_socket, ctl->socket_type);
+		if (!ctl->syslogfp)
+			ctl->syslogfp = syslog_local_header;
+	}
 	if (!ctl->tag)
 		ctl->tag = xgetlogin();
 	generate_syslog_header(ctl);
-- 
2.3.5


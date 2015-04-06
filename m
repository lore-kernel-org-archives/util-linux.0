Return-Path: util-linux-owner@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:46590 "EHLO
	mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752626AbbDFCHw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 Apr 2015 22:07:52 -0400
Received: from boeck2.rrze.uni-erlangen.de (boeck2.rrze.uni-erlangen.de [131.188.11.32])
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 3lKw9V4bNJzCdm2
	for <util-linux@vger.kernel.org>; Mon,  6 Apr 2015 04:02:22 +0200 (CEST)
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21])
	by boeck2.rrze.uni-erlangen.de (boeck2.rrze.uni-erlangen.de [131.188.11.32]) (amavisd-new, port 10026)
	with LMTP id 7-EpFdpfDdYr for <util-linux@vger.kernel.org>;
	Mon,  6 Apr 2015 04:02:21 +0200 (CEST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 3lKw9T6SbczCdls
	for <util-linux@vger.kernel.org>; Mon,  6 Apr 2015 04:02:21 +0200 (CEST)
Received: from [192.168.178.24] (p5B0ED07C.dip0.t-ipconnect.de [91.14.208.124])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX198U9wOfhU8lFvMaIWkcPP8rqX5UGSz1PQ=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 3lKw9T5hbGzDbG2
	for <util-linux@vger.kernel.org>; Mon,  6 Apr 2015 04:02:21 +0200 (CEST)
Message-ID: <5521E92D.2090404@fau.de>
Date: Mon, 06 Apr 2015 04:02:21 +0200
From: Patrick Plagwitz <patrick.plagwitz@fau.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: logger: Segmentation fault when reading from stdin and writing to
 socket
Content-Type: multipart/mixed;
 boundary="------------090505070702040703080200"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090505070702040703080200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

I have noticed a bug within the development version of the logger
utility (misc-utils/logger.c).
When reading messages from stdin (so that logger_stdin is called) and
outputting to a TCP/UDP socket (inet_socket) logger SEGFAULTs:

$ echo foo | logger -n localhost
Segmentation fault (core dumped)

This bug happens because, in this combination, the syslog header isn't
generated before calling strlen() on it and has probably been introduced
somewhere when separating writing the header and writing the message.
Calling generate_syslog_header in logger_open also for inet sockets
fixes this.
The attached patch does just that.

On an unrelated note, the write_output function leaks memory by not
freeing the buf local variable.

Patrick

--------------090505070702040703080200
Content-Type: text/x-patch;
 name="patch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="patch.diff"

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index edc9483..fbe8ced 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -582,14 +582,15 @@ static void logger_open(struct logger_ctl *ctl)
 		ctl->fd =3D inet_socket(ctl->server, ctl->port, ctl->socket_type);
 		if (!ctl->syslogfp)
 			ctl->syslogfp =3D syslog_rfc5424_header;
-		return;
+	} else {
+		if (!ctl->unix_socket)
+			ctl->unix_socket =3D _PATH_DEVLOG;
+
+		ctl->fd =3D unix_socket(ctl, ctl->unix_socket, ctl->socket_type);
+		if (!ctl->syslogfp)
+			ctl->syslogfp =3D syslog_local_header;
 	}
-	if (!ctl->unix_socket)
-		ctl->unix_socket =3D _PATH_DEVLOG;
=20
-	ctl->fd =3D unix_socket(ctl, ctl->unix_socket, ctl->socket_type);
-	if (!ctl->syslogfp)
-		ctl->syslogfp =3D syslog_local_header;
 	if (!ctl->tag)
 		ctl->tag =3D xgetlogin();
 	generate_syslog_header(ctl);

--------------090505070702040703080200--

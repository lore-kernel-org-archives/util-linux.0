Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E548DC433EF
	for <util-linux@archiver.kernel.org>; Thu, 13 Jan 2022 23:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiAMX2U (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 13 Jan 2022 18:28:20 -0500
Received: from 139-28-40-42.artus.net.pl ([139.28.40.42]:37098 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S238190AbiAMX2T (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 13 Jan 2022 18:28:19 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 676492794;
        Fri, 14 Jan 2022 00:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1642116492;
        bh=ig02mGS5f7uAAjqlm0wRY2s7xHE61zUl5+SlI56+D3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewGIWZ9rx/2xaijnPZ9JfDX6QtOUyOYKqUbqkmofRcknfqn1BNBIQ719XIfVGSeKm
         3wjQnHSH3lYAHaxRqB5fvwQhMPNnDxFwJ1UP6QlOw3qWg9FDqdlth41QOARJ27P7PU
         DX9yTn2fakXEystnUCG9nRV20sRE8ekfupmyVZaKJcUvBKN33pfSkY6lFckvaPyiVJ
         3SHEyrmt03vNvKs1oxAQ3/kK3xvCVTX0Ag3nqUztehCKA8iTir+1u1oBEvhqEmqHkw
         r3G3A+mC+SxHB8Ht1a12/tflZcXU7RYjfP3aTd2K5U8+lE+rmS03I1lD10wCLFaGaq
         0kBfRod9YfL3g==
Date:   Fri, 14 Jan 2022 00:28:11 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     1003095@bugs.debian.org
Cc:     Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
Mail-Followup-To: 1003095@bugs.debian.org,
        Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
 <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37hu7inoc47cczft"
Content-Disposition: inline
In-Reply-To: <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--37hu7inoc47cczft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Control: tag -1 + patch

Hi!

See scissor-patch, below, which fixes this.

I tortured it a bit and ironed out all the problems I could find;
both script and test_pty work (well, test_pty still doesn't process
newlines properly but it was like that when I found it).

Best,
=D0=BD=D0=B0=D0=B1

-- >8 --
Subject: Put master PTY into non-blocking mode and buffer its output
 to avoid deadlock

If we filled the script->child buffer before the child had a chance
to read any input, we'd sleep forever in write_all(pty->master),
and the child would sleep forever in write(1<pty->slave>)

By putting the master PTY in non-blocking mode, we can
poll(pty->master, POLLOUT) and keep supplying more data
as the child reads from the buffer

Fixes Debian bug #1003095
---
pty-session.h: +7
pty-session.c: +90 -23

--- util-linux-2.37.2.orig/include/pty-session.h
+++ util-linux-2.37.2/include/pty-session.h
@@ -81,6 +81,13 @@ struct ul_pty {
=20
 	struct timeval	next_callback_time;
=20
+	struct ul_pty_child_buffer {
+		struct ul_pty_child_buffer *next;
+		char buf[BUFSIZ];
+		size_t size, cursor;
+		unsigned int final_input:1;	/* drain child before writing */
+	} *child_buffer_head, *child_buffer_tail;
+
 	unsigned int isterm:1,		/* is stdin terminal? */
 		     slave_echo:1;	/* keep ECHO on pty slave */
 };
--- util-linux-2.37.2.orig/lib/pty-session.c
+++ util-linux-2.37.2/lib/pty-session.c
@@ -69,6 +69,10 @@ struct ul_pty *ul_new_pty(int is_stdin_t
=20
 void ul_free_pty(struct ul_pty *pty)
 {
+	for(struct ul_pty_child_buffer *hd; (hd =3D pty->child_buffer_head);) {
+		pty->child_buffer_head =3D hd->next;
+		free(hd);
+	}
 	free(pty);
 }
=20
@@ -182,7 +186,7 @@ int ul_pty_setup(struct ul_pty *pty)
 		cfmakeraw(&attrs);
 		tcsetattr(STDIN_FILENO, TCSANOW, &attrs);
 	} else {
-	        DBG(SETUP, ul_debugobj(pty, "create for non-terminal"));
+		DBG(SETUP, ul_debugobj(pty, "create for non-terminal"));
=20
 		rc =3D openpty(&pty->master, &pty->slave, NULL, NULL, NULL);
 		if (rc)
@@ -198,6 +202,8 @@ int ul_pty_setup(struct ul_pty *pty)
 		tcsetattr(pty->slave, TCSANOW, &attrs);
 	}
=20
+	fcntl(pty->master, F_SETFL, O_NONBLOCK);
+
 	sigfillset(&ourset);
 	if (sigprocmask(SIG_BLOCK, &ourset, NULL)) {
 		rc =3D -errno;
@@ -290,9 +296,21 @@ static int write_output(char *obuf, ssiz
 	return 0;
 }
=20
-static int write_to_child(struct ul_pty *pty, char *buf, size_t bufsz)
+static int schedule_child_write(struct ul_pty *pty, char *buf, size_t bufs=
z, int final)
 {
-	return write_all(pty->master, buf, bufsz);
+	struct ul_pty_child_buffer *stash =3D calloc(1, sizeof(*stash));
+	if (!stash)
+		return -1;
+
+	memcpy(stash->buf, buf, bufsz);
+	stash->size =3D bufsz;
+	stash->final_input =3D final ? 1 : 0;
+
+	if (pty->child_buffer_head)
+		pty->child_buffer_tail =3D pty->child_buffer_tail->next =3D stash;
+	else
+		pty->child_buffer_head =3D pty->child_buffer_tail =3D stash;
+	return 0;
 }
=20
 /*
@@ -311,16 +329,13 @@ static int write_to_child(struct ul_pty
  * maintains master+slave tty stuff within the session. Use pipe to write =
to
  * pty and assume non-interactive (tee-like) behavior is NOT well supporte=
d.
  */
-void ul_pty_write_eof_to_child(struct ul_pty *pty)
+static void drain(struct ul_pty *pty)
 {
 	unsigned int tries =3D 0;
-	struct pollfd fds[] =3D {
-	           { .fd =3D pty->slave, .events =3D POLLIN }
-	};
-	char c =3D DEF_EOF;
+	struct pollfd fd =3D { .fd =3D pty->slave, .events =3D POLLIN };
=20
 	DBG(IO, ul_debugobj(pty, " waiting for empty slave"));
-	while (poll(fds, 1, 10) =3D=3D 1 && tries < 8) {
+	while (poll(&fd, 1, 10) =3D=3D 1 && tries < 8) {
 		DBG(IO, ul_debugobj(pty, "   slave is not empty"));
 		xusleep(250000);
 		tries++;
@@ -329,7 +344,51 @@ void ul_pty_write_eof_to_child(struct ul
 		DBG(IO, ul_debugobj(pty, "   slave is empty now"));
=20
 	DBG(IO, ul_debugobj(pty, " sending EOF to master"));
-	write_to_child(pty, &c, sizeof(char));
+}
+
+static int flush_child_buffers(struct ul_pty *pty, int *anything)
+{
+	int ret =3D 0, any =3D 0;
+	while (pty->child_buffer_head) {
+		struct ul_pty_child_buffer *hd =3D pty->child_buffer_head;
+
+		if(hd->final_input)
+			drain(pty);
+
+		DBG(IO, ul_debugobj(hd, " stdin --> master trying %zu bytes", hd->size -=
 hd->cursor));
+		ssize_t ret =3D write(pty->master, hd->buf + hd->cursor, hd->size - hd->=
cursor);
+		if (ret =3D=3D -1) {
+			DBG(IO, ul_debugobj(hd, "   EAGAIN"));
+			if (!(errno =3D=3D EINTR || errno =3D=3D EAGAIN))
+				ret =3D -errno;
+			goto out;
+		}
+		DBG(IO, ul_debugobj(hd, "   wrote %zd", ret));
+		any =3D 1;
+		hd->cursor +=3D ret;
+		if (hd->cursor =3D=3D hd->size) {
+			pty->child_buffer_head =3D hd->next;
+			if(!hd->next)
+				pty->child_buffer_tail =3D NULL;
+			free(hd);
+		}
+	}
+
+out:
+	/* without sync write_output() will write both input &
+	 * shell output that looks like double echoing */
+	if (any)
+		fdatasync(pty->master);
+
+	if (anything)
+		*anything =3D any;
+	return ret;
+}
+
+void ul_pty_write_eof_to_child(struct ul_pty *pty)
+{
+	char c =3D DEF_EOF;
+	schedule_child_write(pty, &c, sizeof(char), 1);
 }
=20
 static int mainloop_callback(struct ul_pty *pty)
@@ -362,7 +421,7 @@ static int handle_io(struct ul_pty *pty,
 	/* read from active FD */
 	bytes =3D read(fd, buf, sizeof(buf));
 	sigprocmask(SIG_BLOCK, &set, NULL);
-	if (bytes < 0) {
+	if (bytes =3D=3D -1) {
 		if (errno =3D=3D EAGAIN || errno =3D=3D EINTR)
 			return 0;
 		return -errno;
@@ -375,15 +434,11 @@ static int handle_io(struct ul_pty *pty,
=20
 	/* from stdin (user) to command */
 	if (fd =3D=3D STDIN_FILENO) {
-		DBG(IO, ul_debugobj(pty, " stdin --> master %zd bytes", bytes));
+		DBG(IO, ul_debugobj(pty, " stdin --> master %zd bytes queued", bytes));
=20
-		if (write_to_child(pty, buf, bytes))
+		if (schedule_child_write(pty, buf, bytes, 0))
 			return -errno;
=20
-		/* without sync write_output() will write both input &
-		 * shell output that looks like double echoing */
-		fdatasync(pty->master);
-
 	/* from command (master) to stdout */
 	} else if (fd =3D=3D pty->master) {
 		DBG(IO, ul_debugobj(pty, " master --> stdout %zd bytes", bytes));
@@ -567,6 +622,11 @@ int ul_pty_proxy_master(struct ul_pty *p
 		} else
 			timeout =3D pty->poll_timeout;
=20
+		if (pty->child_buffer_head)
+			pfd[POLLFD_MASTER].events |=3D POLLOUT;
+		else
+			pfd[POLLFD_MASTER].events &=3D ~POLLOUT;
+
 		/* wait for input, signal or timeout */
 		DBG(IO, ul_debugobj(pty, "calling poll() [timeout=3D%dms]", timeout));
 		ret =3D poll(pfd, ARRAY_SIZE(pfd), timeout);
@@ -600,23 +660,30 @@ int ul_pty_proxy_master(struct ul_pty *p
 			if (pfd[i].revents =3D=3D 0)
 				continue;
=20
-			DBG(IO, ul_debugobj(pty, " active pfd[%s].fd=3D%d %s %s %s %s",
+			DBG(IO, ul_debugobj(pty, " active pfd[%s].fd=3D%d %s %s %s %s %s",
 						i =3D=3D POLLFD_STDIN  ? "stdin" :
 						i =3D=3D POLLFD_MASTER ? "master" :
 						i =3D=3D POLLFD_SIGNAL ? "signal" : "???",
 						pfd[i].fd,
 						pfd[i].revents & POLLIN  ? "POLLIN" : "",
+						pfd[i].revents & POLLOUT ? "POLLOUT" : "",
 						pfd[i].revents & POLLHUP ? "POLLHUP" : "",
 						pfd[i].revents & POLLERR ? "POLLERR" : "",
 						pfd[i].revents & POLLNVAL ? "POLLNVAL" : ""));
=20
 			if (i =3D=3D POLLFD_SIGNAL)
 				rc =3D handle_signal(pty, pfd[i].fd);
-			else if (pfd[i].revents & POLLIN)
-				rc =3D handle_io(pty, pfd[i].fd, &eof); /* data */
+			else {
+				if (pfd[i].revents & POLLIN)
+					rc =3D handle_io(pty, pfd[i].fd, &eof); /* data */
+				if (pfd[i].revents & POLLOUT) /* i =3D=3D POLLFD_MASTER */
+					rc =3D flush_child_buffers(pty, NULL);
+			}
=20
 			if (rc) {
 				ul_pty_write_eof_to_child(pty);
+				for (int anything =3D 1; anything;)
+					flush_child_buffers(pty, &anything);
 				break;
 			}
=20
@@ -631,11 +698,11 @@ int ul_pty_proxy_master(struct ul_pty *p
 			 */
 			if ((pfd[i].revents & POLLHUP) || (pfd[i].revents & POLLNVAL) || eof) {
 				DBG(IO, ul_debugobj(pty, " ignore FD"));
-				pfd[i].fd =3D -1;
 				if (i =3D=3D POLLFD_STDIN) {
+					pfd[i].fd =3D -1;
 					ul_pty_write_eof_to_child(pty);
-					DBG(IO, ul_debugobj(pty, "  ignore STDIN"));
-				}
+				} else /* i =3D=3D POLLFD_MASTER */
+					pfd[i].revents &=3D ~POLLIN;
 			}
 		}
 		if (rc)

--37hu7inoc47cczft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmHgtYgACgkQvP0LAY0m
WPF+ShAAi2eHmLLlML5P+ahBBsOCqIvPJJEkpQMn0LwC/zj+W0klJhAcsbuTd2IC
EW7Vd4fsY2ZqLPjng6PlOdl6ww75tqBw5+DwZf/3hRvXLKIGlxt8jxsuaHXLFcjf
twCXyA8Qp79bc2UlG2oZUh8RBLkUe9MzEVV+KAGEjHJtrp+8j4Hdx+2g3S6ymedL
oWsYnBO45T9gBPKVwGgT31e1tYL073izQB/OOziZ+0EtTgWJ/gm0ufXcv6kaPqLm
jqfCKajOHdt/aFP9obz/FqT0e40BX9p1C9ZeR24cExvUj0waZ7/0yH+8fPIkXjbd
norreFpLPQU6H3dVadZvDW7dJ42vnuUDDh9h5WaBlhNR7Kub9HubO7r8aDJNX3sX
5/i9E8bx0a9ps8Yr2bgH9g9+j4yVtsOwQkAGMlBmDiLD12p/H9NUe+k9ZuQ8Toel
IKDjrBbaAk2gccI5gTN/fxc6asG5oc8a1zt+Rd+5uetlv4FOhUq81NItlDeJ/8tB
/fPMVeoF+YZsk9oVwPCy85e+YQc0td/FHRJua1t5xIrvFjZQS0EgnKbFUwXMya2d
uAI90bYLbC8tWDvuFSdMyEFT8X0uaWnLz5H/3Dz6YiwIXGaQr6yxcVy8j+2KLEg/
CK32bG+xGzbPzeClFYMS1co5hGTtm8p6hHDpNkc7lA2StFWHP5w=
=hNB1
-----END PGP SIGNATURE-----

--37hu7inoc47cczft--

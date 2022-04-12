Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E24FC433FE
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 14:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbiDLO2B (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 10:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356559AbiDLO1i (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 10:27:38 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 244A022B02
        for <util-linux@vger.kernel.org>; Tue, 12 Apr 2022 07:25:17 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 42DF8290;
        Tue, 12 Apr 2022 16:25:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1649773515;
        bh=WDtCOMYZpL4DBbCUqyW4motWnQlR4CEoEGaItqDUQ+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSDbFb9FXRrCnoqp91r/foR6tkbdFsxog2EzRQwnfiuJoi4fflD0e+nhUkJEsqP5z
         mMilMOChbUUkZ8AEkf90mMXqru76ncm+CLiXi090nfUQvoPMsDzkSA0Z+2UOgKwgvn
         IeKLvDKVWEOjyZ/s/br6Z+74rWo4JdobzS2u5uzCPObXyULdLbkmvPGAMVF6QGEPTF
         rbvfZ5anLw+7j+Lep97CthoYw8ZigMEJZwC0oYSQCFcNtcr0zbIe+5vQ82Sl4Ijjz8
         sxN0SXs4noTjYA6cyLf8d0Awe94C/4uaJWdzlLSOucYDckNiVwP1VPKNzQ6nIM9nG0
         ibNJs0/N9YYXA==
Date:   Tue, 12 Apr 2022 16:25:14 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Karel Zak <kzak@redhat.com>
Cc:     1003095@bugs.debian.org, Chris Hofstaedtler <zeha@debian.org>,
        util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220412142514.jkgnjc3452q5kmm4@tarta.nabijaczleweli.xyz>
Mail-Followup-To: Karel Zak <kzak@redhat.com>, 1003095@bugs.debian.org,
        Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
 <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
 <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
 <20220411100806.bfplpv36sdixd6uu@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ynzx7enhvtw6lnt6"
Content-Disposition: inline
In-Reply-To: <20220411100806.bfplpv36sdixd6uu@ws.net.home>
User-Agent: NeoMutt/20220408
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--ynzx7enhvtw6lnt6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2022 at 12:08:06PM +0200, Karel Zak wrote:
> On Fri, Jan 14, 2022 at 12:28:11AM +0100, =D0=BD=D0=B0=D0=B1 wrote:
> > -static int write_to_child(struct ul_pty *pty, char *buf, size_t bufsz)
> > +static int schedule_child_write(struct ul_pty *pty, char *buf, size_t =
bufsz, int final)
> >  {
> > -	return write_all(pty->master, buf, bufsz);
> > +	struct ul_pty_child_buffer *stash =3D calloc(1, sizeof(*stash));
>=20
> It means that for each activity on the file descriptor it will
> allocate a new buffer (in BUFSIZ). It seems pretty expensive.
>=20
> Cannot we reuse the buffers?=20

Added pty->free_buffers where we put free-to-use (fully-written-out buffers)
instead of free()ing them; my testing indicates, that for interactive use
we allocate a single buffer and re-use 100% of the time.

> >  /*
> > @@ -311,16 +329,13 @@ static int write_to_child(struct ul_pty
> >   * maintains master+slave tty stuff within the session. Use pipe to wr=
ite to
> >   * pty and assume non-interactive (tee-like) behavior is NOT well supp=
orted.
> >   */
> > -void ul_pty_write_eof_to_child(struct ul_pty *pty)
> > +static void drain(struct ul_pty *pty)
>=20
> drain_child_buffers() :-)

Renamed; updated scissor-patch below.

Best,
=D0=BD=D0=B0=D0=B1

-- >8 --
Date: Fri, 14 Jan 2022 00:28:12 +0100
Subject: [PATCH v2] Put master PTY into non-blocking mode and buffer its
 output to avoid deadlock

If we filled the script->child buffer before the child had a chance
to read any input, we'd sleep forever in write_all(pty->master),
and the child would sleep forever in write(1<pty->slave>)

By putting the master PTY in non-blocking mode, we can
poll(pty->master, POLLOUT) and keep supplying more data
as the child reads from the buffer

Fixes Debian bug #1003095
---
 include/pty-session.h |   7 +++
 lib/pty-session.c     | 126 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 110 insertions(+), 23 deletions(-)

diff --git a/include/pty-session.h b/include/pty-session.h
index 09eff43fd..7176d6ba7 100644
--- a/include/pty-session.h
+++ b/include/pty-session.h
@@ -81,6 +81,13 @@ struct ul_pty {
=20
 	struct timeval	next_callback_time;
=20
+	struct ul_pty_child_buffer {
+		struct ul_pty_child_buffer *next;
+		char buf[BUFSIZ];
+		size_t size, cursor;
+		unsigned int final_input:1;	/* drain child before writing */
+	} *child_buffer_head, *child_buffer_tail, *free_buffers;
+
 	unsigned int isterm:1,		/* is stdin terminal? */
 		     slave_echo:1;	/* keep ECHO on pty slave */
 };
diff --git a/lib/pty-session.c b/lib/pty-session.c
index 6f038e1c5..880f08d27 100644
--- a/lib/pty-session.c
+++ b/lib/pty-session.c
@@ -69,6 +69,15 @@ struct ul_pty *ul_new_pty(int is_stdin_tty)
=20
 void ul_free_pty(struct ul_pty *pty)
 {
+	struct ul_pty_child_buffer *hd;
+	while((hd =3D pty->child_buffer_head)) {
+		pty->child_buffer_head =3D hd->next;
+		free(hd);
+	}
+	while((hd =3D pty->free_buffers)) {
+		pty->free_buffers =3D hd->next;
+		free(hd);
+	}
 	free(pty);
 }
=20
@@ -182,7 +191,7 @@ int ul_pty_setup(struct ul_pty *pty)
 		cfmakeraw(&attrs);
 		tcsetattr(STDIN_FILENO, TCSANOW, &attrs);
 	} else {
-	        DBG(SETUP, ul_debugobj(pty, "create for non-terminal"));
+		DBG(SETUP, ul_debugobj(pty, "create for non-terminal"));
=20
 		rc =3D openpty(&pty->master, &pty->slave, NULL, NULL, NULL);
 		if (rc)
@@ -198,6 +207,8 @@ int ul_pty_setup(struct ul_pty *pty)
 		tcsetattr(pty->slave, TCSANOW, &attrs);
 	}
=20
+	fcntl(pty->master, F_SETFL, O_NONBLOCK);
+
 	sigfillset(&ourset);
 	if (sigprocmask(SIG_BLOCK, &ourset, NULL)) {
 		rc =3D -errno;
@@ -290,9 +301,27 @@ static int write_output(char *obuf, ssize_t bytes)
 	return 0;
 }
=20
-static int write_to_child(struct ul_pty *pty, char *buf, size_t bufsz)
+static int schedule_child_write(struct ul_pty *pty, char *buf, size_t bufs=
z, int final)
 {
-	return write_all(pty->master, buf, bufsz);
+	struct ul_pty_child_buffer *stash;
+	if (pty->free_buffers) {
+		stash =3D pty->free_buffers;
+		pty->free_buffers =3D stash->next;
+		memset(stash, 0, sizeof(*stash));
+	} else
+		stash =3D calloc(1, sizeof(*stash));
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
@@ -311,16 +340,13 @@ static int write_to_child(struct ul_pty *pty, char *b=
uf, size_t bufsz)
  * maintains master+slave tty stuff within the session. Use pipe to write =
to
  * pty and assume non-interactive (tee-like) behavior is NOT well supporte=
d.
  */
-void ul_pty_write_eof_to_child(struct ul_pty *pty)
+static void drain_child_buffers(struct ul_pty *pty)
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
@@ -329,7 +355,53 @@ void ul_pty_write_eof_to_child(struct ul_pty *pty)
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
+			drain_child_buffers(pty);
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
+
+			hd->next =3D pty->free_buffers;
+			pty->free_buffers =3D hd;
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
@@ -362,7 +434,7 @@ static int handle_io(struct ul_pty *pty, int fd, int *e=
of)
 	/* read from active FD */
 	bytes =3D read(fd, buf, sizeof(buf));
 	sigprocmask(SIG_BLOCK, &set, NULL);
-	if (bytes < 0) {
+	if (bytes =3D=3D -1) {
 		if (errno =3D=3D EAGAIN || errno =3D=3D EINTR)
 			return 0;
 		return -errno;
@@ -375,15 +447,11 @@ static int handle_io(struct ul_pty *pty, int fd, int =
*eof)
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
@@ -567,6 +635,11 @@ int ul_pty_proxy_master(struct ul_pty *pty)
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
@@ -600,23 +673,30 @@ int ul_pty_proxy_master(struct ul_pty *pty)
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
@@ -631,11 +711,11 @@ int ul_pty_proxy_master(struct ul_pty *pty)
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
--=20
2.30.2


--ynzx7enhvtw6lnt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJVi8kACgkQvP0LAY0m
WPGpLA/6AxsrpAssQkMbR6UAFTnn5s18SccHZgwACqXHoBgRzssGf4s0SH3A4TFH
Nt7aII8WHcipvn93YeFPd3DI0FQ8cdu8pegsFUA0LSJNWL3VcG7rMLQjENwpTRVF
eEFLTp7LP+uhOee6SyWtnGqZBHNKMHoYCtE1EZZxCnGVRRXwYnD8A0hWT7cNvxxl
9Mz7youCev0D4oBbUmslkBj6U7hI30ZfqnODEfawIB1Pk+P5hSUdFZOnVLjS3wvd
Xff4Wg/MclnLNqHHBh4cGIY9I6MkGC01Ba63GVsSwKfGDQqLthglUyyKjE3nHY6N
Fr3s6DaJEn4Q8ztTrMvuzbIkoYuMUltVRtfcjs96SF2hEhjKOUHanVz9QZqSnoRD
eMN9GDlyE08PATgsxUr4rKXzlggn2WTeRrCUx8HeimYFpaswSErI4Di0PGhexp5J
Iy3TjrfcsP1dvoMdqNFnseoVhSnShFxGBVJqvASuhUwjJugUQwP4f8vmTrS6gXn1
ZfKd9Z98CdQDTQ0grQY0Ej8uToPqwU4t0DShxZtw0QWxYqRsUmeBbZzbO84DZOND
YCYHRrPbmiaN/uZ0EyNZyj1lx5Q4nPVQbyV+VpnvL8yEClRiBc4hzRoyZHFrm1sY
URu+7hz4edKl2+XZVlExysedtNsPwlV2G/gwnHT6dXBONGcr32w=
=fvI7
-----END PGP SIGNATURE-----

--ynzx7enhvtw6lnt6--

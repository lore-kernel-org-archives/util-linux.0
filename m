Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9F3AA1AE
	for <util-linux@vger.kernel.org>; Mon,  4 May 2026 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894322; cv=none; b=t2Tgi9HhlYznfadO5VGeOLnHHqz0FY9BhZzRw2+/16fzVSAaUPOFianweoVf9nvVzSKQkRLKtDUK6M0xcWeZPuv3mtSpwEBacFoOUwxVO9ct8yxoFKEXdEWpRz0J29Lx1UJeZtD9RBRlDbpmTzVoYz9jTqyTuTIMvPNb3b4Td64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894322; c=relaxed/simple;
	bh=Ob1ZrQvZ5MA6DZK5FhVjnW/xNAZ4Agb9fRSAm258aeg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF+/30JgofdoMtQRXtcGCM3+xGv3ldz/NNoh/oS2XzHDFJwWes65xb2Pr/8LqrKmDBDAAuLHmGDqyrp/HV8zclgrwymZ3gSDg9ZmQUH2exlF7VTRi3oZc1KpzlFVuki08Y9qOm1yr3gfWbZPFI6NunJMVESevZISEAZAj1Wifkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H9qYwcf1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m7r0dNa4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H9qYwcf1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m7r0dNa4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H9qYwcf1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m7r0dNa4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H9qYwcf1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m7r0dNa4"
Received: from boole.nue2.suse.org (unknown [IPv6:2a07:de40:a101:3:21c:c0ff:fea4:1c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BF7F5BF43
	for <util-linux@vger.kernel.org>; Mon,  4 May 2026 11:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777894319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86fjHImmZrmASU7HlCQHGbLGP7qxSz+2Q84Ioj+Q6h4=;
	b=H9qYwcf1sFF2kGcPYZX86ZTztCYugvDNWGf6BG89JDwnwJ8Nd2+gFfZBfk/eXrgdYyOrML
	oFGj1c4U6wpVcwg67p6w7y6uOykswk0KylzcnbUq0mJlGLbcQS86hIlxshr3DU+1acYWsS
	THNwJk2Yu3SszrtNphb7R4Tisd0bzQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777894319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86fjHImmZrmASU7HlCQHGbLGP7qxSz+2Q84Ioj+Q6h4=;
	b=m7r0dNa4Gs3w+6LpHGVK82SSv/I3td7WoBE/EOX3pYkIrK9Zlt8QdKVo0nSlrVM+kW45IG
	GABS+MLmWelcfyAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H9qYwcf1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m7r0dNa4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777894319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86fjHImmZrmASU7HlCQHGbLGP7qxSz+2Q84Ioj+Q6h4=;
	b=H9qYwcf1sFF2kGcPYZX86ZTztCYugvDNWGf6BG89JDwnwJ8Nd2+gFfZBfk/eXrgdYyOrML
	oFGj1c4U6wpVcwg67p6w7y6uOykswk0KylzcnbUq0mJlGLbcQS86hIlxshr3DU+1acYWsS
	THNwJk2Yu3SszrtNphb7R4Tisd0bzQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777894319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86fjHImmZrmASU7HlCQHGbLGP7qxSz+2Q84Ioj+Q6h4=;
	b=m7r0dNa4Gs3w+6LpHGVK82SSv/I3td7WoBE/EOX3pYkIrK9Zlt8QdKVo0nSlrVM+kW45IG
	GABS+MLmWelcfyAQ==
Received: from boole.nue2.suse.org (localhost [127.0.0.1])
	by boole.nue2.suse.org (8.18.1/8.18.1/SUSE Linux 0.8) with ESMTPS id 644BVvHx028136
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Mon, 4 May 2026 13:31:59 +0200
Received: (from werner@localhost)
	by boole.nue2.suse.org (8.18.1/8.18.1/Submit) id 644BVus1028135
	for util-linux@vger.kernel.org; Mon, 4 May 2026 13:31:56 +0200
Date: Mon, 4 May 2026 13:31:52 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] Secure login and sulogin on S390x
Message-ID: <afiDrFfbIYBlgmzK@boole.nue2.suse.org>
Mail-Followup-To: util-linux@vger.kernel.org
References: <20260429092825.17623-2-werner@suse.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m7A4WK9JcQLwsVy7"
Content-Disposition: inline
In-Reply-To: <20260429092825.17623-2-werner@suse.de>
X-GPG-Fingerprint: 1B06 BF5A 3829 90FB CBA2  75BE 50E9 0D55 1DC1 6B2E
X-MS-Reactions: disallow
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.19 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SIGNED_PGP(-2.00)[];
	FROM_NAME_HAS_TITLE(1.00)[dr];
	HFILTER_HELO_IP_A(1.00)[boole.nue2.suse.org];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[boole.nue2.suse.org];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain,text/x-patch];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:a101:3:21c:c0ff:fea4:1c14:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[boole.nue2.suse.org:helo,boole.nue2.suse.org:mid,suse.de:dkim,suse.de:email]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 6BF7F5BF43
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.19
X-Spam-Level: 


--m7A4WK9JcQLwsVy7
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="zYJTpbyDZJLraOxV"
Content-Disposition: inline
Date: Mon, 4 May 2026 13:31:52 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] Secure login and sulogin on S390x


--zYJTpbyDZJLraOxV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

just to extend the last patch with a further one ro catch
all corner cases as well.

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--zYJTpbyDZJLraOxV
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: attachment; filename=x.patch
Content-Transfer-Encoding: quoted-printable

=46rom a6c23b4d8ad84fff4a58855b76b56a261ff8aa5e Mon Sep 17 00:00:00 2001
=46rom: Werner Fink <werner@suse.de>
Date: Mon, 4 May 2026 13:20:13 +0200
Subject: [PATCH] Ensure to detect all special console case on S390x

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin-consoles.c | 46 ++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index f09d90ece..4cce4f078 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -312,7 +312,7 @@ static
 #ifdef __GNUC__
 __attribute__((__hot__))
 #endif
-int append_console(struct list_head *consoles, const char * const name)
+int append_console(struct list_head *consoles, const char * const name, de=
v_t dev)
 {
 	struct console *restrict tail;
 	const struct console *last =3D NULL;
@@ -343,7 +343,29 @@ int append_console(struct list_head *consoles, const c=
har * const name)
 	tail->reset_tty_context =3D NULL;
 	tail->user_tty_context =3D NULL;
 #endif
-
+#if defined(__s390__) || defined(__s390x__)
+	/*
+	 * Stat the device path to determine its major/minor numbers.=20
+	 * This ensures we detect s390x terminal types regardless of whether=20
+	 * the console was found via /proc, /sys, cmdline, or a direct stdin=20
+	 * fallback (e.g. sulogin < /dev/ttyS0).
+	 */
+	if (!dev) {
+		struct stat st;
+		if (stat(name, &st) =3D=3D 0 && S_ISCHR(st.st_mode))
+			dev =3D st.st_rdev;
+	}
+	if (dev) {
+		unsigned int maj =3D major(dev);
+		unsigned int min =3D minor(dev);
+		if (maj =3D=3D 4 && min =3D=3D 64)
+			tail->flags |=3D CON_3215;
+		else if (maj =3D=3D 4 && min >=3D 65)
+			tail->flags |=3D CON_SCLP;
+		else if (maj =3D=3D 227 && min >=3D 1)
+			tail->flags |=3D CON_3270;
+	}
+#endif
 	return 0;
 }
=20
@@ -385,7 +407,7 @@ static int detect_consoles_from_proc(struct list_head *=
consoles)
 		name =3D scandev(dir, comparedev);
 		if (!name)
 			continue;
-		rc =3D append_console(consoles, name);
+		rc =3D append_console(consoles, name, comparedev);
 		free(name);
 		if (rc < 0)
 			goto done;
@@ -394,14 +416,6 @@ static int detect_consoles_from_proc(struct list_head =
*consoles)
 			last =3D list_last_entry(consoles, struct console, entry);
 			if (!strchr(fbuf, 'C'))
 				last->flags |=3D CON_CONSDEV;
-#if defined(__s390__) || defined(__s390x__)
-			if (maj =3D=3D 4 && min =3D=3D 64)
-				last->flags |=3D CON_3215;
-			if (maj =3D=3D 4 && min >=3D 65)
-				last->flags |=3D CON_SCLP;
-			else if (maj =3D=3D 227 && min >=3D 1)
-				last->flags |=3D CON_3270;
-#endif
 		}
 	}
=20
@@ -461,7 +475,7 @@ static int detect_consoles_from_sysfs(struct list_head =
*consoles)
 		name =3D scandev(dir, comparedev);
 		if (!name)
 			continue;
-		rc =3D append_console(consoles, name);
+		rc =3D append_console(consoles, name, comparedev);
 		free(name);
 		if (rc < 0)
 			goto done;
@@ -549,7 +563,7 @@ static int detect_consoles_from_cmdline(struct list_hea=
d *consoles)
 		name =3D scandev(dir, comparedev);
 		if (!name)
 			continue;
-		rc =3D append_console(consoles, name);
+		rc =3D append_console(consoles, name, comparedev);
 		free(name);
 		if (rc < 0)
 			goto done;
@@ -607,7 +621,7 @@ static int detect_consoles_from_tiocgdev(struct list_he=
ad *consoles,
 			goto done;
 		}
 	}
-	rc =3D append_console(consoles, name);
+	rc =3D append_console(consoles, name, comparedev);
 	free(name);
 	if (rc < 0)
 		goto done;
@@ -721,7 +735,7 @@ int detect_consoles(const char *device, const int fallb=
ack, struct list_head *co
 		closedir(dir);
=20
 		if (name) {
-			rc =3D append_console(consoles, name);
+			rc =3D append_console(consoles, name, comparedev);
 			free(name);
 			if (rc < 0)
 				return rc;
@@ -798,7 +812,7 @@ fallback:
 		n =3D strdup(name);
 		if (!n)
 			return -ENOMEM;
-		rc =3D append_console(consoles, n);
+		rc =3D append_console(consoles, n, 0);
 		free(n);
 		if (rc < 0)
 			return rc;
--=20
2.51.0


--zYJTpbyDZJLraOxV--

--m7A4WK9JcQLwsVy7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJgBAABCABKFiEEGwa/WjgpkPvLonW+UOkNVR3Bay4FAmn4g6gsFIAAAAAAFQAO
cGthLWFkZHJlc3NAZ251cGcub3Jnd2VybmVyQHN1c2UuZGUACgkQUOkNVR3Bay6x
+g//QvogPiNIpGHJXG6aZHR/X4C/1m7iL+1zxEW8AG7KPPCXTX9ZM58OP435N5l4
uf6su/yi7AlhRmvTqS+Eyme+HyX+11qvoOy1SvPuJSkheInYVaN23LE1ardtqud/
z3OLs99WO3HOTd01Ke/+WcPAbQopt+Wh3YLLNjoVdCxj9obOCbXWv1Fhq44ub055
T8I14zLZ5+dnfsh/dYcjMa1n70IfbkPEHdSbv2Ey8TCGRglI7JFuxPpFvjcHJUBH
bI7/s8NoOz0M2Cv7cFQhO+8dlUDvuvsJZ0cMtDtQsR1E147yNlk7rWK2XX93zXyK
YUaMvnwfHgmcw4o5mTCT/P5m2RUzwNhXFW2fCJ+rD+b7dxubtpdymKWnkhuCVJwp
QejGQWe2U7iyhQt5d+1f3kEnhdnBJXL035uYHpSM03+LmliyROwGq0U+Tms9f0ce
Doq+FgrzB5OfuxxQ5O1vTo4BhP77v+hmpQlX52Jc2QAz0Mj1ZafHKerdPJVDpUjR
ZMpsRBXxcOvNTw7YjpgOokz3rU/lfuUDy4BaiONIeiysk2YP4a/H2kVuYAtQX//I
3C/BohuR1o6NkoIEKKjNW1j6nPgRD7NizHkDFIRhNJ1tHhdCQVwD7DClLVe4rIES
CCMEOEe4ViJTZ6b3u8bzPFHU8Vl0dGczZZlnQygN84Db4U4=
=fZqG
-----END PGP SIGNATURE-----

--m7A4WK9JcQLwsVy7--

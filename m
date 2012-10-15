Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:37484 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab2JOCAO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 22:00:14 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 03/13] ipcs: determine ipc limits from /proc
Date: Sun, 14 Oct 2012 22:00:19 -0400
Cc: util-linux@vger.kernel.org
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi> <1350246145-10600-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3892482.7moEQ6DxgG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210142200.20690.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart3892482.7moEQ6DxgG
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 14 October 2012 16:22:15 Sami Kerola wrote:
> +		fscanf(f, "%d", &(lim->msgmni));

no need for the paren around lim->msgmni.  same thing applies many times in=
=20
this patch.

> +	if ((msgctl(0, IPC_INFO, (struct msqid_ds *)(void *)&msginfo)) < 0)

the paren around msgctl doesn't make sense.  seems like you do this multipl=
e=20
times in this patch and none of them make sense.

> +	lim->msgmni =3D (int)msginfo.msgmni;
> +	lim->msgmnb =3D (int)msginfo.msgmnb;

these casts don't make sense.  they're both ints.

> +	lim->msgmax =3D (size_t)msginfo.msgmax;

msgmax is an int, so it seems like blindly casting to size_t isn't a good=20
idea.
=2Dmike

--nextPart3892482.7moEQ6DxgG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQe240AAoJEEFjO5/oN/WB8+AQAN6ZhZrf6prkbQ/T+tehQN4I
f/D8f5oe/wNmKw1QuwDJxaLUzqwyxXVJllrPkkVAXzorNflbAVo0ZTmNzNvupgOV
ukJm8Kz7m8lnHEeCi9VN0cemdc5FJ3KHWyZTHGvngSRVhDOmbVL5dZDKNnRYSO83
qlXPyIFq0ZweHiu127Iv3MWxvKeGk27wQaaSXwmqZW03aykE37CmgQARS9b4uHI5
s8VlxgCShP1eShEVLPOjfs1BK6Vflv0xwIplE5WlwuqcQUzrByfQhMYndpxdi+9R
7LWRYG9ZqYdIUnjaufqQ6mnjt46wPXsZQjL8inmfZzmI6jqAEqtlQGg5AAcuOup0
lXNytZLgs1gZZJZpw7VrgDiR0yE2KAV56xif9URDsAdf57gHCEpnf76693lJe+t/
hHy+9QJx1N8jgtMp7ywyA0VFy66GEGUZmeleOTIPvmQtIsj95W9wuPM05w68YPuz
7EE7sK3Fh2SzKgG5YhrFylGfVqYOq9JrZSNCHAC0g16m8ApAuRfNI+Dz+3I6u8Ad
RjUJIlBvPocDumEciOcufvTw8mFgRdOr7wRo6/N6FADsH18obelG1t3n8SuQGDip
/fKL6LKTcpWnFB2iatIY48Nt4LxRPh4sas0pg56YaQ+iRUfpDh+y3GSYRPr8LulN
90Gh9ZCkHsP7lOl2RVhs
=Nwp8
-----END PGP SIGNATURE-----

--nextPart3892482.7moEQ6DxgG--

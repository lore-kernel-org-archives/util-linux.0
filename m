Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC1C64ED6
	for <util-linux@archiver.kernel.org>; Mon, 27 Feb 2023 19:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjB0TBN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Feb 2023 14:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjB0TBL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Feb 2023 14:01:11 -0500
Received: from magnesium.8pit.net (magnesium.8pit.net [45.76.88.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763A1814B
        for <util-linux@vger.kernel.org>; Mon, 27 Feb 2023 11:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=opensmtpd; bh=87RQAf/T5Y
        r0hE4F4gHZA0UmRF6YxsBQQpLiM3031Hk=; h=in-reply-to:references:from:
        subject:cc:to:date; d=soeren-tempel.net; b=oJd/4LjaUTTi/v93niR2PhkGMkT
        EAlFVH0k498olt0ETvovDA96g/s2sUZ9Pj6Za9PCbzApajoX1HwPQe4kcB+s3fNOClHx1R
        qiaQ5OzqpWpZjJRcg2/jAHvN2YkKhWRvQY2dHH+ujaJEkonGOZr2gLo50h5MOGZBGxGqaK
        l3Bs=
Received: from localhost (<unknown> [2a02:8109:3b40:22d0:bb76:ef7b:4f2f:4e5b])
        by magnesium.8pit.net (OpenSMTPD) with ESMTPSA id 26875721 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:YES);
        Mon, 27 Feb 2023 20:01:00 +0100 (CET)
Date:   Mon, 27 Feb 2023 20:00:55 +0100
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libmount: Fix access to uninitialised value in
 mnt_optstr_locate_option
From:   =?UTF-8?Q?S=C3=B6ren?= Tempel <soeren@soeren-tempel.net>
References: <20230225114352.9151-1-soeren@soeren-tempel.net>
 <20230225124131.10401-1-soeren@soeren-tempel.net>
 <3E04KR1SLWLFQ.25IAX13LC3PWS@8pit.net>
 <20230227105038.l2pw3nn6x62tridi@ws.net.home>
In-Reply-To: <20230227105038.l2pw3nn6x62tridi@ws.net.home>
Message-Id: <2B71FNQUV107Y.2UPOBHSWLST8P@8pit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hey Karel,

Thanks for your patch, the changes look good to me!

I have one small follow-up question though. You added the following
sentence to the documentation for mnt_match_options():

> The alone "no" is error and all matching ends with False.

I believe this to be a good change. However, If my understanding of
this documentation comment is correct I would have expected

	mnt_match_options("bla", "no,,")

to return False as well but to my surprise it actually returns True. I
understand that this is an edge case but is that intended? Maybe the ","
should be treated as an terminating character for the "no" as well (i.e.
in addition to the null byte)?

diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index 4fbbb0859..a0056c767 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -865,7 +865,7 @@ int mnt_match_options(const char *optstr, const char *p=
attern)
 			name++, namesz--;
 		else if ((no =3D (startswith(name, "no") !=3D NULL))) {
 			name +=3D 2, namesz -=3D 2;
-			if (!*name) {
+			if (!*name || *name =3D=3D ',') {
 				match =3D 0;
 				break;	/* alone "no" keyword is error */
 			}

With this patch applied it also returns False for the "no,," pattern.

Greetings,
S=C3=B6ren

Karel Zak <kzak@redhat.com> wrote:
> On Sat, Feb 25, 2023 at 02:40:52PM +0100, S=C3=B6ren Tempel wrote:
> > This solution also has the issue that it handles the case incorrectly
> > where xstrncpy actually calls strlen(3). I wanted to avoid that but
> > maybe the best solution is to just change the xstrncpy API in a way tha=
t
> > it indicates whether it has written anything through an int return
> > value?
>=20
> The best will be to avoid all the buffer, xstrndup(), and        =20
> mnt_optstr_get_option() using if the options string or the pattern is  =20=

> empty.  It's unnecessary because we know that mnt_optstr_get_option()
> will return nothing.
>=20
> I have committed
> https://github.com/util-linux/util-linux/commit/06ee5267516761721ebfbdfa3=
13980cef8e54c66
>=20
> > Sorry for all the noise. Next time, I will just write a bug report...
>=20
> That's no problem. We should be friendly to people who invest time to
> report bugs and write code ;-)
>=20
>     Karel

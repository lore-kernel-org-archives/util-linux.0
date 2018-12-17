Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334CEC43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 21:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEED2133F
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 21:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eworm.de header.i=@eworm.de header.b="s040rhv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLQVUm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:20:42 -0500
Received: from mx.mylinuxtime.de ([195.201.174.144]:50972 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQVUm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 17 Dec 2018 16:20:42 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2018 16:20:40 EST
Received: from leda (p200300CF2F286405625718FFFE7F1598.dip0.t-ipconnect.de [IPv6:2003:cf:2f28:6405:6257:18ff:fe7f:1598])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id A48611337F1;
        Mon, 17 Dec 2018 22:15:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de A48611337F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1545081325; bh=WcDd2bX9El03+N261NQoWk0275icA6DzsliXGC8Pk2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=s040rhv6g6yjgry0IknY6HzFYKOT/xr9xwJEn3/jU7PRMwpL9fq2BGypRHjDOzfQ1
         9Cc8eBW5egCz82RaWJjZ+1zPAIAIg3n6r7xWiiqABnUAdeutt7Cw+eAvI+R9Ba22HP
         2UWDEsARPlzLbWwHWwRaBKFvlm+a3PqbFPU3fo2s=
Date:   Mon, 17 Dec 2018 22:15:18 +0100
From:   Christian Hesse <mail@eworm.de>
To:     Ruediger Meier <sweet_f_a@gmx.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] fstrim: add random delay to systemd timer
Message-ID: <20181217221518.5a68691f@leda>
In-Reply-To: <201812172145.23296.sweet_f_a@gmx.de>
References: <20181217124422.13334-1-mail@eworm.de>
        <201812172145.23296.sweet_f_a@gmx.de>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e=ycgOOfD9B65MhTOb7/Qwg"; protocol="application/pgp-signature"
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=mail@eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: 5aag4g1ixpddgogpz36m5apt4ozojpz1
X-Rspamd-Queue-Id: A48611337F1
X-Spamd-Result: default: False [-4.36 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmx.de];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         RCPT_COUNT_TWO(0.00)[2];
         NEURAL_HAM(-2.66)[-0.888,0];
         SIGNED_PGP(-2.00)[];
         FREEMAIL_TO(0.00)[gmx.de];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
         RCVD_TLS_ALL(0.00)[]
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--Sig_/e=ycgOOfD9B65MhTOb7/Qwg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Ruediger Meier <sweet_f_a@gmx.de> on Mon, 2018/12/17 21:45:
> On Monday 17 December 2018, Christian Hesse wrote:
> > The fstrim timer tends to fire simultaneously with other timers like
> > updatedb. As fstrim is not time criticaly let's add a random delay of
> > up to an hour.
> >
> > Signed-off-by: Christian Hesse <mail@eworm.de>
> > ---
> >  sys-utils/fstrim.timer | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sys-utils/fstrim.timer b/sys-utils/fstrim.timer
> > index 3a3762d5c..dd3328e2a 100644
> > --- a/sys-utils/fstrim.timer
> > +++ b/sys-utils/fstrim.timer
> > @@ -5,6 +5,7 @@ Documentation=3Dman:fstrim
> >  [Timer]
> >  OnCalendar=3Dweekly
> >  AccuracySec=3D1h
> > +RandomizedDelaySec=3D1h =20
>=20
> Looks like it could still run simultaneously with other timers at random=
=20
> times. So this does not seem to be a real fix for the problem described=20
> in your commit message.
>=20
> You may look at /etc/cron.{hourly,daily,weekly,monthly} if you want to=20
> run such jobs one after the other.

There's no harm when jobs run simultaneously, other than bad user experienc=
e:
Consider a user stating his notebook, workstation, whatever on a Monday
morning and system feels bad under high load. This can be avoided (most of
the time) with just a single line in the timer. I think it is worth it.

Anyway... Feel free to deny committing the patch. For now I added a
configuration snipped on my system.
--=20
Schoene Gruesse
Chris

--Sig_/e=ycgOOfD9B65MhTOb7/Qwg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvYTecfST32gUsBZyVO3JFgm8kYMFAlwYEeYACgkQVO3JFgm8
kYP2EA//cXdwFy/cRHZdkcUg+qPkIJrck2+KCkYqFN3VPeOueSSV7vmvFtTZCho3
5e7g+fnyUMRuIWlEgaBM1Us621OjdtW1gUNs7fBg+6M8MkHvIRlH8Tv0UyhJbV06
oKuORD6gYNuEsM8VQ9sAwDMOqHR1rT4HbG/p2l5I5evrhjaWiv/LzPNEMsYWQfRM
2PHmKQ6M88JzIt4PugAEp93XvNOkn8/PmTVdPcI9wLfLMFt7oCZlY0muU+sX4dFi
BxfyfiVIG6kkNPvtvWUnccaESe0LSBW/cUndYuEb4FBdGl/K8AQhhZvxAqUYjo/9
7oKCvuYGsiEpG8qtlEKHHh9cjAMzUKKOvyOePmwTWrTGE2U9LZCH8M/Li33kkESl
DSjRGfUvHBSMXUTS52FJnwO9AN+uR0Wqufp4oOJvxU0B2yhfnAKzW4gQWIEnyiuf
b/EXE1d0111YoadV4AAkvwTYOIyccGV8FrooDL79HiGvw1WxbyO3nj33GdJmNfHl
icA+BYbiTFh/+P2Xtb8YmqVV1TNs/o3w1cImkJMPhH+hspXztKxQKZiQfKkApFMi
ujIkgEugDxWnl5eV/qcoZfw02VNexbFmWj2b13V9y7ElqUqVaGGODDEK/uxLdkgH
AOC4tVmBbdO3IIrgD8/XHW5piS9E2a0DxWbn/v4mRm4DzcZY14Q=
=RrEH
-----END PGP SIGNATURE-----

--Sig_/e=ycgOOfD9B65MhTOb7/Qwg--

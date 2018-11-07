Return-Path: <SRS0=MPMV=NS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DFEC0044C
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 12:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989E20827
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 12:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eworm.de header.i=@eworm.de header.b="KVKKp41F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8989E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeKGWUl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:20:41 -0500
Received: from mx.mylinuxtime.de ([195.201.174.144]:36492 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeKGWUl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Nov 2018 17:20:41 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 17:20:38 EST
Received: from leda (unknown [IPv6:2001:470:99c1:714:e078:5e8f:bc9c:af22])
        (using TLSv1.2 with cipher DHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 917F3103C47;
        Wed,  7 Nov 2018 13:42:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 917F3103C47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1541594539; bh=fFJEwXWdGkxsb0hDn/ZR3/wZHRXpkcN0mG0zdQciZq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=KVKKp41FKhdVD0QjequB4oyIQh+ej6InVi5UOXmPl47WkzXzLZ+K61aoLP80GRT62
         S0yFDDHtS0tBhQP4bYgQJsWouzfjKn/TnI1WTxFBaTcxiUOnXGnDMTXsG2Xdf+RrLN
         vNZ8m6LdUfpdAzjWjWyGZ8UR0zlma/oiMoXBZTAk=
Date:   Wed, 7 Nov 2018 13:42:17 +0100
From:   Christian Hesse <list@eworm.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.33
Message-ID: <20181107134217.2fe72a87@leda>
In-Reply-To: <20181106113306.hd2qcvbde22cxur6@ws.net.home>
References: <20181106113306.hd2qcvbde22cxur6@ws.net.home>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2GdiO4PK/DgZSD5MWhvrpi1"; protocol="application/pgp-signature"
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: xpjwqunp4zz4hstoaacnfq8x3xcp15su
X-Rspamd-Queue-Id: 917F3103C47
X-Spamd-Result: default: False [-4.70 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         RCPT_COUNT_TWO(0.00)[2];
         NEURAL_HAM(-3.00)[-0.999,0];
         SIGNED_PGP(-2.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:6939, ipnet:2001:470::/32, country:US];
         RCVD_TLS_ALL(0.00)[]
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--Sig_/2GdiO4PK/DgZSD5MWhvrpi1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Karel Zak <kzak@redhat.com> on Tue, 2018/11/06 12:33:
> The util-linux release v2.33 is available at
>=20
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.33
>=20
> Feedback and bug reports, as always, are welcomed.

This breaks printing of (escaped) backslash in /etc/issue. We have
a downstream bug report in Arch Linux bugtracker [0] including issue file
that triggers the behaviour. The bad commit is 6522d88d [1].

[0] https://bugs.archlinux.org/task/60731
[1]
https://github.com/karelzak/util-linux/commit/6522d88d08ffbba528e15ab4e081f=
b2846bac03d
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/2GdiO4PK/DgZSD5MWhvrpi1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlvi3akACgkQiUUh18yA
9HZ5RAgA7ctLONNzHLxAHwr0GZ6H+QrxbDy2IhW9capkr0BRSijsyG6ruZEM/7DS
aMFAVZyB1NROyfLj33Xmrmd0PXGzrxjQaSVtuHizBvh1JHCBRoTPUSK0iA3JqNAC
YBek1ySc/Wd3f3PixLExbM8Q0G/BUvDMR8FP5T8y+HzBiCWXDdN1/Q2RuiFYgcj+
sJvsOJhOv4EpT+a5MY4Y9IGOAZYvjbu8ZEX8typp7wnNeXvD3GFrNAh7qNjpBnoH
cjqWoCaDW74WAppUvisS52oBM9oAdCdP9Pko61xqistdaSjYrBvw9epmw0wpQHTE
ykvBhljcfaisIWxhOvtmqvnAhbLRoA==
=jRcM
-----END PGP SIGNATURE-----

--Sig_/2GdiO4PK/DgZSD5MWhvrpi1--

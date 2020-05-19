Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B71C433DF
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C280D2075F
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 17:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgESRXk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 13:23:40 -0400
Received: from luckmann.name ([213.239.213.133]:53157 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729001AbgESRXk (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 May 2020 13:23:40 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E56011.000000005EC41619.00005BE7; Tue, 19 May 2020 19:23:37 +0200
Date:   Tue, 19 May 2020 19:23:37 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: Consistency fixes in util-linux man pages
Message-ID: <20200519172337.GA23268@Debian-50-lenny-64-minimal>
References: <4cb60e3f-0226-e7f0-0052-08a48ea9f425@gmail.com>
 <20200518082814.pq22ph732eiebacz@ws.net.home>
 <CAKgNAkihsF1tGurfHbnFPYZ4qJV9-2f=Sbj5qdLxmuuuAJ+GGA@mail.gmail.com>
 <20200518150312.GA22063@Debian-50-lenny-64-minimal>
 <20200519103832.7kmxmta2dl67ujpj@ws.net.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-23527-1589909017-0001-2"
Content-Disposition: inline
In-Reply-To: <20200519103832.7kmxmta2dl67ujpj@ws.net.home>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-23527-1589909017-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Karel,
On Tue, May 19, 2020 at 12:38:32PM +0200, Karel Zak wrote:
> On Mon, May 18, 2020 at 05:03:13PM +0200, Helge Kreutzmann wrote:
> > On Mon, May 18, 2020 at 12:36:01PM +0200, Michael Kerrisk (man-pages) w=
rote:
> > > I'm not too knowledgeable in AsciiDc, but my impression is that it's
> > > too limited in terms of its formatting opinions.
>=20
> Yes, I'm not sure about AsciiDoc limitations. For example systemd guys us=
es
> DocBook which is probably ultimate solution.

I'm currently translating them. Also I've used DocBook myself to write
manges (a long time ago).

> > > If I did move man-pages, the most likely candidate would probably be
> > > Sphinx, as is nowadays used in the kernel docs. But, that would
> > > require converting a thousand pages or so, and  I have not so far had
> > > the stomach for that. Of course, you have a rather smaller set of
> > > pages to deal with, so a conversion step sould be more easily
> > > entertained.
> >=20
> > Even though man pages are limitted in formatting, they are universally
> > available and, from our POV, getting more attention from the
> > translators side. We just welcomed our seventh language. Probably not=
=20
> > relevant for kenel side docs, but for programs by non programmers (and=
=20
> > presumably non native speakers) man pages are good option.
>=20
> The idea is maintain documentation (in git tree) in some content
> oriented language and then generate man pages from this content. It
> means in the official release tarball will be man pages and end-users
> will not see any difference.

Ok, then this is fine.

> The issue I have with man pages is that contributor very often send
> patches to change formatting details and keep it consistent, avoid
> color-of-bike-shed discussions is very difficult. It would be better
> care about content and keep all the formatting details in some
> conversion template.

I strongly agree. Keep content and presentation separate. This also
helps us translators, even though we don't see the original markup, we
do quickly understand the results, because it is consistent, i.e. what
to translate and what to leave untranslated (e.g. command names vs.
variable names)

Greetings

            Helge
--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-23527-1589909017-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAl7EFhQACgkQQbqlJmgq
5nDzYg//SLCZMQndXEsIj+O8+kqpRxnPlHITPM3simClv0xIXvWglyiGBxcf3QUO
3rwoCEGtNQOD7U5+f0dfgrJt+3z9eub/6Em3lvX0bUOWJcD+N0x0p5RDI39bD4ng
XJ5kHk2UWKpBzIyxqti4Q6J80QI5lwWZFDThK0mvEQki4SmIibpvwEX9+AAEYRsR
g4y1AcpytkvoY2j1XKk8CGMCUNIZnmqYWeNufJL6hA+tGM6lqS2ejFBiI8ReTMXV
/mVj8Y+bhvWKQ+vB4AmMyKFFOk4C92EstdIid82ccA4BGHS+NZRxJexC5pmfoXTA
vrrr0+46OCmwUr+uSyfSf2BrruK+KHyE3yop8itntnFEeM2JtrbJBjjBcd1V0hT7
WidtVMNMBmszvJk9gkxmJ5t1QhtTDeS+hXb5HOyFzv1yqEOkV+G15vqZ5aRlldAr
YLt4eTq0rAYJShXK+6As3LmybE9FP7lRdCSQcDr4Z3b9743y44rHlaWV7Yo9/Vm8
lqMwyDGxihvCsd+MYek+NqGvNqYqKa5ssn9/rKOWRKXUifAHqBIxA/YkBbQmZg//
AP+S6ycL/Uf4nKWkGlqscZjFBQuWIaxT/uGbKvy83Rtm7nrU/HiFqJVOBvG8j7Wh
0TR9Xoojmk5ZZJ0tj+7gkqOmSFMYvWY77ATQ93tf4qkb61S8LmA=
=naJS
-----END PGP SIGNATURE-----

--=_luckmann.name-23527-1589909017-0001-2--

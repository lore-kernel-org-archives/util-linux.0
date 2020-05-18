Return-Path: <SRS0=Ohmc=7A=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF8C433E3
	for <util-linux@archiver.kernel.org>; Mon, 18 May 2020 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8221320756
	for <util-linux@archiver.kernel.org>; Mon, 18 May 2020 15:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgERPDQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 May 2020 11:03:16 -0400
Received: from luckmann.name ([213.239.213.133]:48939 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbgERPDP (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 May 2020 11:03:15 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E56013.000000005EC2A3B1.000057BD; Mon, 18 May 2020 17:03:13 +0200
Date:   Mon, 18 May 2020 17:03:13 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: Consistency fixes in util-linux man pages
Message-ID: <20200518150312.GA22063@Debian-50-lenny-64-minimal>
References: <4cb60e3f-0226-e7f0-0052-08a48ea9f425@gmail.com>
 <20200518082814.pq22ph732eiebacz@ws.net.home>
 <CAKgNAkihsF1tGurfHbnFPYZ4qJV9-2f=Sbj5qdLxmuuuAJ+GGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-22461-1589814193-0001-2"
Content-Disposition: inline
In-Reply-To: <CAKgNAkihsF1tGurfHbnFPYZ4qJV9-2f=Sbj5qdLxmuuuAJ+GGA@mail.gmail.com>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-22461-1589814193-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael and Karel,
On Mon, May 18, 2020 at 12:36:01PM +0200, Michael Kerrisk (man-pages) wrote:
> On Mon, 18 May 2020 at 10:28, Karel Zak <kzak@redhat.com> wrote:
> > BTW, I'm not sure about man pages as ideal format to maintain
> > documentation (because it's mostly about formatting than about
> > content). I think about AsciiDoc or so in future. What do you think
> > about this idea?
>=20
> I'm not too knowledgeable in AsciiDc, but my impression is that it's
> too limited in terms of its formatting opinions.
>=20
> If I did move man-pages, the most likely candidate would probably be
> Sphinx, as is nowadays used in the kernel docs. But, that would
> require converting a thousand pages or so, and  I have not so far had
> the stomach for that. Of course, you have a rather smaller set of
> pages to deal with, so a conversion step sould be more easily
> entertained.

Even though man pages are limitted in formatting, they are universally
available and, from our POV, getting more attention from the
translators side. We just welcomed our seventh language. Probably not=20
relevant for kenel side docs, but for programs by non programmers (and=20
presumably non native speakers) man pages are good option.

(Of course, translation tools for other formats exists and e.g. po4a
supports many formats, it also need a dedicated community of
translators).

Greetings

           Helge

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-22461-1589814193-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAl7Co6sACgkQQbqlJmgq
5nCjORAAjBN3gfAZkt0i4rmi3mySQvYmBlHlEpB1YLnvYV0mfxtmY0A1+JdbQVyY
MN0OfhQq86HFm8GymuSaISTNqIC/RbiDi52+cXZ9CrGyW/o0xrTg4hlJpRShIjP/
VCWR687jDPe1O31Aw+Iu5CSqIKDfti6go38Hsa0AT6g2Y6B1a0Zh5osD4L+X0Bhb
5G7tWXrGvD5dmH8k8+gCZVtv/vVPzgM6FHLnm3R2KyZr8fpUTeyaxYfH7hUuIOZ4
vmdmnaUHbkAMB6hVf1vC+iI+dabOU+za9Ihhy/tWTdmJ7JzX0Yz+2V8NxuoHdGfE
DBxDJBwwTCFMXcaYg9K3k+b7UJJKldFFs7Yp8aCR+5B4KJlyaHv90GeTa20YGdB3
IB2iRtAISmMTMKni1ZNUHI/nU1uRY0xuyIDW8SKjrXTHEPFcj7rILEj52XRcvRqI
Q/c2gvljSHa3Ttnvz/8A9DYdzVYnE/i3TaCAvPLMjRWRc/TbG3NQtqkrXA3XA+wc
BLLzAxNdrpG8W+OEeUqosew2WjocKg8ZycD8ulfd2pgGoEWQS5ru2uwLAX2gUGr3
KxSI2yebGjDpJ5noWj56XvvHLmGFhR2uCLddukxaQLzVCcOu1i3kVLv+YfUSx8jB
j42qF4DS7dfNulZpt0fJUUKsi1g5Wv4sCtmZ7ke72xYZ0NLWxnY=
=f5g3
-----END PGP SIGNATURE-----

--=_luckmann.name-22461-1589814193-0001-2--

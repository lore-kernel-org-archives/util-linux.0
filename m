Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870D6C636D6
	for <util-linux@archiver.kernel.org>; Mon, 20 Feb 2023 20:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBTUfV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 20 Feb 2023 15:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBTUfU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 20 Feb 2023 15:35:20 -0500
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 12:35:18 PST
Received: from tuna.sandelman.ca (tuna.sandelman.ca [209.87.249.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2943193FB
        for <util-linux@vger.kernel.org>; Mon, 20 Feb 2023 12:35:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by tuna.sandelman.ca (Postfix) with ESMTP id 411D03898F;
        Mon, 20 Feb 2023 15:59:17 -0500 (EST)
Received: from tuna.sandelman.ca ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 3DzxJH9G8JX3; Mon, 20 Feb 2023 15:59:16 -0500 (EST)
Received: from sandelman.ca (unknown [IPv6:2607:f0b0:f:2:56b2:3ff:fe0b:d84])
        by tuna.sandelman.ca (Postfix) with ESMTP id F12613898E;
        Mon, 20 Feb 2023 15:59:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
        s=mail; t=1676926755;
        bh=DkfQB7h3gtT9L9L796h9ufDhfg85uF4X4mmC83+zkIM=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=QTupC9SEK0+ibSOKVMpqsPUsX1jab4nmzj46SVvsFzsoLQH6kaECZNlsyMTmZjqD5
         g7nlH0Xe9S6bSMEXuPEmhI0scIF74U8dnwN632+ShM0m5ePD1D44tlbCK4/0ttw+wQ
         LBwsWbqkns95aIfYLKiLHG7Oxcp6Wnz8fSC3cSxYOpnAXK0vKSIOQtM0hO6YbKcBrl
         4PK6sQC8LZsEhycVWeOnoNWou6iq513O46dWxm+JCIrnlVRdor5sKGB5LclgFcAa+9
         5en5UpwRNbe+soQiCY+mF7A6CinCcBvARbjU83fDTQx8KfP2gVwoajHcafPPxY+5Ej
         f7/QVLHzhdJyw==
Received: from localhost (localhost [IPv6:::1])
        by sandelman.ca (Postfix) with ESMTP id C1035158;
        Mon, 20 Feb 2023 15:28:02 -0500 (EST)
From:   Michael Richardson <mcr+ietf@sandelman.ca>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Chris Hofstaedtler <zeha@debian.org>,
        util-linux@vger.kernel.org
Subject: Re: uuid and RFC4122
In-Reply-To: <Y/LPN7pf6x75Xm9H@mit.edu>
References: <14266.1676658860@localhost> <20230219170116.q453di5cmknxn665@zeha.at> <Y/LPN7pf6x75Xm9H@mit.edu>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 27.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Mon, 20 Feb 2023 15:28:02 -0500
Message-ID: <23699.1676924882@localhost>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Theodore Ts'o <tytso@mit.edu> wrote:
    > I originally wrote the uuid implementation in util-linux.  Originally,
    > it was first in e2fsprogs, and then later the library was transferred
    > to util-linux at least for most Linux distributions.  Technically
    > speaking, however, libuuid is still shipped in the e2fsprogs sourecs
    > and that's the version which is used by Android and some non-Linux
    > OS's including NetBSD and Darwin (MacOS may have forked the library,
    > though, so if I shipped updates in e2fsprogs how quickly it would get
    > picked up by Apple.)  Libuuid is mostly in maintenance mode, actually;
    > the sort of changes that have landed recently have been to support the
    > getrandom(2) system call.

Good to hear, thanks for the reply.

    > I'm not sure what the context is for this e-mail thread, or what
    > you're asking for in terms of an LGTM?

Read the document, or just the diff:

  https://author-tools.ietf.org/diff?doc_1=3Drfc4122&doc_2=3Ddraft-ietf-uui=
drev-rfc4122bis-02

    > Were you looking for comments
    > on draft-ietf-uuidrev-rfc4122bis?

Email uuidrev@ietf.org ... we are especially interested in whether we have
left out/obsoleted some use case that you presently have, whether the new
version types are useful to you.
Do you use or care about MD5 or SHA1 based UUIDs?
We have proposed using namespace based UUIDs for future hash methods.

    > Or were you hoping to see if folks
    > might be interested in implementing the new UUID versions in
    > draft-ietf-uuidrev-rfc4122bis so the libuuid in Linux might support
    > those new variants?

No, I think that if you had a new use case/need, you'd have implemented
something already :-)


=2D-
Michael Richardson <mcr+IETF@sandelman.ca>   . o O ( IPv6 I=C3=B8T consulti=
ng )
           Sandelman Software Works Inc, Ottawa and Worldwide





--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFKBAEBCgA0FiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmPz19IWHG1jcitpZXRm
QHNhbmRlbG1hbi5jYQAKCRCAi3D73dDdZWsjCACgJvQWUa0catNdc00I4OSiyMrx
7RyycgWzWUviSKPdc4fRrSQY7rxoi+dHLJceelDnCYHsHbIgYNnf/08Sc/se4ILs
oPY/IaxIY9m/lwkvFgY+Q/lG3BukhArzqNULxrrJ4bZ6sEZ9ndc98FHN4WO8wq9y
nBwQIAKImWT0qVbVgdOiFQ6RBahp6Rnfu8oeImiXCkZ62AfSTvbX3l+rCb6wLHRW
KxBZ9vJ5gR6VRKr4UIkK5daOCKvggZvBZHvd45lU0RQnAJmjwey8rQik6qVwH63L
68XKc0NItNWFzB3WXqvLCL+FJKhj1xRoZS73TkgXEU6eCeyIuMPhaZyKEfxg
=91j/
-----END PGP SIGNATURE-----
--=-=-=--

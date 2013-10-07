Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:35621 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab3JGOYj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Oct 2013 10:24:39 -0400
Message-ID: <5252C425.2090203@ubuntu.com>
Date: Mon, 07 Oct 2013 10:24:37 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: butter@breezl.com, util-linux@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: losetup -d does not move partition devices
References: <5241BC33.8050700@breezl.com> <20131007113852.GF14360@x2.net.home>
In-Reply-To: <20131007113852.GF14360@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/7/2013 7:38 AM, Karel Zak wrote:
> ... but this all is known issue, Phillip Susi tried to fix this 
> disadvantage, but his solution has been reverted (see kernel
> commit c2fccc1c9f7c81700cbac2120a4ad5441dd37004).

Jens, I had assumed from your commit message that you intended to
reintroduce a fixed version of that patch in the following cycle.  Did
I misunderstand or did this get lost in the shuffle?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSUsQlAAoJEJrBOlT6nu75HpMH/RuVqo79Wlwr793RR2b9QSgU
58QHTcjcGb7pwOSnqHC68Ys5v3r1nqbp7VoRh8nc2V3XvMitGmwLbdDXafDTVOdt
2N3gl518w+XaIUMwUHYGnbGsaqba0OHr5u95/REUI1tW3hfgX+rQJBx7eJ5gC28x
oeHK7gu1jAHlaKeA6OUIiVxGYCp2kwZGj0goJy7uP9mWvscVjy/skZBjIv5iCFnN
gizrKxkD4++GjNul5TtfeI9SAW0coetrjXz11lJQ3o1JWu6X0shmp4KpR223ry3+
hdFdegaNXM3IDumHvdjkdxwUGg6M1VzojXJLguHs5NwYQTI6qzinvsxZJXkYPoQ=
=2EWu
-----END PGP SIGNATURE-----

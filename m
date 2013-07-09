Return-Path: util-linux-owner@vger.kernel.org
Received: from che.mayfirst.org ([209.234.253.108]:37945 "EHLO
	che.mayfirst.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab3GITSS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Jul 2013 15:18:18 -0400
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To: Damien Wyart <damien.wyart@gmail.com>, Sami Kerola <kerolasa@iki.fi>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: forking in setsid
In-Reply-To: CADJQGJfOj2GQNdoW89hC2LMukC_cwPuJVBiN6+xy64UphbOiZg@mail.gmail.com
Date: Tue, 09 Jul 2013 15:08:35 -0400
Message-ID: <87k3kzd00c.fsf@alice.fifthhorseman.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Hi folks--

I'm not subscribed to the util-linux mailing list (it's a firehose i
don't have the capacity to drink from), so please keep me Cc'ed on
replies.

I'm sorry that my original report was to debian only, and was not
forwarded upstream until now, but i appreciate Damien Wyert dusting it
off.

When i originally wrote http://bugs.debian.org/495881, i asked the
following question:

> I don't understand /usr/bin/setsid terribly well: is this difference
> in behavior [between setsid as process group leader or not-leader]
> desirable for some reason?  If so, why?  The shipped documentation
> (setsid(1)) makes no mention of these behavioral inconsistencies.

These questions arose from struggling with setsid in the context of some
work with ssh, in particular the thread starting here:

 http://marc.info/?l=openssh-unix-dev&m=121927018112558&w=2

i ended up resolving that problem without needing to use setsid, and i
think i came away from it (due to the aforementioned behavioral
inconsistencies) with the sense that /usr/bin/setsid wasn't actually a
particularly reliable or predictable tool.

I don't know whether it's more appropriate to try to fix it, to provide
a "--behave-consistently-regardless-of-pg-leader-status" option, or just
to document the weirdnesses, but i would certainly be curious to know if
there are users of setsid that rely on this strange set of behaviors.

Regards,

        --dkg

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQJ8BAEBCgBmBQJR3F+zXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRFQjk2OTEyODdBN0FEREUzNzU3RDkxMUVB
NTI0MDFCMTFCRkRGQTVDAAoJEKUkAbEb/fpclrwP/2raWvii6ywUa8XiV4XmGpdP
9K+xe9r24cnF+wcpKvB6ImFbnFHz83fVGCTp20oolJpW0UQIBpNMG0IWK7m1nw5S
gmv1E3RM7Av9PL4WzTaRVtWxfDDovcSub8r15S2rcH/2Qi8eEbL8vP54OFp6w4Iw
cna+me8kfhtG50CVW8nN6J2fFtHYjU3j0JaAXkuEj+h8IfC01XHPsFmUclM72DSr
l3pJgqlt3CplPoFdJmjshWbZBqrvHj6WK8cfTX//LcrnZgLJvX9AM/LLWpjtsQAF
tZls2f8iyO5Oz4nzf+7w7NueYshKza6RNoNRutsV1ZQ1RupRNoP/RgM0bJgQ+COS
gSzp9nRHwSH2U1MwLwBDpetsyyBVH2NBlfEltaKW7c23FN2v9nTIkCsrwGT2Ny2v
+jrk+fFT06ubJYf0TN7KJrgLfJnQqTPBfZ5MnBa6JoOHyYqnRUn2QS3FJWG1NF/W
zEf/LGOrMOpCSbLbYeac5VA2m0klOAvTImIYK+hFsRNxuy2kbFfL14GXq1SGpYDD
eIM6t+6IeT5H7fksKL3FXtQOYEx34bC2dfwJiKZV9BzOqYtLk/MTlVVUvZbuWG9H
OjP3g4eD/PNhTPLVzWwLTUL5j+021/azw0qdnFiiiFmTtdCtBbRFvnY9yMlEbjvF
bR5AvBjim0BIfYr/W+mb
=03l4
-----END PGP SIGNATURE-----
--=-=-=--

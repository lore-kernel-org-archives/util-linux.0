Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:51536 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab2CaQix (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 31 Mar 2012 12:38:53 -0400
Date: Sat, 31 Mar 2012 18:38:44 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: "Ted Ts'o" <tytso@mit.edu>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/20] uuidd: make drop_privs true by default in main()
Message-ID: <20120331163844.GA29416@skipper.site>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-11-git-send-email-petr.uzel@suse.cz>
 <20120329212911.GB13970@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <20120329212911.GB13970@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2012 at 02:29:11PM -0700, Ted Ts'o wrote:
> On Thu, Mar 29, 2012 at 06:45:18PM +0200, Petr Uzel wrote:
> > The drop_privs variable in main() was used to determine whether the
> > daemon will attempt to drop privileges (provided it has been installed
> > suid). As of now, it makes sense to drop the privileges each time it is
> > started. Therefore, this patch inverts the default value of drop_privs
> > to true, so that it does not need to be set in the getopt loop at
> > multiple places.
> >=20
> > Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
>=20
> This breaks the configuration where libuuid starts uuidd if it's not
> available, since there the user process probably doesn't have access
> to write to /var/lib/libuuid/clock.txt, and so dropping the setgid
> privileges of uuid will cause it not to work.

I don't think the commit you are referring to changes uuidd behavior
in any way and if it does, then I overlooked something and it is a
bug. The change is meant to be a cleanup - instead of initializing the
drop_privs to 0 and changing it to 1 in the getopt loop, it is initialized
to 1. IOW, I don't see a use case where it should be left 0, except
with later introduced --keep-privs (but see below). Or do I miss
something?

> Also, if you're going to have a -K option to keep the privileges,
> there isn't much of a security benefit, since if there's a bug in
> uuidd, the attacker can always call uuidd with -K and and then attempt
> to exploint any problem that might be there.
>=20
> So it's not clear adding the ability to drop privileges is really all
> that functional; if uuidd is setuid/setgid, it's probably because it
> **needs** those privileges.

If I get it right, the setuid/setgid bit for uuidd is "only" useful
for the case when uuidd is spawned from the libuuid library running
with normal user privileges, right? Since this is useless with the
socket activated uuidd, the solution might be to conditionally drop
the code for dropping privileges if uuidd is configured=20
--with-uuidd-socket-activation. Also the --keep-privs would
go away. Does that sound good?


Thanks,

        Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk93MxQACgkQnZxG0T6qDD17GgCeNJAQEV3gBcrBYOYC9vXbfgxU
IAkAoIWvgyn1Ge7CYWjtxaqjtON+qj8F
=t996
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

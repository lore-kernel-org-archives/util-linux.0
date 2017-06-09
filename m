Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:58089 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750934AbdFIEXf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Jun 2017 00:23:35 -0400
From: NeilBrown <neilb@suse.com>
To: Karel Zak <kzak@redhat.com>
Date: Fri, 09 Jun 2017 14:23:25 +1000
Cc: util-linux@vger.kernel.org
Subject: Re: [util-linux PATCH] umount: never 'stat' the path when "-c" is given.
In-Reply-To: <20170607105428.2st27zihhwpcnrwi@ws.net.home>
References: <8760gbduzp.fsf@notabene.neil.brown.name> <20170607094451.vcesromvdygstjmw@ws.net.home> <20170607105428.2st27zihhwpcnrwi@ws.net.home>
Message-ID: <87fuf9aiwy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07 2017, Karel Zak wrote:

> On Wed, Jun 07, 2017 at 11:44:51AM +0200, Karel Zak wrote:
>> On Mon, Jun 05, 2017 at 12:32:58PM +1000, NeilBrown wrote:
>> > diff --git a/libmount/src/context_umount.c b/libmount/src/context_umou=
nt.c
>> > index e663a703cca0..693891def0e1 100644
>> > --- a/libmount/src/context_umount.c
>> > +++ b/libmount/src/context_umount.c
>> > @@ -77,6 +77,7 @@ int mnt_context_find_umount_fs(struct libmnt_context=
 *cxt,
>> >  	 * it's usable only for canonicalized stuff (e.g. kernel mountinfo).
>> >  	 */
>> >  	if (!mnt_context_mtab_writable(cxt) && *tgt =3D=3D '/' &&
>> > +	    !mnt_context_is_nocanonicalize(cxt) &&
>> >  	    !mnt_context_is_force(cxt) && !mnt_context_is_lazy(cxt))
>> >  		rc =3D mnt_context_get_mtab_for_target(cxt, &mtab, tgt);
>>=20
>> I've changed the code to be the mount table filter also usable for
>> --no-canonicalize. It seems better to avoid mnt_resolve_path() than
>> avoid all the filter.
>
> Hmm... the filter seems like bad optimization for umount, because it
> triggers path canonicalization. I did some another changes and umount
> should be less aggressive with work with paths now.

I think I understand what you did, and it appears to still have the
desired effect for me, so I'm happy :-)

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlk6Ir8ACgkQOeye3VZi
gbm1sA//YfvdBAdnt5QFaKvHfmT9Idc06Tv8kWZzy4FJqlkJ35OIvPTyHaSxk5gJ
/y99U78qKjPPdL5wkjSeXGRvLl0a47QXkt2zUl0Lok4V639D0c2cS35qJlxw3bEc
KOngD9rB079hRJKoZviFcppe0/ph9zZ2nY68CEndud2nE0liGV8f70m0SHK+BxLG
rU0idvYiAs2MNx5MBuO40CKIhvanDxSP8aHoZr0ExojWQFuGNywBuqatr00522rK
R4vfGGGalVz6a88GTCcDdBupI6Fsocy0hGlLbhpHCMRh876ixSPpMcwf+i30CvrS
XddOb4DjHOBUKOTJckb9KzlwthlNcvL8QFofylx3mbJ5if1wzJiQxKI/DePTYhno
97nQxMwZZ9Dj00Gev3ku7WdBiU27w/B3v4Z9zMG9adjekXlV/hLeGRG/NP5DVGi3
ExS+KXWp1iWeVBB/h7Vg5UDFfI3uw7r3PfVRA3LsWh+HbebebPMc2wiSZg8iFtQB
Zdb9P/Upi4VpiwS47tN2ZIP9R6vcBGArMRuzvbKyyTkK9KtBlVvfmFKmdk12EKrr
/WgBLBN1US2PEve7wAcbfLQCpGsSeWc9/ko7o9cKfYuQjamMWCDchaF8sV/qctP6
yiV9XijKhtAzZsXlLGetVzfrhtD0C122X/mw8IxkDEyAuF6mxb4=
=RE3c
-----END PGP SIGNATURE-----
--=-=-=--

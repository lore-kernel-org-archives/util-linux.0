Return-Path: alnovak@suse.cz
Date: Tue, 9 Aug 2016 09:58:56 +0200
From: Ales Novak <alnovak@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, nfbrown@suse.com, jeffm@suse.com
Subject: Re: [PATCH] libmount: after colon, ignore double slashes in path
 start
Message-ID: <20160809075856.d6hcl5m2uawnrc7z@alesak.suse.cz>
References: <1469018169-5650-1-git-send-email-alnovak@suse.cz>
 <1469018169-5650-2-git-send-email-alnovak@suse.cz>
 <20160808153034.vnmpc76o5psdq4z6@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nlyhrqrjipk6vmss"
In-Reply-To: <20160808153034.vnmpc76o5psdq4z6@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--nlyhrqrjipk6vmss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 08, 2016 at 05:30:34PM +0200, Karel Zak wrote:
> I have applied a different patch (see commit d4e89dea4e8e95cee0cede39dc77=
618a181b8d19).
>=20
> It seems like a generic problem and we should be robust enough to
> ignore redundant slashes (///aaa/bbb /aaa/bbb/ ...etc).
>=20
> Please, re-test if the solution works for your use-case.

Good, that looks perhaps better. It does fix my use-case. Thank you!

--=20
Ales Novak
SUSE L3

--nlyhrqrjipk6vmss
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqY0+AAoJEGOSdXQ6V/clco4H/3jpgtTzGj9qUhcM0/3OcGik
AUMMnkLqvBgVvL5BgBhtPtaKuFR9V0YwTJM+CfyHHQtjCQKM9fdF+ZrexllTYZEr
svwPVr9wG7H+c4r9bdbdl05hqHaG+bHW4c2/HW8vy83PIKcXKuAK5vvhMUDrvW94
jEPn2Q/Jfke1I6TVVqZBckTOXjLSIPj3+Z+OxgWglcAJaOHAaF6YFVedSXRKGSWQ
6BoiLMDt6khpRWu0pKjW2jBFaZkF4KCm4NbQxER9ks9DBvhtruJVRgi0bQE4Yq9R
JwKCyl2aN6aESekch+0oc0z4Rk7r6dmNQZvodvTwyHdMgYkCGbhCs3HIOsgDkBU=
=TGkB
-----END PGP SIGNATURE-----

--nlyhrqrjipk6vmss--

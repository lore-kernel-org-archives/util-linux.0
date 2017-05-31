Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:44291 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751030AbdEaDFf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 May 2017 23:05:35 -0400
From: NeilBrown <neilb@suse.com>
To: Karel Zak <kzak@redhat.com>
Date: Wed, 31 May 2017 13:05:26 +1000
Cc: util-linux@vger.kernel.org
Subject: Re: "mount -o remount,rw" sometimes doesn't work as expected.
In-Reply-To: <20170522112635.bcnfvxuqi7xbifb5@ws.net.home>
References: <87wp9djp2n.fsf@notabene.neil.brown.name> <20170519091125.bdans7hirua3blb5@ws.net.home> <87r2zhkg8r.fsf@notabene.neil.brown.name> <20170522112635.bcnfvxuqi7xbifb5@ws.net.home>
Message-ID: <87zidtenex.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, May 22 2017, Karel Zak wrote:

> On Mon, May 22, 2017 at 08:16:36AM +1000, NeilBrown wrote:
>> oooh... it just occurred to me that for a mount, I can make it
>> read/write by:
>>=20
>>    mount -o remount,rw none /mount/point
>>=20
>> providing I know that no other flags are needed.  I don't need to give
>> the correct device path, do I?
>
> Yes, "none" is an usable placeholder there.
>
>> > After this call, mount reads fstab and merges these options with the
>> > options from the command line (-o).  If no mountpoint is found in
>> > fstab, then a remount with  unspecified source is allowed.
>>=20
>> BTW, if fstab contains just
>>=20
>>    /bar /foo none bind 0 0
>>=20
>>=20
>> Then both
>>   mount -o remount,rw /bar
>> and
>>   mount -o remount,rw /foo
>>=20
>> will try to remount /foo.  This is also surprising....
>
> Yes, mount(8) goal is to accept "whatever" to keep users happy :-)
>
> This your example is well known disadvantage, the solution is to use
> --source and --target options (it's strongly recommended for scripts):
>
>    mount -o remount,rw --source /bar
>    mount -o remount,rw --target /foo
>
> in this case mount(8) will not try to be smart...
>
> ...
>
>> >> You could possibly argue that the current behaviour is correct
>> >> as /foo is listed as bind mount.  That doesn't stop is being surprisi=
ng.
>> >> Also
>> >>    mount /bar /foo -o remount,rw
>> >>=20
>> >> doesn't pick up the "bind" flag, so the filesystem gets remounted.
>> >> So I think there is definitely something wrong.
>> >
>> > That's question... "remount,bind" is really special and maybe "bind"
>> > from fstab should be really ignored in this case.
>>=20
>> I think that is probably the best way forward, at least in the short
>> term.
>> I might try to dig into the code and see how easy this would be.
>
> It's trivial patch, see below. Seems to work as expected (I use
> "findmnt -o TARGET,VFS-OPTIONS,FS-OPTION" to see ro/rw).
>
>     Karel
>

Sorry for the delay.

Yes, this does look easy, makes sense, and does work as expected for me
too.

Reported-and-tested-by: NeilBrown <neilb@suse.com>

will you be queuing this for the next release?

Thanks,
NeilBrown


>
> diff --git a/libmount/src/context.c b/libmount/src/context.c
> index 38e0363..a574758 100644
> --- a/libmount/src/context.c
> +++ b/libmount/src/context.c
> @@ -2038,7 +2038,7 @@ static int apply_table(struct libmnt_context *cxt, =
struct libmnt_table *tb,
>   */
>  int mnt_context_apply_fstab(struct libmnt_context *cxt)
>  {
> -	int rc =3D -1, isremount =3D 0;
> +	int rc =3D -1, isremount =3D 0, iscmdbind =3D 0;
>  	struct libmnt_table *tab =3D NULL;
>  	const char *src =3D NULL, *tgt =3D NULL;
>  	unsigned long mflags =3D 0;
> @@ -2063,8 +2063,10 @@ int mnt_context_apply_fstab(struct libmnt_context =
*cxt)
>  		cxt->optsmode &=3D ~MNT_OMODE_FORCE;
>  	}
>=20=20
> -	if (mnt_context_get_mflags(cxt, &mflags) =3D=3D 0 && mflags & MS_REMOUN=
T)
> -		isremount =3D 1;
> +	if (mnt_context_get_mflags(cxt, &mflags) =3D=3D 0) {
> +		isremount =3D !!(mflags & MS_REMOUNT);
> +		iscmdbind =3D !!(mflags & MS_BIND);
> +	}
>=20=20
>  	if (cxt->fs) {
>  		src =3D mnt_fs_get_source(cxt->fs);
> @@ -2131,6 +2133,12 @@ int mnt_context_apply_fstab(struct libmnt_context =
*cxt)
>  		 * not found are not so important and may be misinterpreted by
>  		 * applications... */
>  		rc =3D -MNT_ERR_NOFSTAB;
> +
> +
> +	} else if (isremount && !iscmdbind) {
> +
> +		/* remove "bind" from fstab (or no-op if not present) */
> +		mnt_optstr_remove_option(&cxt->fs->optstr, "bind");
>  	}
>  	return rc;
>  }
>
>
>
> --=20
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkuMvgACgkQOeye3VZi
gbmlzQ/+OHGZoxiCLX2vAUId0lKy6hQL64Dj9NtugvvjmwIVrIGghHrZMnmHRgQr
TMxvHve7qYXYFOvaT6ozRXaga3LLkKvWyUxQVSg9eZgWuJ/bxTX7AFh4Be/fqJDJ
Ps5MZiqXnwc319SL/pW8Ms47FktyQf5iCpC8/cFJ+x70Ay6LZ3rPtozeTHqcnlsV
PVTlkAHOlpD97Bbegtol7trfzB0vKMEarAtyR8Lga61zAGLweRdReic+BwLKyFeG
KXfF6wC2gIsfTQbDGGiAHPVTZrYEsRi/6jqOPafcPQXo1qMGMNRfeWtv1QJe6tE+
ciSMlsCh/UEiineovHcVEZHfd010RWpWSSUQvwSk8DramP7doBBHO7/oGpepxlOm
M3QKNuKFVDLn27A41rLD5tmpM6JO280x95Vnx06lqgVbWnwQ0I090uA3hRYSJ7TT
87jnT3gI7FdAdHkoAE9BQX6cI9U35DGDM9+JpL6WpZMCt2LMwigvJg6Hf4yfTeQB
ua/QZGiB66Y9OQkQ80k+DdQFASbU5p+LV916FI/6Y3o09Jy/aCHV6DEb9gy46Pak
VpWIJKaLMYNmGJuugsNBhSSUGFYK1yMuKJvIx54v0Ic8HswLcP0t6yfDO3O6LlDw
Oksrm7/ZFXu0qF8ECo6iUdmjsAMJPGFF2OGj+km6HtDwsjFYIIM=
=/A2N
-----END PGP SIGNATURE-----
--=-=-=--

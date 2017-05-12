Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:51966 "EHLO
        resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758623AbdELRg1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 12 May 2017 13:36:27 -0400
Date: Fri, 12 May 2017 10:36:29 -0700
From: "W. Trevor King" <wking@tremily.us>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] WIP: mount.8: Split out fstab-specific mount options
Message-ID: <20170512173629.GG3035@valgrind.tremily.us>
References: <20170511122442.qwzpw7f6xdsc7im2@ws.net.home>
 <cee125bdea0faac3b4c9d7e856425fe9106756e7.1494510090.git.wking@tremily.us>
 <20170512075451.auqemicjfogreepq@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
In-Reply-To: <20170512075451.auqemicjfogreepq@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 09:54:51AM +0200, Karel Zak wrote:
> On Thu, May 11, 2017 at 06:48:54AM -0700, W. Trevor King wrote:
> > On Thu, May 11, 2017 at 02:24:42PM +0200, Karel Zak wrote:
> > > It's placeholder, but kernel uses some options like
> > > "rw,exec,suid" by default=E2=80=A6
> >=20
> > And these are =E2=80=9Ceverying marked with MNT_INVERT in optmap.c as w=
ell
> > as whatever filesystem-specific defaults=E2=80=9D, right?
>=20
> Well, inverted options may be used to invert previously used
> options.  The way how the options has been set is arbitrary
> (default, remount, on command line invert fstab setting, etc.). You
> can use it together on the same command line
>=20
>   mount -o async,noasync,foo,bar
>=20
> is pretty valid. The last used option win (=3Dnoasync).

Right, but the things with MNT_INVERT are the defaults (what you get
if none of the given options toggle the flag).

> > >    The "default" is interpreted as "auto" by "mount -a".
> >=20
> > This last line means "defaults" is effectively a synonym for "auto" in
> > fstab, an presumably "auto" would always be preferred (because it more
>=20
> More precisely, mount -a cares about "noauto" only, everything else
> is "auto".

Is that really true?  I think:

* =E2=80=98noauto,auto=E2=80=99 means the same thing as a bare =E2=80=98aut=
o=E2=80=99.
* With your wording, I'd expect =E2=80=98noauto,defaults=E2=80=99 to also m=
ean the
  same thing as =E2=80=98auto=E2=80=99 or =E2=80=98defaults=E2=80=99.  But =
looking at the code again,
  It still looks like =E2=80=98defaults=E2=80=99 is a no-op (not clearing
  MNT_MS_NOAUTO), so =E2=80=98noauto,defaults=E2=80=99 would be the same as=
 =E2=80=98noauto=E2=80=99.

If those are both right, I think we should adjust my patch to say that
=E2=80=98defaults=E2=80=99 is a no-op with no qualifications.

> > clearly marks the change from the "no flag bits set" initial
> > state).  I've started roughing out a sketch of where I think this
> > should go below, although there are a number of things that I'm
> > not clear on (e.g. are the X-* and x-* options in the same boat as
> > comment=3D*?  What is (no)sub about?).
>=20
> Yes, we use x- and X- for 3rd party options (e.g. x-systemd), the
> options are ignored for mount(2) syscall.

But are they only meaningful in fstab?  Or are there use-cases where
people would use them when calling mount(8) directly?

> > @@ -62,7 +62,7 @@ The following is a typical example of an
> >  entry:
> >  .sp
> >  .RS 7
> > -LABEL=3Dt-home2   /home      ext4    defaults,auto_da_alloc      0  2
> > +LABEL=3Dt-home2   /home      ext4    auto,auto_da_alloc      0  2
>=20
> I think it's fine to have an example with the placeholder, maybe add
> more lines to the example:
>=20
> LABEL=3DMyHomeDev   /home      ext4    defaults            0  2

I still don't see the point to using =E2=80=98defaults=E2=80=99 when you co=
uld have
the same config using the more explicit:

  LABEL=3DMyHomeDev   /home      ext4    auto                0  2

On the other hand, there's nothing special about =E2=80=98auto=E2=80=99.  Y=
ou could
also pick:

  LABEL=3DMyHomeDev   /home      ext4    rw                  0  2

or any of the other MNT_INVERT options.  Using =E2=80=98defaults=E2=80=99 s=
ays one of
a few things:

a. I have no preferences, and:

   i. Opening mount(8) to see which of (no)auto is the default is more
      work than I want to invest.
   ii. I can't think of an option where I can rely on the kernel or
       libmount to preserve the current default (e.g., there's a
       chance that the kernel makes ro the default, and a chance that
       libmount makes noauto the default, etc.)

b. I don't understand what =E2=80=98defaults=E2=80=99 does.

Case a seems like a very unlikely position.  There may be users who
don't care what the (no)lazytime default is, but are there users who
don't care about (no)auto or ro/rw?  Perhaps there are (and they can
use =E2=80=98defaults=E2=80=99 to get that behavior).  Case b seems much mo=
re likely,
and I think using =E2=80=98defaults=E2=80=99 as the =E2=80=9Ctypical exampl=
e=E2=80=9D will confuse
readers who expect the man-page writer to understand =E2=80=98defaults=E2=
=80=99 (and
so fall into case a.ii?).  I think =E2=80=98auto=E2=80=99 and =E2=80=98rw=
=E2=80=99 are both extremely
likely to remain defaults, but the kernel would cause more backwards
compat issues by swapping the default there, so:

  LABEL=3DMyHomeDev   /home      ext4    rw                  0  2

is probably the best =E2=80=9Ctypical example=E2=80=9D.  And the =E2=80=9Cp=
aranoid example=E2=80=9D
would be:

  LABEL=3DMyHomeDev   /home      ext4    auto,rw             0  2

for =E2=80=9Clibmount might go crazy and change it's mind so I'm pinning the
current =E2=80=98auto=E2=80=99 default=E2=80=9D.

> LABEL=3DMyOptDev    /opt       ext4    auto,auto_da_alloc  0  2

With =E2=80=98auto=E2=80=99 being a default that libmount is unlikely to ch=
ange, the
example should probably be:

  LABEL=3DMyOptDev    /opt       ext4    auto_da_alloc       0  2

> > -Basic filesystem-independent options are:
>=20
> It's probably good idea to maintain the options description on one place,=
 but it=20
> would be nice to add note about mount(8), something like
>=20
>  For filesystem-independent options see mount(8).

The paragraph before the line I removed ends with:

  For details, see mount(8) or swapon(8).

and that line predates my patch.

> > -.B async
> > +.B async \fR(default)
>=20
> Please, don't use "(default)" there. We don't control what is the
> default. It does not have to be the same for all kernels (and kernel
> versions).

Hmm.  True, I guess, although I'm not sure how the kernel would change
a default.  Say Linux decides to make =E2=80=98sync=E2=80=99 the default.  =
They add a
new MS_ASYNCHRONOUS and error out if somebody sets both MS_SYNCHRONOUS
and MS_ASYNCHRONOUS.  After a number of years (during which we can
update the manpage to warn about the switch), they swap the default
when neither MS_SYNCHRONOUS nor MS_ASYNCHRONOUS is set.  The updated
man page would be something like:

  async (default before Linux 8.3)
    =E2=80=A6
  sync (default in Linux 8.3 and later)
    =E2=80=A6

I think documenting the kernel defaults is useful (less digging for
interested users).  In the very unlikely scenario that the kernel (or
libmount) swaps a default we will almost certainly have a long swap
time to update the docs in this way.

If either project sets up something where the default could be swapped
without warning (e.g. they provide bits for MS_FOO and MS_NOFOO and
make no statement about the planned kernel version for the default
swap), then we should definitely call that out explicitly:

  foo (default in Linux 12.2)
    Set foo.

    WARNING: Future Linux may make nofoo the default value without
    warning.  Users who have a preference should explicitly set either
    foo or nofoo to protect themselves from such an occurrence.

  nofoo
    Unset foo.

    WARNING: Future Linux may make this the default value without
    warning, see foo for details.

The only time you'd *not* be able to prepare users in the man page
would be if Linux or libmount just went and swapped the default
without providing developers with a migration plan.  I think that's
unlikely enough that we can ignore it and just document the kernel
defaults.

> Maybe rather than "FSTAB-SPECIFIC ..." use two subsections, one for
> kernel and another for user-sapce:
>=20
> .SH FILESYSTEM-INDEPENDENT MOUNT OPTIONS
> .SS Generic kernel mount options

Sounds great; I'll do this in v2.  Would you like me to work that up
now, or would you rather kick around the other issues above more
before a reroll?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzPwEBOWrShjRNpy5EGmhBWBcmDUFAlkV8pYACgkQEGmhBWBc
mDWjfBAAtT8FcDjSN1ScCBK0t3ko0bUJf+6hT9tgY96V/a8uX95ECc0zpVKIRdpP
v3JNM9QyCMYwGdjIDFTuIU61PetLnSKWiW24+3TzYv8RXAdKiWkKkYhxjiI7saJT
dq4oj0scfoDZ1SHRnkMb1EPouqVHXCAIbV8BTbEQuKGhSJhZF1nVVihWjpmPe6zj
0lHRzAT4hDxNRP8bqBY4brlIwDqGJABIwj+LdD49TxfYnKDzF5e7Z39casQl2qf7
rpMNj7bX3812/dXcH1FAKioNyZq2xk7ToEN6eZ4ReZqZO2ekyR9ViiM/TgpN2R+H
/Pzgv/w5Wd+MwhxDLmP8pR3s6yK4KO3wPsZWT/dL6moJYWVXvabrnMUBp7NG112r
3kfCtzNXazYLKEE648ULcNqQaSZ93W2pgT+g9kNe2OnpuRA3b0oruCG030f6Ju7E
dKEmZiRc8EZq2EV8lPD1VP6fP+S4oxCFgWpZy9eNEznZFM4OzYZ+D7ZbMUw0Iv6p
RwF8clVmXzOYfVHbvEI0prvs3pAEZMlslcSk0/iDviSD7dSC03uozuqxnLgPIV+a
UF9ozh9SNH8QcpybTOa5yf5bp4uu2uh6eWS5WxPI7HC0pWzwM6XZJRkfywpEVmV4
GtG01TVJFxSFdSos0u5+uolQ/EAL86Y8hh+P6YckY2FFwbUVM0Q=
=HitK
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--

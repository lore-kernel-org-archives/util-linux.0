Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:48030 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932405AbdEKLul (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 May 2017 07:50:41 -0400
Date: Thu, 11 May 2017 04:40:32 -0700
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Subject: libmount: Is the 'defaults' option intentionally a no-op?
Message-ID: <20170511114032.GB3035@valgrind.tremily.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm having trouble squaring the docs in mount(8) [1]:

  defaults
    Use the default options: rw, suid, dev, exec, auto, nouser,  and
    async.

    Note  that  the real set of all default mount options depends on
    kernel and filesystem type.  See the beginning of  this  section
    for more details.

and fstab(5) [2]:

  defaults
    use default options: rw, suid, dev, exec, auto, nouser, and async.

with the implementation [3]:

  { "defaults", 0, 0 },               /* default options */

where the struct fields are [4]:

  * @name: option name[=3Dtype] where type is printf-like type specifier")
  * @id: option ID or MS_* flags (e.g MS_RDONLY)
  * @mask: MNT_{NOMTAB,INVERT,...} mask

As far as I can tell, that makes 'defaults' a no-op.  For example, it
doesn't clear MS_RDONLY:

  # strace -o /tmp/trace mount -t tmpfs -o ro,defaults - /tmp/a
  # grep 'mount(' /tmp/trace
  mount("-", "/tmp/a", "tmpfs", MS_MGC_VAL|MS_RDONLY, NULL) =3D 0

But using =E2=80=98rw=E2=80=99 directly does:

  # strace -o /tmp/trace mount -t tmpfs -o ro,rw - /tmp/a
  # grep 'mount(' /tmp/trace
  mount("-", "/tmp/a", "tmpfs", MS_MGC_VAL, NULL) =3D 0

And as you can see in those strace logs, the presence of =E2=80=98defaults=
=E2=80=99 in
userspace_opts_map means that it doesn't get passed through in
mount(2)'s =E2=80=98data=E2=80=99 argument either.

I can think of a few possibilities:

a. =E2=80=98defaults=E2=80=99 is supposed to be a no-op placeholder for the=
 fourth
   fstab field.  We should drop it from examples that set any other
   options (like [5]) and update the man entries [1,2] to remove the
   references to =E2=80=98rw=E2=80=99, =E2=80=98suid=E2=80=99, etc. and rep=
lace them with markers on
   the inverted settings listed by:

     $ git grep MNT_INVERT libmount/src/optmap.c

   This makes it clear that =E2=80=98defaults=E2=80=99 doesn't *change* any=
thing or
   return you to the default values of some subset of settings.

b. =E2=80=98defaults=E2=80=99 is supposed to mean =E2=80=9Czero mountflags=
=E2=80=9D (and maybe also
   =E2=80=9Czero data=E2=80=9D?).  In this case, like case a, we should dro=
p it from
   examples that set any other options (like [5]).  We should update
   the man entries [1,2] to explain the clearing.  But I don't know
   why anyone would ever use this option except on its own as a
   fourth-fstab-field placeholder (like case a).  Presumably whoever
   is inserting =E2=80=98defaults=E2=80=99 in the mount options could just =
remove all
   the earlier entries (e.g. using "bar" instead of
   "foo,defaults,bar").

c. =E2=80=98defaults=E2=80=99 is supposed to be shorthand for
   =E2=80=98rw,suid,dev,exec,auto,nouser,async=E2=80=99.  It should be impl=
emented
   with something like:

     { "defaults", MS_RDONLY | MS_NOSUID | MS_NODEV | MS_NOEXEC | MNT_MS_NO=
AUTO | MNT_MS_USER | MS_SYNCHRONOUS, MNT_NOHLPS | MNT_INVERT | MNT_NOMTAB},

   (although I have no idea if using MS_RDONLY flags in
   userspace_opts_map is viable.  It probably isn't).

   Altenatively, it could be implemented by removing the entry from
   userspace_opts_map and adding a pre-processing step that replaces
   shorthand (e.g. mapping "foo,defaults,bar" =E2=86=92
   "foo,rw,suid,dev,exec,auto,nouser,async,bar") before iterating over
   the options in mnt_context_merge_mflags.  The man entries [1,2] are
   fine.

d. I'm missing something obvious ;).  We may want some really small
   words in mount(8) to keep others from falling into the same
   misunderstanding that I've fallen into.

Regardless of which case is correct, we may want to annotate the
inverted flags (as I mentioned in case a), since that (combined with
the existing default caveats in [6]) explains the =E2=80=9Cwe will call
something close to mount(source, target, filesystemtype, 0, NULL)=E2=80=9D
starting point, and folks might not think =E2=80=9Clet me look up the
=E2=80=98defaults=E2=80=99 docs=E2=80=A6=E2=80=9D when they're trying to fi=
gure out if the default is
dev or nodev, etc.

Thoughts?
Trevor

[1]: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/sy=
s-utils/mount.8?h=3Dv2.29.2#n935
[2]: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/sy=
s-utils/fstab.5?h=3Dv2.29.2#n172
[3]: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/li=
bmount/src/optmap.c?h=3Dv2.29.2#n138
[4]: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/li=
bmount/src/libmount.h.in?h=3Dv2.29.2#n58
[5]: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/sy=
s-utils/fstab.5?h=3Dv2.29.2#n65
[6]: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/sy=
s-utils/mount.8?h=3Dv2.29.2#n824

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzPwEBOWrShjRNpy5EGmhBWBcmDUFAlkUTaQACgkQEGmhBWBc
mDW+bhAAwxwMqIJYW6zdIyxCbSazEjlwR/PU5PjaDbepPN4Tz4B3scVVfKsS6/Cl
otIeLoBIr6flgElJnvK7S7siY1V7sXno6FMAUTdr6oQy5xONjyNBnHfsBYzy8cDd
d3fLXfxCJj/zjIfrEahONpDBmNr7tZYrD8VVsmXtu9EqgHo9eQGCFyF+MSi2ibar
HrAEgHjSpJZ0OaMAGtJ7/GCSJaFvpSFvzGQDudadH4gUeuQ5LYlDJoXYrKrZJmjX
DlMa0npvivzzwxu+itI42g0DHpl4Jg0YT7PQUhZKAQKzhdl4mtzFw9jrGzxxjf+X
db3i/5ayNpzeOPnjf6C6PS5RDqfKtodc/WPmsMau4glFjz43ND4mKi1VC37maf3i
wr9mFp4amthBhYHwuiJvtWWb9eBvj5A3M/pkXXSZjbUvwda/te7/X4tlpQyEiJ8S
dNTrRSQf2cho1QkZPRpXXu/9YDFFSXBNSz8Q5D7x2Mkt7nrDPcnaBlLXbEvv0sqJ
XheWqwboViI7P/fWsggtqAb6l0+9cVTH0rfnkqjmOO4VOtHYljjh3NKXXqDPfe3H
qRFmCBqBtR9Efu7Gls0quUYpqvD88xfMjIMNOf4028BQy6wQWCODYl2viMHMA3Kq
Qk7AYpiP51u1FDXEtu01kQZPo90P6vX26YwwtQZjraY08y6s/qc=
=8FFr
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--

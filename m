Return-Path: thomas@archlinux.org
Message-ID: <534541E3.4080906@archlinux.org>
Date: Wed, 09 Apr 2014 14:49:39 +0200
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>
CC: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404091207.56691.sweet_f_a@gmx.de> <20140409110251.GT22126@x2.net.home> <201404091412.34060.sweet_f_a@gmx.de>
In-Reply-To: <201404091412.34060.sweet_f_a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K46Bps3qPSi3ujjg0c2vLKjpVcb8KONtH"
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K46Bps3qPSi3ujjg0c2vLKjpVcb8KONtH
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 09.04.2014 14:12, schrieb Ruediger Meier:
>> well, "fstrim -a" contains heruistic to select the right filestems
>> (it really does not call trim for all devices), it has been
>> implemented to *avoid* sysadmins creativity. If you don't like it,
>> you can use "fstrim <device>" (for example from crontab).
>=20
> I'd like the documentation more detailed.
> Does it really run on all mounts or only /etc/fstab?
> Does it write on automounted devices which are probably not owned by th=
e=20
> admin? Does it affect read-only mounts?

The documentation is precise here:

'Trim all mounted filesystems on devices that support the discard
operation.'

It says exactly what it will do. Every one of your questions is answered.=


> IMO the task itself is already installed since we have fstrim's=20
> option -a". You just need to _enable_ it to run whenever you want for=20
> example by using crontab. That's trivial.

Because it takes time. I have done it four times already and it cost me
several minutes each time. Now nobody has to do it again.

> Nobody would have thought about adding a 1-liner cronjob file to=20
> util-linux eventhough any distro has /etc/cron.daily/. But now systemd =

> timer? Thats what I don't understand.

I don't know why nobody thought about doing that in the past, maybe
nobody cared about the needs of all those other admins. Maybe because
installing a file into cron.daily automatically enables it. Maybe
because nobody cared about anything but his own system?

> If _creating_ a systemd timer is too complicated for today's admins

It is not complicated, it is just a task that shouldn't be repeated
countless times.



--K46Bps3qPSi3ujjg0c2vLKjpVcb8KONtH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTRUHlAAoJEChPw0yOSxolvXkQAJEbK0ZhwiCbK9HeNKKYd58i
VBFAiNoIGckcDqOkoEOz1XPWzk/LJ5r55akVzNXehidpVvN1KeGQTyVOyAyWTnfV
O5MKfRzCbTdU+H7hRHoyKM7YEQEJu7Nfd/+Ep7WWQEmrGALw0OY0ifg/K2HVjOs2
OtQUs9g1uu0+RSVrRcar46T6QKqjmvLZZ6P+QogdJXN6+alx56A1lZa1XKx8fqFs
N4TfL8YjZP3r79VvVFXNEr/X6uSLggjbjfxJFw6sxsnb7ttcQF3UtcIGm1yQaQjH
sNB1g8R4qizjuDY7B91dzkrY5Rhj1NIWWVw3tAg2co/tZpIKZZWEsJbh9bUa5/Rx
FomMxuK5AOkb3pE5g/unWKCXiRuRpZ+APXW3RjagUh+PDJWIGK7P2BCrvMg0cI3r
9NUk8ASAQTgZ5ULNsmVIH7cY4k/+rgELRRTXm9xnWh+PPZDTUWEbiGDwvCmNAPo2
sAywDwn++lad29agKFus+eZ5Wa4gcZUr+kKTWN7nKBMIIr2YQbL5hsaG8mJeGlHK
s+3XSKlAsQqEmixS3wOLQHq1AZD9nGYywaMB4mZyr5SC/TSDlcjk0qDDdIQzyofV
PhEQ8A0K2n1Q1SKIgYTmi0ILjw8tEUK0pPVHOKkONMUi5cHfEr1uaEfF4bi+fHNX
jRQSCn7mICHQeOhi18Fp
=5ka1
-----END PGP SIGNATURE-----

--K46Bps3qPSi3ujjg0c2vLKjpVcb8KONtH--

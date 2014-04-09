Return-Path: thomas@archlinux.org
Message-ID: <5345663A.1050403@archlinux.org>
Date: Wed, 09 Apr 2014 17:24:42 +0200
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>,
        =?ISO-8859-15?Q?Thomas_B=E4chler?=
 <thomas@archlinux.org>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404091412.34060.sweet_f_a@gmx.de> <534541E3.4080906@archlinux.org> <201404091716.05131.sweet_f_a@gmx.de>
In-Reply-To: <201404091716.05131.sweet_f_a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2UcwNPhVbnHchmHRgrBV0tKQh7SEGOXUR"
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2UcwNPhVbnHchmHRgrBV0tKQh7SEGOXUR
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 09.04.2014 17:16, schrieb Ruediger Meier:
> On Wednesday 09 April 2014, Thomas B=E4chler wrote:
>> Am 09.04.2014 14:12, schrieb Ruediger Meier:
>>>> well, "fstrim -a" contains heruistic to select the right filestems
>>>> (it really does not call trim for all devices), it has been
>>>> implemented to *avoid* sysadmins creativity. If you don't like it,
>>>> you can use "fstrim <device>" (for example from crontab).
>>>
>>> I'd like the documentation more detailed.
>>> Does it really run on all mounts or only /etc/fstab?
>>> Does it write on automounted devices which are probably not owned
>>> by the admin? Does it affect read-only mounts?
>>
>> The documentation is precise here:
>>
>> 'Trim all mounted filesystems on devices that support the discard
>> operation.'
>=20
> If this is 100% true then Karel's statement 10 lines above would be=20
> wrong.

There is no contradiction between this and what Karel said. I think you
are confused and should read both statements again.

> Also this doc line indicates that even read-only mounts could be trimme=
d=20
> (if FS supports it) which would be at least dangerous if it runs=20
> automatically while admin is trying to repair a broken filesystem.

The documentation says nothing about excluding read-only file systems,
that should probably be changed (but it is not something that I,
personally, am terribly concerned about).

>> It is not complicated, it is just a task that shouldn't be repeated
>> countless times.
>=20
> Now you still need to enable it "countless times" which I would do usin=
g=20
> rsync or git anyway like I would sync self created timers, crontabs or =

> whatever config files with same effort.

This is getting annoying. It is your opinion that we should not add
useful things because we haven't done so in the past, or because someone
might want to do it slightly differently.

I submitted it, Karel added it, period. There's no point continuing this
argument.



--2UcwNPhVbnHchmHRgrBV0tKQh7SEGOXUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTRWY9AAoJEChPw0yOSxolrBIP/2RCjtmpX7obYYJEk2+3m2WI
Gbkan/CJW+QpX4ZIxdxFtsD/T/xAjnUkh5ZYTAhlXC0K7b+cgxxN/flYv7WJgHPI
BJw2qCDgJPG0gDswULWKAsGBhkilL7Zs46s5PKGbdfcc1HiLYnd1A/Ppw6Ksasks
AWUUekqKVd6TquDEdQkquX5Wje1rgivZgf6ktA5P107n89Nh2MaEUGdNoQRpcT4K
Pto+RVfRO2ttTCxu6ezS3qYvLZmWbSnzGj2ohybPe5HN5MEiwWjvgDl2X9C+emoX
tq7T7AD6+kWyX1qU19HYkCMUd7HWz6pcPu5OhKcYFWzdV9hNn/dbSsXdxhCuEOem
go1Lvf2GIyAGXfz7vIeexX3dukXuLBaD9NeyIziPxEeGJjAygtQ/jOk7itbit9Xl
9tjcWCNOEvdm6l4NoZzr4AeYcytATr/epmCvrCyBO8LpxfiGYa9pWomVQ5v/3jlY
vW9IDpOhznQCPeEwz5Qpu/FUCPRmfcFeWWUBVAXOs6qXoQhZBIRd+oP22waMZt6t
KvEpDNYaznYGNO7qtOtN6EZlZmhhvZ4nHkCV4ODmCEghXzrE+OQe2hr5P+TIUS1z
z+wseX1m9DFyQC+Et/pcTPbKe2DjTHOHDYatSfLMsfj8tT0eRZcACfR44fGoFnpw
Ns8lBHE1ky0IFcikF6Pr
=1Vuj
-----END PGP SIGNATURE-----

--2UcwNPhVbnHchmHRgrBV0tKQh7SEGOXUR--

Return-Path: jeffm@suse.com
Message-ID: <51471122.6030804@suse.com>
Date: Mon, 18 Mar 2013 09:05:38 -0400
From: Jeff Mahoney <jeffm@suse.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] loopdev: sync capacity after setting it
References: <51438CF9.7020707@suse.com> <5145D0B4.1070207@suse.com> <20130318092700.GC2172@x2.net.home>
In-Reply-To: <20130318092700.GC2172@x2.net.home>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2REBBSDAACWWLAGOSWRRB"
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2REBBSDAACWWLAGOSWRRB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 3/18/13 5:27 AM, Karel Zak wrote:
> On Sun, Mar 17, 2013 at 10:18:28AM -0400, Jeff Mahoney wrote:
>> On 03/15/2013 05:04 PM, Jeff Mahoney wrote:
>>> I recently tried to mount an hfsplus file system from an image file w=
ith
>>> a partition table by using the loop offset and sizelimit options to s=
pecify
>>> the location of the file system.
>>>
>>> hfsplus stores some metadata at a set offset from the end of the part=
ition,
>>> so it's sensitive to the device size reported by the kernel.
>>>
>>> It worked with this:
>>> # losetup -r -o 32k --sizelimit=3D102400000 <loopdev> <imagefile>
>>> # mount -r -t hfsplus <loopdev> <mountpoint>
>>>
>>> But failed with this:
>>> # mount -r -oloop,offset=3D32k,sizelimit=3D102400000 <imagefile> <mou=
ntpoint>
>>>
>>> # losetup -a
>>> /dev/loop0: [0089]:2 (<imagefile>), offset 32768, sizelimit 102400000=

>>> /dev/loop1: [0089]:2 (<imagefile>), offset 32768, sizelimit 102400000=

>>>
>>> /proc/partitions shows the correct number of blocks to match the size=
limit.
>>>
>>> But if I set a breakpoint in mount before the mount syscall, I could =
see:
>>> # blockdev --getsize64 /dev/loop[01]
>>> 102400000
>>> 102432768
>>>
>>> The kernel loop driver will set the gendisk capacity of the device at=

>>> LOOP_SET_STATUS64 but won't sync it to the block device until one of =
two
>>> conditions are met: All open file descriptors referring to the device=
 are
>>> closed (and it will sync when re-opened) or if the LOOP_SET_CAPACITY =
ioctl
>>> is called to sync it. Since mount opens the device and passes it dire=
ctly
>>> to the mount syscall after LOOP_SET_STATUS64 without closing and reop=
ening
>>> it, the sizelimit argument is effectively ignroed. The capacity needs=
 to
>>> be synced immediately for it to work as expected.
>>>
>>> This patch adds the LOOP_SET_CAPACITY call to loopctx_setup_device si=
nce
>>> the device isn't yet released to the user, so it's safe to sync the c=
apacity
>>> immediately.
>>
>> It turns out this ioctl wasn't introduced until 2.6.30. I'll fix that =
up and
>> resend tomorrow.
>=20
>  Do you mean #ifdef LOOP_SET_CAPACITY? I can fix the patch manually.
>=20
>  (It seem that we already use this ioctl in code without any extra
>   care about old kernel and nobody complains :-)

Yeah, but that's in losetup --set-capacity where it's an explicit
operation. This change will add the ioctl into every
loopdev_setup_device call when the offset or sizelimit options are used.
If it isn't supported by the kernel, the ioctl will fail silently and
*maybe* the mount will fail, but that's totally dependent on the the
file system. If the mount succeeds, it will be done outside of the
parameters the user requested.

So, all I really want to do is dump an error message when the ioctl
fails with -ENOTTY || -EINVAL about there being a lack of kernel
support. We shouldn't allow the device configuration to proceed.

The part that makes it more "fun" is that a few patches in 3.9-rc1 fixed
this in the kernel, so it won't actually be needed for new kernels.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


------enig2REBBSDAACWWLAGOSWRRB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.18 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJRRxEiAAoJEB57S2MheeWy5rgQALBc+vTI8tILhlpupzn8ABQJ
Jj7ioIQLKn39nnNbH9QNxInV4VVZS0xNPBIfXQEEY95HFYkJ6QU3ASVj82X+6WNW
fqLr/C4ZONmlWjILO0YvdWHDvy9bxCE5d21Q5iNgwUJedQNdRIZdrEjEpzCQJw8g
ojn7cKR/dpMAZtbFPTm69BT0uMMIVOT3kHtiNnRjhbOyFxykLsaP0VwIpSVTSSaK
LyxlYFuJvq3oWUdR6LTTT61tBjKeHfdYb9n1hp59TR0RSS3gfa0bflnEH5zCV5OQ
DCYFcSG2KeCuTREiNv8BFJ0Z55nXI1NhuyUme8J0/dGAVktCJYYkXH++KR1C0HZ3
F/5OkLvzetGyku1p2MvZ5MALB1w42PglNfngY3BHMiQRrafZgSTDKLCXo/n4CHqP
YSCVT6iGKxhbE69+X0CeXmj/NiGCQOq4j59RkNmkD16AvcmSwt/GjixGYzWvS1iV
jdTr0W8i66O/TLHiVbvBzIkHGxe+1aSDdf2RNwAn/hxc5KYZTvx446unJH204RLR
jxTpxrqWhLEcPQbJiVU2yJ3NrNQs7+5xuuDm+Bv9/IyIL9Px/qWhvrTlk/quIqh6
h6DDpKShbHJ2UQb+GRnMErmBdYym7zQLB5iSW6TFM9/lRQR9wrswhDsbN+SW/Vh4
DhuK7EeleEiSGMDoAHL4
=a/M8
-----END PGP SIGNATURE-----

------enig2REBBSDAACWWLAGOSWRRB--

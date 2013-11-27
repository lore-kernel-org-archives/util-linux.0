Return-Path: psusi@ubuntu.com
Message-ID: <529605B7.3020903@ubuntu.com>
Date: Wed, 27 Nov 2013 09:46:15 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Marc MERLIN <marc@merlins.org>
CC: util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home>
In-Reply-To: <20131125103124.GQ5572@x2.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/25/2013 5:31 AM, Karel Zak wrote:
> This is definitely bug too, because Linux does not care about 
> partition type and kernel is able to use this partition:

Isn't the bug actually in the kernel, not parted?  An ID of zero means
the slot is unused, so it shouldn't be paying any attention to the
start and length.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSlgW3AAoJEI5FoCIzSKrwOiUIAIeaV+yAJZ4kDiU6OZU/jCwp
xIHnsyZ7Rg6XvaNBzgKl0RNuKx9ZvrcKJi2o/bmMr+k6dGl/vWO9/TbDfm5bP7gK
Z3Pt1GNbrPlXNwD0CQFoXbLi478vOcLG43/BfyISwc89BgKVosKFfVoeIL3YVFvM
okUJ9/W0Conasor9XXgT6xNdhEKelM80mWiNGzpUiruespVYO3AiDYp/SQvyfwyt
rAifX3tFNg5OULxL7DQSPlhpaknpnFwDB6wGzFW1ynR6vt+v/l3YBKAnczueMtex
X19qe4UiNkqHXtlCIvYI3W+MbasCbN/j/dtV7VcZfjvuBJEYX4uzRCq2eAcKxl0=
=+lAu
-----END PGP SIGNATURE-----

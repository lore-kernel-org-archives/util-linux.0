Return-Path: psusi@ubuntu.com
Message-ID: <52965E84.4070101@ubuntu.com>
Date: Wed, 27 Nov 2013 16:05:08 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Curtis Gedak <gedakc@gmail.com>, Karel Zak <kzak@redhat.com>
CC: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home> <529605B7.3020903@ubuntu.com> <20131127145840.GB32483@x2.net.home> <52963910.60800@ubuntu.com> <52964ED3.8030504@gmail.com> <5296515A.1070505@ubuntu.com> <529654CF.1010904@gmail.com>
In-Reply-To: <529654CF.1010904@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/27/2013 3:23 PM, Curtis Gedak wrote:
> IMHO Apple's choice of using an ID of zero for the firmware
> partition is a poor decision.  With that being said, these devices
> with this strange ID setting do exist in the real world.

So it doesn't bother the iPod if you change the id?

I'm thinking parted should throw an exception noting the broken
partition and offer to fix it by changing the id, or deleting it.
Changing the id would have the added benefit of keeping Windows from
overwriting it.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSll6EAAoJEI5FoCIzSKrwPCIH/2wSSKh/XT5J5fSpuqEG4NVq
+n/rhl8WpgfQhVjoAJbzoR9T6loDozdRXiqtunQ0kzGb8qreTiKmJJGMf/writiN
8PaFFyX+ga8geO6RALiTLp5yzNTUjUn8VGsaWwWozMwp5HsUte2lzVVcDPdKfY43
CBt8jXSXQxHyJlz2xbFlR2qo6/iGeUrYSI6rpoqMRnN6WU4KDBuZeJ3ByXg+Cli2
bFEGTr0B8lAJ3KSOWWBhOjSVpP22HypaTXI+xPth5LV4/AlbOuIZGuLk/uZSBnQF
ubv4xsodXfXcr97ZODUIstshKBS7pdVa33D2PE+4Yd0fOds0jWCSrKoubamIvCM=
=8DRl
-----END PGP SIGNATURE-----

Return-Path: psusi@ubuntu.com
Message-ID: <52963910.60800@ubuntu.com>
Date: Wed, 27 Nov 2013 13:25:20 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home> <529605B7.3020903@ubuntu.com> <20131127145840.GB32483@x2.net.home>
In-Reply-To: <20131127145840.GB32483@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/27/2013 9:58 AM, Karel Zak wrote:
> After 20 years it's feature ;-) as I'm almost sure that we cannot
> fix it and disable all partition where is no the ID.

While that's cute and all, I think we both know it isn't really true ;)

> And Linux kernel have never cared about partition type (this is
> not specific to MBR, the same behaviour we have for Sun, SGI, MAC,
> BSD, ..), only PT where we care is GPT (zero GUID is ignored).

True, the type does not matter... so long as it is !0.  Windows will
consider such an entry unused and happily allow you to create a new
partition using that space, so we certainly don't want to allow people
to make such a partition in fdisk, and the kernel really should ignore
it too.  To do otherwise will lead people to lose data when Windows
thinks the entry is unused.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSljkQAAoJEI5FoCIzSKrwLLcIAJSimXfgq9QaHGzijwFUaMh6
gaqYX+Q5vW8L4zla2+14Fz6iO+mMr25iADwCLJPVsCTFSvjXOviRrL8010uTGKDv
c3/mOmzLZbVLJcrIguWAqQmv2GjWUpmcNLrD2eWUYUwn/v+u0GS3wN7raeycmLoN
rSi885Hpw6ODSghTnYSJSIvV+ExI8eavDq62giLWVWUScHwFR1YA3sPBo8PssNb5
oz088bO/x6k1GiXWNxfI7XbSbpcV7FHSvAvwKtQ0UZpVkE2vBRp+kDzLnx6C4nOd
iXJRE/84WzyqjYbkn1HF6GOs/mWQe1okkNRalgSObaJQ47cZ4RCxHHT2fmehjow=
=cQks
-----END PGP SIGNATURE-----

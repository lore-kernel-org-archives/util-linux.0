Return-Path: psusi@ubuntu.com
Message-ID: <5283C4CC.5010200@ubuntu.com>
Date: Wed, 13 Nov 2013 13:28:28 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: external mount utilities and utab
References: <5273FF29.1090403@ubuntu.com> <20131104133735.GH23604@x2.net.home> <5277AA0C.70309@ubuntu.com>
In-Reply-To: <5277AA0C.70309@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/4/2013 9:07 AM, Phillip Susi wrote:
> Are you saying then that all of the helpers should now be using 
> libmount, and taking care of the utab updates themselves rather
> than just having mount do it?

ping... still wondering if the proper fix for this is to link
mount.cifs with libmount and make it suid, or if mount needs fixed to
do the utab update?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSg8TMAAoJEJrBOlT6nu75vV0H/RfDGiv5oPR+R2TsaABnd/GV
HMJ8AZfS322qdYjeMMyMTCTx9y/cy6fKzfW9q/JqyvQy6JNBq8LSFEve0Z298dwf
4JNvImDO1pjnXedMEvtN9X5NwxJbYpkY+LP9owg4LWP6d0RnLu8uwxNDHDpLp2Oi
PX2nbXHoUm8r8r6a3FfN1mVDqExhMbc5nJP7RCD6AqYzJ8ARz6x5/z3ei9u8UsT9
tctApV8wEvnGqdQufLXtP236pOplWnTMJ32RfIe7chM86T88MRheC5Mxq2MHjtZ4
slDJptr6dcTHAz8lY12J6mIZPpbLrb0mT9xOKmalivk8PJj0jkhj2/Fm9ejp87E=
=V2jT
-----END PGP SIGNATURE-----

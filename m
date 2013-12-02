Return-Path: psusi@ubuntu.com
Message-ID: <529CCC0D.70809@ubuntu.com>
Date: Mon, 02 Dec 2013 13:06:05 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: script input redirection / eof handling
References: <52726756.8060205@ubuntu.com> <20131202123659.GE5572@x2.net.home> <20131202125421.GF5572@x2.net.home> <529C9CFF.5030709@ubuntu.com> <20131202170208.GI5572@x2.net.home>
In-Reply-To: <20131202170208.GI5572@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/2/2013 12:02 PM, Karel Zak wrote:
> never ending orphans suck...

Yes, but the idea is not to orphan them in the first place and wait
for them to terminate instead.

> The possible solution (hack) to emulate end-of-file is by write
> "exit\n" to the master tty. For example patch below works for me
> (it also make it more robust for non-ttys).

That only works if the program on the other end knows what "exit"
means, which is basically only true if it's a shell.  Surely there
must be a proper way to signal EOF over a pty?  Can you use shutdown()
on a pty?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSnMwNAAoJEI5FoCIzSKrwwvYH+wRd0hXZwZKhElWgpLIjWNOO
82ulPzt1Cld085qllaG8VvO0CSN3JERHD5Eo8iB+YIuI32lNO2dGuGw0MwYJ72cn
whUEqT7BNcnDCDqhPba/ZYcGJ8mCp+3+58BDth8NPu+nma7d6V0n4sAbqO+w6uCS
VZOO9qo2cKYGqs7E2YYWLHBadMGkyLjpDd9j7ZsLxEe6ezb1vFLxSmJQ3CiNLz+i
q2okm0GUipkhMAMCC8zuV1GnUf5sJuSx6QiSkIE5Mok9d8HqOtXTt8F7URAa+YVC
tBtM7dMIfXEQCJil16hTn+KdgiAtNE4BaGkyevW2kohwmKQgKU51/CHlofWGK1s=
=6Ihg
-----END PGP SIGNATURE-----

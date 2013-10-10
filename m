Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:64142 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab3JJR3Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 10 Oct 2013 13:29:16 -0400
Message-ID: <5256E3EA.4000304@ubuntu.com>
Date: Thu, 10 Oct 2013 13:29:14 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: util-linux@vger.kernel.org
Subject: Re: Filesystem specific mount options mixed with auto fs type
References: <5256B7CF.7010103@ubuntu.com> <20131010170330.GA19031@citd.de>
In-Reply-To: <20131010170330.GA19031@citd.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/10/2013 1:03 PM, Matthias Schniedermeyer wrote:
> AFAIK "mount -s" is just for that case:
> 
> - man mount - -s Tolerate sloppy mount options rather than failing.
> This will ignore mount options not supported by a filesystem type.
> Not all filesystems support this option. This option exists for
> support of the Linux autofs-based automounter. - man mount -

This doesn't seem to actually work.  Trying to mount an ext2 fs with
the utf8 option still fails with an unknown option error.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSVuPqAAoJEJrBOlT6nu75svUH/0zi7revng47Q7PUWkV7g1qq
nMqwYyRYlC2txaBoote53gKxGoRuppvp43f2IvrMgGNTpnwPgoJdGKHSPA/wW7b6
5jzLanmozlWBvmEOOZD9HLR1RYmb/sexQAaRL99zHy5q2Bk9L+81fDp0AsK8lnNl
rHn3CJ1iKGLTTcB0CSvjayrs7r1zdIRNF31NVgV83CN9LaMdrtYGuY8bLgi9+3RF
aedqpR9PZztXPhf3lQz1CR/EToJO6fDX2IxJ0KuThCtUvT1aq1r++eJTNjHgp2mm
iwGj/b4GeEMYKtyIdzp4RPOjLL4LvuhKL2SKw6TytDiOwfzBCp5WDIJod6KA1WA=
=XX4w
-----END PGP SIGNATURE-----

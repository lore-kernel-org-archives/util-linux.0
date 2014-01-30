Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:60569 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbaA3OPN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jan 2014 09:15:13 -0500
Message-ID: <52EA5E6F.6040203@ubuntu.com>
Date: Thu, 30 Jan 2014 09:15:11 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
References: <52E91888.4080601@ubuntu.com> <20140130081651.GE22884@x2.net.home>
In-Reply-To: <20140130081651.GE22884@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/30/2014 3:16 AM, Karel Zak wrote:
> everyone switched to our switch_root :-)

Except apparently for the systemd folks, which for some odd reason
like the idea of keeping around the initrd for the life of the system
so init can "return" to it ( yuck! ).

> Anyway, I don't see any info about pivot_root syscall deprecation
> in Linux kernel source tree.

Me neither, but then why switch_root?  I thought the whole reason it
came about was because Linus et al considered pivot_root() to have
been a terrible idea.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS6l5vAAoJEI5FoCIzSKrwaXoIAJ+aU1qEbvIjUqyZjQmbf3tV
zvDLwxK+BGtf7YYjqpe/SaU6nfusdjyALiLUYvwhbT4QbjBqxhcvbbNhe9Om0VSC
ClOdL/+aeHhjmy5GENeeaT1QKmVj5k/lHe/8u0eAF4Ha9GDPeSctq7ExhO1NzRVw
kibYrlMWrSKa4NrAw0lJYGQUrCMnksRqvLPM8r5T1xW6+GzUgideHR4K40i7sVnk
tNAQKdgTn8E3R0vUZfNIFvIlLwcZFWCjJxIFXB5ibq3zauNtW9kCU86r9+lN1E7I
ZHywaMb/w7qlFLDXrNMp0EPP8gisfhEFalWjhERraSeJthH4s865u6tFKCts7Dw=
=TQZ1
-----END PGP SIGNATURE-----

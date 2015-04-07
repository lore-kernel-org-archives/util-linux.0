Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:56719 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752673AbbDGBFJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Apr 2015 21:05:09 -0400
Message-ID: <55232CF8.4090805@ubuntu.com>
Date: Mon, 06 Apr 2015 21:03:52 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Felix Miata <mrmazda@earthlink.net>, util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
References: <54D5126A.3020308@earthlink.net> <54D8C81C.30804@ubuntu.com> <54DA1CEA.1000802@earthlink.net>
In-Reply-To: <54DA1CEA.1000802@earthlink.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 02/10/2015 09:59 AM, Felix Miata wrote:
>> I'm guessing you don't actually have a floppy, in which case,
>> your bios is misconfigured to think you do and you should fix
>> that.
> 
> You guessed wrong: 
> https://bugzilla.opensuse.org/show_bug.cgi?id=773058 
> https://bugzilla.opensuse.org/show_bug.cgi?id=916773

Huh?  That bug report echos exactly what I said: the bios is
misconfigured to think there is a floppy when in fact, there is not.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJVIyz4AAoJENRVrw2cjl5RIvsH/A6h5V9R9yTQtNZv4RPQFU9I
XRG7RZORiB25EXbunKQ9Ry+HqG0WucOC/fM5LJIKQCnl1c1osy3bpdg6Vy5UceiZ
le9Awn7fH6+naOpdPIJjdT3FXTaL0oqXpAuHG839PqcHO0QxWFWOujHJX1op1cUw
oXTLDlP6KN3+z/5M4SZoLxtqas6nqtyWFp64jqARhI6ry6wjTbO+IgKYjKa9PXBe
O1Y1dOBiHkrCmFfPIVCoIrX4Zs0PVFZfozOk5v8bU62hmCG0bv7joxJgAAS3G8uu
7UoZjPZwF9UHFBX/5qT2MfrPjfgPxu6QopXrmqmaGCxaPXEvWem+/YZPCUGlYWg=
=65/7
-----END PGP SIGNATURE-----

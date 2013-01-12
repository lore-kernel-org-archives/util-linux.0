Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:35962 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355Ab3ALAyT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Jan 2013 19:54:19 -0500
Message-ID: <50F0B438.1080608@ubuntu.com>
Date: Fri, 11 Jan 2013 19:54:16 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
Subject: Re: losetup -d --force for zombie loop devices?
References: <20120417100346.2a0b8301@orgis.org> <201205030043.21697.vapier@gentoo.org> <4FA29633.70508@ubuntu.com> <201301111852.03607.vapier@gentoo.org>
In-Reply-To: <201301111852.03607.vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/11/2013 06:52 PM, Mike Frysinger wrote:
> On Thursday 03 May 2012 10:29:07 Phillip Susi wrote:
>> If you want to hide mounts from certain processes, that is what
>> unshare is for.  Hiding a mount from all processes does not make
>> sense.  If you know a mount is gone and beyond recovery ( like in
>> this loop over nfs case, or removed media ), then it should be
>> forcibly unmounted, not simply made invisible and doomed to
>> remain a zombie mount until the system is rebooted.
> 
> in an ideal world, maybe unshare might work.  in the real world, it
> doesn't. you can use it only on *new* processes, not ones that are
> already running. nor can you do `unshare shutdown` and have it work
> since that simply signals a long running init process to initiate a
> shutdown.
> 
> an nfs server goes afk and attempts to `umount` it timeout, as well
> as many desktop programs (like kde io daemons that like to walk
> available mount points) or shutdown processes.  no call to
> `unshare` will fix this, but certainly forcibly removing it with
> `umount -l` will. -mike

A bit of a delayed response there, but my point was that what you are
looking for is umount -f, not umount -l.  It also used to be that once
you detached a mount with umount -l, you could not reattach it.
Attempts to remount would fail with EBUSY and so this was a horribly
broken state to be in.  At some point it seems this was changed and
now you *can* reattach, so lazy unmount is no longer pure evil, but
still it is no forced unmount.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQ8LQ4AAoJEJrBOlT6nu75BO0H/A1mZ3qYAfSe/H8Z4x3BVsOZ
/sKYxc6JWUVrK5xfycZlZzpkRsIHL0Jj+asYe/+OAUHHmaUKooR7HuGF90U4kitN
h+UEdyNJJkgldju2rwePyIGucit/HOxz/SfWtSALUiu7w9OIpmkqcCXIINLJvQ0R
nQHLm79d5YFWXQRgKRuloDIW6+kBSq0cpZ+63CFhz2G7CuqzZaa1rE+I1TZbcOzF
p7G8dM/3//BeMZw/yFFDu1Ia2snO3o3vdrZWIZlbVu7fnDXC+a/qfcZtGRNZVZP9
iD4fpPNsKrjLGuaCormk62lm1OBT5YyolKaZPSJWDJrpkwKotndcwVrXWYsKGqY=
=i+ji
-----END PGP SIGNATURE-----

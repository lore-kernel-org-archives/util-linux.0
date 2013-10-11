Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:63601 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab3JKNpR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Oct 2013 09:45:17 -0400
Message-ID: <525800EB.9060208@ubuntu.com>
Date: Fri, 11 Oct 2013 09:45:15 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Matthias Schniedermeyer <ms@citd.de>, util-linux@vger.kernel.org
Subject: Re: Filesystem specific mount options mixed with auto fs type
References: <5256B7CF.7010103@ubuntu.com> <20131010170330.GA19031@citd.de> <5256E3EA.4000304@ubuntu.com> <20131011083742.GA14457@x2.net.home>
In-Reply-To: <20131011083742.GA14457@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/11/2013 4:37 AM, Karel Zak wrote:
> * well designed filesystems allows to save the filesystem specific
>  options to the FS superblock by some tune util (e.g. tune2fs)

Unfortunately, fat isn't well designed.

> * for removable media users usually use udisks based solutions

That works as long as udisks picks the defaults they want, but then if
they want a non default mount option ( or location ), they have to
specify it in fstab.

> * mount by FS identifier
> 
> LABEL=FOO       /mnt/floppy     vfat    utf8 LABEL=BAR
> /mnt/floppy     ext2    default

That ties it to the specific volume.

> Maybe we can improve mount(8) to test all entries from /etc/fstab 
> with the same mountpoint (if you want to mount-by-mountpoint) until
> the filesystem will be mounted successfully. But I have doubts that
> we really need to resolve this very old disadvantage.

Maybe something like:

/dev/fd0 /mnt/floppy auto,vfat utf8
/dev/fd0 /mnt/floppy auto generic-options

The auto would trigger blkid to identify the filesystem, and then only
if it matches one of the additional listed filesystems would that line
be applied.

I suppose that would also require changing other utilities like udisks
to understand it?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSWADrAAoJEJrBOlT6nu75bRYIAKF5CFzLr8hChG6+VoFvWSMY
1O5W8unfYSL4JH86OVuj14w9LaWWxbYaIwzhbAXp5X9Y96ZLXPNxcHaytyoBSmYg
xfDNpgj/Nm6Y8Zg2LM+qwFi+oO4qOb8RetD0uxz3uVBzxVC/PoV4W3AwoCsK3bQ9
xGjxDpMSi9lq3jA/pa8TtJnkUC8cL8vX8AWrGcSd/bBtxVZjM/mpxn4UhoBLSfOE
ICGijygUP+NUbZ7yvBb5LE2B0nqaXlpg8qqrGENhJuUGchhyd45MASzOP+I1030H
AgpMKgfg85qVneRiKl+/PmKKhrefqBkBbrWhXzjCpMNJH7H/BdupOIS+0DfQ/MI=
=QAmw
-----END PGP SIGNATURE-----

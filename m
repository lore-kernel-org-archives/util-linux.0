Return-Path: psusi@ubuntu.com
Message-ID: <5277A8EC.30809@ubuntu.com>
Date: Mon, 04 Nov 2013 09:02:20 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: /proc/mounts doesn't store bind flag
References: <5273DCB6.4020909@ubuntu.com> <20131104102932.GF23604@x2.net.home>
In-Reply-To: <20131104102932.GF23604@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

That is pretty much what I thought, but why is the bind flag stored
when you do use mtab then?  Shouldn't they give the same behavior, so
bind should not be stored in mtab?  In particular it changes the way
you have to remount a bind mount ro, which is an unexpected user
visible change.

On 11/4/2013 5:29 AM, Karel Zak wrote:
> On Fri, Nov 01, 2013 at 12:54:14PM -0400, Phillip Susi wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- When symlinking /etc/mtab to
>> /proc/mounts, bind mounts no longer have the bind option stored.
>> Is this a bug or working as intended?
> 
> This is expected thing. All utils that expect "bind" flag are
> broken.
> 
> There is nothing like "bind" mountpoint (and kernel does not
> maintain such information at all), all mountpoints are equal, there
> is nothing like a primary (original) mountpoint.
> 
> You have to think about it as about hardlinks for files. The bind 
> operation creates just another path to the filesystem. That's all.
> 
> mount /dev/sda1 /A mount --bind /A /B umount /A
> 
> then /B is still valid (BTW, this is impossible to describe in the
> traditional /etc/mtab where was always relation between /A and
> /B).
> 
> Karel
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSd6jsAAoJEJrBOlT6nu75zi8IALrs8Att9snO3z1Z1PcNikiG
yXuhaDLP8+4Nz8c8+GTFUc2SpaZHR6t1uUenMBiRrtlzqZFcGdQaNGF1wWorSTf9
cih7ffcgzXC7hA/pkPTCTTZYh1BJQbZqiH1coHoNlkyJo1ej6e0ZO42HEgQA+Aa3
0OKa6SkARTLY2NM7HBhxMpK42pt8G/3lZxngs3YHgVhB8UxeVylDcdH3M/z6GTPY
IdnjP/k1EzTgfhMXgd5OH/lvxmOhgt9kknSXz3D4sBUH24MJzKQ2N41+t1k/4K2u
LY8jb70kOxtlgmnlw+1fXk8lqi2vRxSUlupS8fLust6M4bUEzHlfLAOUaebTNYY=
=rHWj
-----END PGP SIGNATURE-----

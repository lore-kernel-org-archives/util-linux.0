Return-Path: psusi@ubuntu.com
Message-ID: <5302209E.4000102@ubuntu.com>
Date: Mon, 17 Feb 2014 09:45:50 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: please document alternate "bind" syntax in mount(8)
References: <52F50F60.3010103@ubuntu.com> <20140217115829.GD2254@x2.net.home>
In-Reply-To: <20140217115829.GD2254@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2/17/2014 6:58 AM, Karel Zak wrote:
> I see section "The bind mounts." in the man mount page where is 
> fstab example.

Oh my... even being told right where it was I had to read it three
times before I saw it.

>> Isn't it also time to update the SYNOPSIS in mount(8), now that
>> linux versions >=2.4.0 will be standard ?  I suggest adding two
>> lines like this: mount { --bind | -o bind } olddir newdir mount {
>> --rbind | -o rbind } olddir newdir or, possibly, just one line 
>> mount { --bind | --rbind | -o bind | -o rbind } olddir newdir
> 
> IMHO all is well described in the man page now.

It is... somewhere down in the mountain of text that is mount.8.  It
might be nice to have the usage shown in the synopsis though.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTAiCeAAoJEI5FoCIzSKrwsXIIAKgQX+W54lBwv6+DZgd0jd5N
F+tSMbx2rdfffr5SW2cp98S//JfiQLCC7Z/dtce5ycYHXM5XZacNAWBg9SDi7/ne
OhEFArcMN03GqCUjhPvGfDcoaPSZ246ZkjmSTNePXwzbLGsZlhJmRUK3OgAzgJ5x
qPkHos8/3gG+FnQWYNeeN0VORKjvP069dbBBBOyoFYq/CuL8lv7BJJFz3ktRSOkm
IOkNYeU7SVmhk43Cdw7pEVWHSQ6s8Gw1xR4fjVCGyRgXjrqHO0cj9cK7y48L0uhT
uuRNlTzhbMbYKxCz94CT0mVHSvxwMi0CM3i7JRHlOv2+8U2r2OM11dJwWPHPNJA=
=Nj6l
-----END PGP SIGNATURE-----

Return-Path: psusi@ubuntu.com
Message-ID: <52580DF9.4050906@ubuntu.com>
Date: Fri, 11 Oct 2013 10:40:57 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Matthias Schniedermeyer <ms@citd.de>, util-linux@vger.kernel.org
Subject: Re: Filesystem specific mount options mixed with auto fs type
References: <5256B7CF.7010103@ubuntu.com> <20131010170330.GA19031@citd.de> <5256E3EA.4000304@ubuntu.com> <20131011083742.GA14457@x2.net.home> <525800EB.9060208@ubuntu.com> <20131011140954.GD24613@x2.net.home>
In-Reply-To: <20131011140954.GD24613@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/11/2013 10:09 AM, Karel Zak wrote:
> I thought something like:
> 
> /dev/fd0 /mnt/floppy    vfat    utf8 /dev/fd0 /mnt/floppy    auto
> default
> 
> and then try in loop all the filesystem types for the mountpoint
> (or make it smart and ask blkid for the type).

What would this do to other utilities?  Would this confuse udisks or
systemd or upstart's mountall?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSWA35AAoJEJrBOlT6nu75d/cH/Rqe9m5Ttw1hdnG9+e636vkE
YNBxfBnJKV2Ob7YywnxZdIxO/fj5YCnydW+68YDR0+okJAO2p0PPPzyRhHJw+H5T
lohuBuRKfeRTuDwEKfAeIsAIOji9ed5BwHUOH2A+abd/fysiyG+ZTuet8vuXBv/Y
3Rzjh5jvkYBT+gwY9aiBoA69ChHsU9HKLQGJXd7S/UDmshqNYxhH7n3kDFiNxU3m
tzoQdSIDYRk4VTKrRp0X5kF6OtQnW7askF6RYWrMJnOYInGPFQ+WKVftx3sgw/OW
vNmKR1zrVBD+DpYSzzgG95SUQVlnoL4eZr7Ri20HQpT+bSj8opPd9IFffMX8hws=
=dA7m
-----END PGP SIGNATURE-----

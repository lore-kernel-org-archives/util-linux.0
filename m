Return-Path: psusi@ubuntu.com
Message-ID: <5284F93F.8020601@ubuntu.com>
Date: Thu, 14 Nov 2013 11:24:31 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: fdisk expert print lists wrong start sector for logical partitions
References: <5283A380.6020909@ubuntu.com> <20131114115711.GE13330@x2.net.home>
In-Reply-To: <20131114115711.GE13330@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/14/2013 6:57 AM, Karel Zak wrote:
> It's correct, although probably it seems strange at a first
> glance.
> 
> It dumps MBR and EBR tables, nothing else. It means that you can 
> see all the values as stored on the device without any
> calculation.

So it isn't saying the partition starts at sector 2048, but rather it
is 2048 sectors from the EBR?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJShPk+AAoJEJrBOlT6nu75oUIH/iuXeQO+m9zuazRX26qJFMmY
OtdPbSX73qEoP+/nB/aKFJH8w20Mlx6z5t9jX6yaZedYkDMXsup8rOzG9nQh854U
ZRGhqfoA5gTfLUqZqAyzyaNT6tCxDIX8IBtC7eLKsz21SwlAWtxiVndS5eQ0ySc3
moW4igUcg5zgwc6JJc5Ybx38T4kT4McBZpJAh3mMhFPww20o8WS3vmAnCYTZi9jt
H3HvR9OBKKEZxmz/Ddlz3YcQ6U5Z941xns/MbxAJMCl8ZY9Fn7dByvCEyuBtQ2Rs
wGz+XQJ1s/fEMDVko6xgEGmiSyQoVe76ux9iHe4u4Z22h+cbbH7AxpYmPhSUfJM=
=YrnF
-----END PGP SIGNATURE-----

Return-Path: psusi@ubuntu.com
Message-ID: <52D54D09.10506@ubuntu.com>
Date: Tue, 14 Jan 2014 09:43:21 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Scott Moser <smoser@ubuntu.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] fix partx --update ranges and out of order tables
References: <alpine.DEB.2.02.1401131526340.5329@brickies> <20140114085439.GF12700@x2.net.home>
In-Reply-To: <20140114085439.GF12700@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> +blkid_partition get_partition_by_partno(blkid_partlist ls, int n)

I was wondering why libblkid didn't already have a function like this,
should this be moved there instead of just being in partx.c?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS1U0JAAoJEI5FoCIzSKrwKeYH/1NRDc5G+ehMb14+ieyGjRqq
sUXYaVNqJfjHek+Od38gkX0kYsSzszj4gI/whPs4hJt0dgn/DwjPxsD5heyD6/LX
80hElWRyZ8bA0ZxXRwx0Z8Lrgk11R2RQgOTOXBKGTH3VrrViTJ1xugOOzO8NCpUW
uRdt0SHmymCR/yqt/bk3SY4qFsf7voFXa0UqeX/bGZT+jKFrs/Gzvop4ZbLJDW9o
X8Ww+Bq7vlE+l6RUndbmbvbQzGHbQ/4qOD2bneQfkshIoWJjw3jbNqsmP2kYwZ1Q
FISFaOs+H8RdZbaDGfwvz28OoAL7gjiSCssvsVyOJQapVt7xou6a+chr0/6pWK4=
=yXFk
-----END PGP SIGNATURE-----

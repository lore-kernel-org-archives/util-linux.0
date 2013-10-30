Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:62010 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab3J3TKT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 15:10:19 -0400
Message-ID: <52715999.2050003@ubuntu.com>
Date: Wed, 30 Oct 2013 15:10:17 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Bernhard Voelker <mail@bernhard-voelker.de>
CC: util-linux@vger.kernel.org
Subject: Re: Bind mounts record fstype of none
References: <527122AF.90003@ubuntu.com> <1530541679.232932.1383147597747.open-xchange@email.1und1.de> <52712CF0.9070603@ubuntu.com> <345614206.235496.1383150183769.open-xchange@email.1und1.de>
In-Reply-To: <345614206.235496.1383150183769.open-xchange@email.1und1.de>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/30/2013 12:23 PM, Bernhard Voelker wrote:
> Where do you see 'none'?
> 
> $ df /home Filesystem     1K-blocks    Used Available Use% Mounted
> on /dev/sdb        10321208 1233056   8563864  13% /home
> 
> $ mkdir /tmp/home
> 
> $ mount -o bind /home /tmp/home
> 
> $ df -a | grep home /dev/sdb        10321208 1233056   8563864  13%
> /home /dev/sdb        10321208 1233056   8563864  13% /tmp/home
> 
> $ mount | grep home /dev/sdb on /home type ext4
> (rw,relatime,data=ordered) /dev/sdb on /tmp/home type ext4
> (rw,relatime,data=ordered)

I see none in the output of mount and df.  Just rebuilt from git head
to make sure and still says none.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJScVmZAAoJEJrBOlT6nu75lywH/i+iIcuIC4M2aQ7XD+uPnFmx
e4uW3qs94QdJi0ita9OjCgPKS7jWzCgk5+PiUbj8sWtRvol8WTdbl7yh7tcfjuFz
tu2TKg84Q9O+7xHVN6CbwyCmq8VCJQTLYB5fs/+OKByDYxzAiANJnh0P7h8Abu++
4HEAssrfSNFp3mP2urdZl0XLbEXt5lBdN9q1oNVYhyg6Ts/pTtcipg/+keM49uH0
+2QiJrCdKy9zhcIendFx/FCqvoiKXS/Lm4Hetn9qZwU5s2Oqcdf5BVTK3G+dQ7kv
pkY1K2dU18lN4osxjNOVcq/DYFGdSY8jHg3+jbLdn3xmxgKENoOKkvpd9Lea9ao=
=ta/U
-----END PGP SIGNATURE-----

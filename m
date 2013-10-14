Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:35057 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab3JNPBZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Oct 2013 11:01:25 -0400
Message-ID: <525C0743.9020706@ubuntu.com>
Date: Mon, 14 Oct 2013 11:01:23 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: blkid doesn't find lvm pv when boot loader installed
References: <525821B6.9010304@ubuntu.com> <20131014135953.GG28914@x2.net.home>
In-Reply-To: <20131014135953.GG28914@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/14/2013 9:59 AM, Karel Zak wrote:
> Yes, unfortunately this is currently unsupported scenario.
> 
> The libblkid checks for collision between LVM and
> filesystems/partition tables to avoid very common situations when
> users use whole-disks previously used by LVM in new setups with
> partition tables.

Isn't mdadm in the same boat?  i.e. you have a partitioned single
disk, and decided to turn it into a raid1.  Now the partition table is
still there and valid, but should be ignored in favor of the raid
superblock.

> Unfortunately, partitioning tools usually does not wipe LVM header
>  from the device and it easy to create situation when there is 
> valid PT as well as valid LVM header.
> 
> So.. libblkid assumes that there is only LVM header within first
> 8K of the device, because pvcreate wipes this area (try pvcreate
> again and it will silently erase your grub!). If there is anything
> else then the previously detected LVM is ignored.
> 
> Yes, it's really not perfect solution, but do we have any better 
> solution? Maybe it would be enough to improve the blkid partition 
> table parser to not interpret the boot loader with empty PT as a 
> valid PT. Not sure.

I started thinking along those lines, but it doesn't cover the above
mentioned raid1 case.

I'm now leaning towards thinking that any partition tool that doesn't
wipe the existing signatures is broken, and that's what needs fixed
rather than trying to work around it in blkid.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSXAdDAAoJEJrBOlT6nu75SngH/28P2VeL2Mki64ZJc3t1Mejy
ceRaOu3bEgmoskPD6esaRsOOUODFaN+KzdacB3fAoql0gQJwHMvNWmnOdgK5Cn+r
0BCGAB+5WdReOBQE4T5ey2pmkmD5G+rRuwx+e8tCfQ6yKkjU1kw80tecCXq9WgIQ
SYPgclR4BILGxaIutCOXAuzk52Q5Dteq/3BaWP7o8qWmKXG6P31SWG9Frm4GtAd9
OWXHZSsf6W9S9lCrSlgY85ptq9x6GE2llFhRZoZpxR18F4zQHW0RId49tr7PLxVS
wU9dUbAoT6KFDErUbXNBAgYn0He8nYT3X1jZs4SOEyICM3hSmSc2+2sDicn51+g=
=3j23
-----END PGP SIGNATURE-----

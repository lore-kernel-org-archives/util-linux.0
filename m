Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
To: Karel Zak <kzak@redhat.com>
References: <569FEF38.9010102@suse.cz> <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz> <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A15487.8020500@suse.cz> <56AA240F.5010900@suse.cz>
 <20160201121811.tk3eqsr5x3w44p34@ws.net.home> <56AF7BE9.4000302@suse.cz>
 <20160202101139.hayiqqbzvseiocdw@ws.net.home> <56B0C570.30804@suse.cz>
 <20160202184354.goms7zouusq6pmun@ws.net.home>
Cc: util-linux@vger.kernel.org,
        =?UTF-8?B?RGF2aWQgxaB0xJtyYmE=?=
 <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56B10554.7080205@suse.cz>
Date: Tue, 2 Feb 2016 20:36:52 +0100
MIME-Version: 1.0
In-Reply-To: <20160202184354.goms7zouusq6pmun@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Dne 2.2.2016 v 19:43 Karel Zak wrote:

> For what purpose do you need it in lsblk? When the same device is
> mounded on more places?

When lsblk is called on a device with btrfs mounted, the lsblk heuristic 
may return sub-optimal (and even inconsistent) result.

> Anyway, in libmount we can extend mnt_fs_* API and add some additional
> functions -- for example add mnt_fs_get_default_root().
>
> I definitely don't want btrfs specific functions. The API should be
> generic.

The heuristic code is part of lsblk.c: get_device_mountpoint()

https://git.kernel.org/cgit/utils/util-linux/util-linux.git/tree/misc-utils/lsblk.c?id=4c01c98ca20b404940a4be749e729411d861ae97#n486

It already implements btrfs support, but the heurictic sometimes does 
not do what one would expect:

1) Search for ANY mount point that refers to device in question.

2) Check whether it is a fsroot if it is equal to "/" (always true for 
non-btrfs)

3) If not, search through all mounts that match 1).

4) Compare results, and if fsroot is equal to "/", use it.

5) Otherwise return result of 1).


In some installations (e. g. default openSUSE/SLE installation with 
btrfs root), fsroot is not mounted, 4) fails and 5) returns the 
sub-optimal guess 1).

The algorithm could be easily improved to search for the default 
subvolume as well, and only if it is not mounted, use the sub-optimal 
result.


My idea was:

1) Make btrfs_get_default_subvol_id_str() public

2) Add another loop to get_device_mountpoint() (before existing one) 
searching for a volume, where subvol_id_str returned by 
btrfs_get_default_subvol_id_str() matches option in the mountinfo.


Use of mnt_fs_get_default_root() would work as well, with a bit of overhead.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

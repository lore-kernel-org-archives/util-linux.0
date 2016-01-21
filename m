Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
To: Karel Zak <kzak@redhat.com>
References: <569FEF38.9010102@suse.cz> <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz> <20160121094833.67lg22o4la7j7pto@ws.net.home>
Cc: util-linux@vger.kernel.org,
        =?UTF-8?B?RGF2aWQgxaB0xJtyYmE=?=
 <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56A0F847.5000000@suse.cz>
Date: Thu, 21 Jan 2016 16:24:55 +0100
MIME-Version: 1.0
In-Reply-To: <20160121094833.67lg22o4la7j7pto@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Wed, Jan 20, 2016 at 10:57:07PM +0100, Stanislav Brabec wrote:
>> +/**
>> + * btrfs_get_default_subvol_id:
>> + * @path: Path to mounted btrfs volume
>
> this comment formatting indicate API docs, for private library functions
> we don't use "/**".
>
Should I export this? I think that no.

Well, looking again into libbtrfs, it is also possible to use
btrfs_list_get_default_subvolume() from libbtrfs, as is nearly exactly 
the same. But I am not sure, whether it is good to introduce such a
dependency just for a single small function.

P. S.:

David also wrote btrfs_get_default_subvolume_path(), but then we found,
that there is probably better to use subvolid and path saved in
procinfo:

+ The tab.c patch would be much smaller and straightforward.
- Kernel evaluates it when creating procinfo entries, this would
   duplicate it.
x Both subvol and subvolid in procinfo were introduced together in the
   mainline kernel, and btrfs_get_default_subvolume_path() needs more
   ioctl() calls.

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

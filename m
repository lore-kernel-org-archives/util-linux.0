Return-Path: sbrabec@suse.cz
Message-ID: <555B2E2A.6000003@suse.cz>
Date: Tue, 19 May 2015 14:35:54 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix /sys to /dev node name translation
References: <555A3E16.6090003@suse.cz> <20150519080829.GO4834@ws.net.home>
In-Reply-To: <20150519080829.GO4834@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, May 18, 2015 at 09:31:34PM +0200, Stanislav Brabec wrote:
>> linux/drivers/base/core.c: device_get_devnode() defines a translation of
>> '!' in sysfs nodes to '/' in /dev nodes. The same translation has to be
>> done to properly support device nodes with slash (e. g. device nodes of
>> cciss driver and several other drivers).
>
> Strange feature.

It was probably introduced to support drivers that already used /dev 
sub-directories in time of introduction /sys.

>> +	/* replace '!' in the name with '/', see
>> +	 * linux/drivers/base/core.c: device_get_devnode() */
>> +	while ((s = strchr(name, '!')))
>> +		s[0] = '/';
>
>
>   What about to add small inline function sysfs_fix_devname() to
>   include/sysfs.h ?

Yes, it makes sense.

Do you have an idea how to locate all parts of code that make 
assumptions basename (sysfs_block_path) == basename (dev_path).

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

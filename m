Return-Path: sbrabec@suse.cz
Message-ID: <555F349D.7080706@suse.cz>
Date: Fri, 22 May 2015 15:52:29 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix /sys to /dev node name translation
References: <555A3E16.6090003@suse.cz> <20150519080829.GO4834@ws.net.home> <555B2E2A.6000003@suse.cz> <20150521111134.GB4730@ws.net.home>
In-Reply-To: <20150521111134.GB4730@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> I hope we use lib/sysfs.c code always when possible. It should be
> possible to detect all /sys code by
>
>      git grep _PATH_SYS_
>
> so
>
>      disk-utils/partx.c
>      lib/loopdev.c
>      lib/sysfs.c
>      libblkid/src/devname.c
>      misc-utils/lsblk.c
>
I went through these files and none of them seems to do such conversion.

So only the three places in the last patch needs to be fixed.

I already have a new patch introducing static inline void 
sysfs_devname_to_dev_name (char *name) helper for in-place conversion of 
'!' to '/', but I am waiting for a chance to make a test on a real 
hardware next week.

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

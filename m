Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] libmount: run btrfs subvol checks for "auto" fs type
To: Karel Zak <kzak@redhat.com>
References: <56A7DE4B.5060308@suse.cz>
 <20160201111815.wilhso7klaiy6cio@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56AF77BE.5030601@suse.cz>
Date: Mon, 1 Feb 2016 16:20:30 +0100
MIME-Version: 1.0
In-Reply-To: <20160201111815.wilhso7klaiy6cio@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>   It's safe, but "mount -a" is going to call the btrfs ioctl or each
>   "auto" fstab entry :-)
>
I am aware of it. Guessing what is more effective: search for all
candidates in mountinfo and checking whether it is btrfs, or blindly
issuing ioctl() that will:
- quickly fail with EINVAL for non-btrfs
- wil be needed for btrfs anyway

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

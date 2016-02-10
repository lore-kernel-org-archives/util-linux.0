Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:58216 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253AbcBJQDS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Feb 2016 11:03:18 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id E862FAD66
	for <util-linux@vger.kernel.org>; Wed, 10 Feb 2016 16:03:16 +0000 (UTC)
Subject: another mount -a problem, not related to btrfs
To: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <56B0EEB2.1060707@suse.cz> <56B10E38.7040407@suse.cz>
 <56B23240.8060405@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56BB5F44.6070208@suse.cz>
Date: Wed, 10 Feb 2016 17:03:16 +0100
MIME-Version: 1.0
In-Reply-To: <56B23240.8060405@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Dne 3.2.2016 v 18:00 Stanislav Brabec napsal(a):
> Stanislav Brabec wrote:
>> (rw,relatime,space_cache,subvolid=258,subvol=/d0/dd0/ddd0/d2/dd2/ddd2/s3/bind-mnt)
>>
>
> After a discussion with David, we came to the conclusion that the
> problem is caused by bug in the mountinfo provided by kernel:
>
While working on a fix, I found a new bug, not related to btrfs:

truncate -s10M source.img
mkdir -p /source/subdir
mkdir -p /dest
/sbin/mkfs.ext4 source.img
losetup /dev/loop0 $PWD/source.img
echo "/dev/loop0 /source ext4 defaults 0 0" >>/etc/fstab
mount -a
mkdir -p /source/subdir
mount -o bind /source /dest
echo "/source/subdir /dest auto bind 0 0" >>/etc/fstab
mount -a

Got:
/dev/loop0 on /source type ext4 (rw,relatime,data=ordered)
/dev/loop0 on /dest type ext4 (rw,relatime,data=ordered)
/dev/loop0 on /dest type ext4 (rw,relatime,data=ordered)
/dev/loop0 on /source type ext4 (rw,relatime,data=ordered)
and empty /source

It apparently should not happen.

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

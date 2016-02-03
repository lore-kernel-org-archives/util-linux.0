Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:40656 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933775AbcBCSj5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Feb 2016 13:39:57 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 10121AB45
	for <util-linux@vger.kernel.org>; Wed,  3 Feb 2016 18:39:56 +0000 (UTC)
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
To: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <56B0EEB2.1060707@suse.cz> <56B10E38.7040407@suse.cz>
 <56B23240.8060405@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56B2497B.2000807@suse.cz>
Date: Wed, 3 Feb 2016 19:39:55 +0100
MIME-Version: 1.0
In-Reply-To: <56B23240.8060405@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:

> However both lines mount the same part of btrfs hierarchy, files inside
> will have different inode numbers for each.

Fix:

inode number will be the same, independently on subvolume actually used, 
and the reported subvolid.

But the mount reference count differs depending on the bind mount source.

In the first case, I can run
umount /.snapshots

in the second, I will get EBUSY.

=> The "mount -a" problem can be reasonably fixed, but depending on the 
algorithm, we could encounter unfixable problem during "umount -a".

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

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33701 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757750AbcBCRAu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Feb 2016 12:00:50 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 38730ABE5
	for <util-linux@vger.kernel.org>; Wed,  3 Feb 2016 17:00:49 +0000 (UTC)
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
To: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <56B0EEB2.1060707@suse.cz> <56B10E38.7040407@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56B23240.8060405@suse.cz>
Date: Wed, 3 Feb 2016 18:00:48 +0100
MIME-Version: 1.0
In-Reply-To: <56B10E38.7040407@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:
> (rw,relatime,space_cache,subvolid=258,subvol=/d0/dd0/ddd0/d2/dd2/ddd2/s3/bind-mnt)

After a discussion with David, we came to the conclusion that the
problem is caused by bug in the mountinfo provided by kernel:

It reports invalid subvol=/d0/dd0/ddd0/d2/dd2/ddd2/s3/bind-mnt, which
breaks both the logic inside new patches, and the convention that it is
possible to create a mount command from the options reported by
mountinfo.

After a further research, we found, that kernel is currently unfixable
in a correct way without refactoring of btrfs or changes in vfs.

It implies that fstab support for btrfs is not fully fixable. But it is
possible to write a heuristic, that can work in most cases, and in
other cases it will behave at least reasonably (i. e. not mount again,
not mount incorrect directories etc.)


Here is the case that CANNOT be fixed correctly:

Suppose you have following fstab:

/dev/sda1                 /           btrfs subvol=.snapshots/1/snapshot 0 0
/dev/sda1                 /.snapshots btrfs subvol=.snapshots            0 0

Now suppose additional line:
/var                      /mnt/var    none  bind                         0 0

And following line:
.snapshots/1/snapshot/var /mnt/var    none  bind                         0 0

However both lines mount the same part of btrfs hierarchy, files inside
will have different inode numbers for each.

mountinfo provided by the current btrfs is not sufficient to
discriminate between them, and what is even worse, in second case it
reports incorrect subvolid.


As we cannot expect correct fix for that in next say few years,
util-linux has to live with lies, incorrect subvol, unmountable
subvolid.


Conclusion:

Don't suppose unique relation between subvol and subvolid. Always go
through the whole mountinfo, and find a shortest string corresponding
to the particular subvolid. It is the correct one.

In case of bind mounts, don't trust subvolid and subvol at all. The
only real information is the source. btrfs guesses the rest, often
correctly, sometimes incorrectly. subvol is just a copy of this path
(possibly unusable in real mount command), subvolid is the id of the
nearest parent node, not the real subvolid of the volume the bind mount
points to. If device and source matches, the best guess heuristic says,
that the bind mount is probably already mounted. (It could be false,
but we cannot detect it.)


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

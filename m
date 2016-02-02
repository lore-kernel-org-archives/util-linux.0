Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:38545 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756481AbcBBUOu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Feb 2016 15:14:50 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 02137AB9D
	for <util-linux@vger.kernel.org>; Tue,  2 Feb 2016 20:14:49 +0000 (UTC)
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
To: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <56B0EEB2.1060707@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56B10E38.7040407@suse.cz>
Date: Tue, 2 Feb 2016 21:14:48 +0100
MIME-Version: 1.0
In-Reply-To: <56B0EEB2.1060707@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:
> Coverage:

I just found a bug in my testcase:
To prevent race bind-mnt has to be created in time of fs creation.

  btrfs subvol create s3 >/dev/null
+mkdir -p s3/bind-mnt
  popd >/dev/null

But, what is worse, I found a problem in previous patches.

Things are even more complicated than I thought, and patches still not 
cover all cases.

Up to now, I have been thinking that device + subvolid is unique 
identifier in the mountinfo. But it is not true, at least not when bind 
mounts take its role.

Using bind mounts that point to a sub-directory of a subvolume of btrfs 
results in two lines in mountinfo that have the same subvolid but 
different subvol.

Second "mount -a" then fails badly. Not only that it mounts the bind 
mount second time, it also mistakenly mounts another volume over a 
previously mounted volume.

dev/loop0 on 
/home/sbrabec/VCS/util-linux/tests/output/mount/fstab-btrfs-mnt-subvol 
type btrfs 
(rw,relatime,space_cache,subvolid=258,subvol=/d0/dd0/ddd0/d2/dd2/ddd2/s3/bind-mnt)
=> totally wrong

We are back on the beginning.

I have to re-evaluate all patches I sent up to now.

TODO:

Check whether it is possible to directly mount sub-directory of 
sub-volume that is not a subvolume per self.

If yes:
- We will need to introduce full path evaluation of btrfs sub-volume, 
and always compare it with mountinfo.

If not:
- We will have to search the whole mountinfo for a particular subvolid 
and and find a shortest subvol string.

David, could you bring some light into it?

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

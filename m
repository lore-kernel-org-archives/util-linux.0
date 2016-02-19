Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:46262 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424800AbcBSPCx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Feb 2016 10:02:53 -0500
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
To: Karel Zak <kzak@redhat.com>
References: <56B0EEB2.1060707@suse.cz> <56B10E38.7040407@suse.cz>
 <20160211094352.6ncnnirhyd4jjd34@ws.net.home> <56BC9101.60908@suse.cz>
Cc: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56C72E9B.3050402@suse.cz>
Date: Fri, 19 Feb 2016 16:02:51 +0100
MIME-Version: 1.0
In-Reply-To: <56BC9101.60908@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Feb 11 2016 at 14:47 Stanislav Brabec wrote:
> There are missing umount commands in the middle of the test, which
> trigger following problem:
>
> truncate -s10M source.img
> mkdir -p /source/subdir
> mkdir -p /dest
> /sbin/mkfs.ext4 source.img
> losetup /dev/loop0 $PWD/source.img
> mount -text4 /dev/loop0 /source
> mkdir -p /source/subdir
> mount -o bind /source /dest
> mount -o bind /source/subdir /dest
>
> Mounting a bind mount over a root of existing bind mount causes mounting
> over the bind mount source. I expected mounting over the target
> directory I specified.
>
> I am not sure, whether it is correct behavior, but for sure it is
> surprising.

We discussed it with David and considered that it is an unexpected but
correct behavior, that is a consequence of systemd introducing new
default behavior for mounts. All bind mounts are shared by default,
which causes propagation of a mount inside a target (including the
target root) into a source.

> Additionally, I am working on a reproducer of an invalid "mount -a"
> behavior triggered by kernel bug reporting false subvol.

> I already have a possible fix for it, but I want to confirm that it is
> correct before sending it upstream.

I finally found a reproducer.

It is a negative reproducer, i. e. fstab that should cause error, but
it does not. I am still not sure, whether positive reproducer exists. I
will send a fix and testcase in a separate thread.

After that, all discovered btrfs mount issues will be finally fixed.

There is another known problem with non intuitive output of lsblk with
btrfs, but it is above the scope of this thread.

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

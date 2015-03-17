Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43544 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932350AbbCQQec (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 12:34:32 -0400
Date: Tue, 17 Mar 2015 17:34:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: question about findmnt --target
Message-ID: <20150317163426.GW28925@ws.net.home>
References: <201503171608.58423.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201503171608.58423.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 17, 2015 at 04:08:58PM +0100, Ruediger Meier wrote:
> Hi,
> 
> I wonder what is the correct way to find a mount which is mounted to a 
> certain target directory. findmnt --target will also find a mount if 
> you specify a subdirectory of a mountpoint:
> 
> $ mkdir /tmp/bla
> $ findmnt --target /tmp/bla
> TARGET SOURCE                        FSTYPE OPTIONS
> /tmp   /dev/mapper/vg0-tmpdirs[/tmp] ext4 ....
> 
> The man page let me think that --target should not find the parent 
> directory.

No, it's expected behavior since:

    commit b215d8e9a71ca8d22df6111ddc9d28bd896febb1
    Author: Dave Reisner <dreisner@archlinux.org>
    Date:   Wed Apr 25 20:30:52 2012 -0400

and the current git tree contains:

       -T, --target path
             Explicitly define the mount target (mountpoint
             directory). If the path is not a  mountpoint file
             or directory than findmnt checks path elements in
             reverse order for get the mountpoint (this
             feature is supported only if search in kernel
             files and unsupported for --fstab).


> $TS_CMD_MOUNT --move $DIR_A $DIR_B
> 
> # check the move
> $TS_CMD_FINDMNT --kernel --target "$DIR_B" &> /dev/null
> [ "$?" == "0" ] || ts_die "Cannot find binded $DIR_B"
> [...]
> 
> This findmnt line will never fail I guess.

Right, this is mistake, solution is to remove --target:

    TS_CMD_FINDMNT --kernel "$DIR_B" &> /dev/null


The disadvantage is that without --source/target findmnt(8) tries
to use the path as source and then as target. It's bad in same cases.

Maybe we need a new option to disable the evaluation of the target
path elements. (--strict-target)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

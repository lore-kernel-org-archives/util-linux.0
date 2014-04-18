Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39953 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbaDRLC6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Apr 2014 07:02:58 -0400
Date: Fri, 18 Apr 2014 13:02:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
Message-ID: <20140418110244.GL5786@x2.net.home>
References: <534C9625.8030906@cn.fujitsu.com>
 <20140415112159.GE5786@x2.net.home>
 <534DD487.6090700@cn.fujitsu.com>
 <20140416090359.GF5786@x2.net.home>
 <534F2B8F.5010906@cn.fujitsu.com>
 <20140417082105.GH5786@x2.net.home>
 <534F90D2.1030807@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <534F90D2.1030807@cn.fujitsu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 17, 2014 at 04:29:06PM +0800, Qu Wenruo wrote:
> >>So if someone (maybe insane) use mknod to create as block device file and
> >>use 'btrfs dev del' on the newly created
> >>block device file, libblkid will still be unable to detect the change since
> >>the ctime/mtime of block device file in /dev/
> >>does not change.
> >Not sure if I understand, it would be nice to have complete example.
> >
> >     Karel
> >
> Sorry for my poor English.
> Use /dev/sda6(major 8, minor 6) as an example.
> ------
> # stat  /dev/sda6
>   File: '/dev/sda6'
>   Size: 0             Blocks: 0          IO Block: 4096   block special file
> Device: 5h/5d    Inode: 7289        Links: 1     Device type: 8,6
> Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    6/ disk)
> Access: 2014-04-17 12:30:08.981732698 +0800
> Modify: 2014-04-17 12:30:08.981732698 +0800
> Change: 2014-04-17 12:30:08.981732698 +0800
>                                      ^^^^^^^^^^^^^^^^^
>  Birth: -
> # mknod sda6 b 8 6
> # mkfs.ext4 ./sda6 <<< Not /dev/sda6

 Ah... it's too crazy to support this scenario :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

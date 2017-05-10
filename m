Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbdEJJrv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 May 2017 05:47:51 -0400
Date: Wed, 10 May 2017 11:47:46 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux-v2.25:mountpoint misnamed or bugged, and "-d" bugged
Message-ID: <20170510094746.zpkebvktie7iauzf@ws.net.home>
References: <58F2C401.5090001@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <58F2C401.5090001@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 15, 2017 at 06:08:17PM -0700, L A Walsh wrote:
> 
> mountpoint doesn't detect file, device
> or other inode mount points.
> 
> Also, the "-d" switch doesn't show the maj:min of the mounted
> inode.  Of note: "-x" does show the maj:min of a remounted blockdev.

Version, distro, do you have classic mtab, etc, etc.... ?

> #reproduce (showing additional variant w/a char device)
> 
> cd /tmp
> mkdir foo1
> cd foo1
> mkdir mnt
> sudo mount tmpfs -t tmpfs mnt
> touch mnt/file mnt_file mnt_null
> sudo mknod mnt/null c 1 3
> sudo mount --bind mnt/file mnt_file
> sudo mount --bind mnt/null mnt_null
> function is_mountedQ {
>  if /usr/bin/mountpoint -q $1; then
>    echo "$1 is a mount point"
>  else
>    echo "$1 is not a mount point"
>  fi
> }
> is_mountedQ mnt_file
> is_mountedQ mnt_null

Works for me:

# cd /tmp               
# mkdir foo1            
# cd foo1               
# mkdir mnt             
# mount tmpfs -t tmpfs mnt
# touch mnt/file mnt_file mnt_null
# mknod mnt/null c 1 3  
# mount --bind mnt/file mnt_file
# mount --bind mnt/null mnt_null
# mountpoint mnt_null   
mnt_null is a mountpoint
# mountpoint mnt_file   
mnt_file is a mountpoint
 
# findmnt --submounts /tmp
TARGET               SOURCE       FSTYPE OPTIONS
/tmp                 tmpfs        tmpfs  rw,nosuid,nodev
├─/tmp/foo1/mnt      tmpfs        tmpfs  rw,relatime
├─/tmp/foo1/mnt_file tmpfs[/file] tmpfs  rw,relatime
└─/tmp/foo1/mnt_null tmpfs[/null] tmpfs  rw,relatime


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

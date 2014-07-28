Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47194 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbaG1Jd7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jul 2014 05:33:59 -0400
Date: Mon, 28 Jul 2014 11:33:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] various: erase all traces of the long-obsolete xiafs
Message-ID: <20140728093355.GG8533@x2.net.home>
References: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
 <1406292904-3956-3-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406292904-3956-3-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 25, 2014 at 02:55:03PM +0200, Benno Schulenberg wrote:
> diff --git a/bash-completion/mount b/bash-completion/mount
> index db97a91..7ebcec3 100644
> --- a/bash-completion/mount
> +++ b/bash-completion/mount
> @@ -20,7 +20,7 @@ devpts	  nodevpts	nfs4	  nonfs4	usbfs	  nousbfs
>  efs	  noefs		ntfs	  nontfs	vfat	  novfat
>  ext	  noext		proc	  noproc	xenix	  noxenix
>  ext2	  noext2	qnx4	  noqnx4	xfs	  noxfs
> -ext3	  noext3	ramfs	  noramfs	xiafs	  noxiafs
> +ext3	  noext3	ramfs	  noramfs
>  ext4	  noext4	reiserfs  noreiserfs
>  hfs	  nohfs		romfs	  noromfs

 I have doubts that static list of the filesystems in the
 bash-completion/ is a good idea. It would be better to generate
 the list according to the current kernel features, something like

 (awk '{ if ($0 ~ /^[[:blank:]]/) { print $1 } else { print $2 } }'
 /proc/filesystems; ls /lib/modules/$(uname -r)/kernel/fs) | sort -u

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbdJDI1c (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 4 Oct 2017 04:27:32 -0400
Date: Wed, 4 Oct 2017 10:27:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: fdisk request for functionality (or info)
Message-ID: <20171004082728.if274peupxjljbxd@ws.net.home>
References: <59D3C162.4050005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59D3C162.4050005@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 03, 2017 at 11:57:06AM -0500, Bruce Dubbs wrote:
> I have been having a problem with fdisk on old computers.
> 
> What I am doing is installing Debian, but dropping to the command line and
> creating a GPT manually because Debian seems to want to always create a
> msdos partition table.
> 
> After creating the GPT and partitioning, the install proceeds normally, but
> upon reboot the old bios tells me "No bootable disk".
> 
> I can fix this by going into rescue mode and setting the pmbr_boot flag
> using parted.
> 
> My question is whether this can be done in fdisk.  If not, can it be added?
> 
> I did try going into expert mode and selecting "toggle the legacy BIOS
> bootable flag", but does not seem to work.  I did not see any change to the
> boot sector when using 'd: print the raw data of the first sector from the
> device'.

The tricky thing is that fdisks by default see GPT partition, so you
have to force the tools to ignore GPT and use PMBR. There is more
ways:

1) you can force fdisk to see only MBR and ignore GPT

     fdisk --type dos <device>

   than you can use fdisk as usually for MBR.

2) start fdisk as usually
    - go to expert mode ('r')
    - see help ('m')
    - switch to nested label ('M')
    - go to main menu ('r')
    - toggle boot flag ('a')
    - write ('w')

 3) use sfdisk:

      sfdisk --label-nested dos --activate /dev/sda 1

   to set boot flag on the first partition.


 IMHO 3) is your friend if you have sfdisk :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41720 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbbEULHj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 May 2015 07:07:39 -0400
Date: Thu, 21 May 2015 13:07:35 +0200
From: Karel Zak <kzak@redhat.com>
To: 784709@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: when would blkid success but not filesystem type?
Message-ID: <20150521110735.GA4730@ws.net.home>
References: <20150520145904.3e4645dd@patagonia>
 <1432196678.28686.58.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1432196678.28686.58.camel@debian.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 21, 2015 at 04:24:38PM +0800, Paul Wise wrote:
> In https://bugs.debian.org/784709 Jérôme Kieffer wrote:
> 
> > Here is the answer for the 3.16 kernel:
> > 
> > jerome@patagonia:~$ sudo blkid -o value -s TYPE /dev/sdb4
> > jerome@patagonia:~$ echo $?
> > 0
> ...
> > 
> > The output is the same on 3.2, as you can see on attached images.
> 
> Anyone know when blkid would return success but not the filesystem type?

 The option '-s' does not affect return code, this option controls 
 output filter only. I have improved the description in the man page 
 to make it more obvious.

 blkid returns success always when it's possible to gather any
 information about the device. The important detail is that the recent
 versions provide also PARTUUID=, so we have information about all
 (including empty) partitions!

 For example (very very old version from e2fsprogs):

    # blkid /dev/sdc1; echo $?
    2

 but the current util-linux upstream:

    #blkid /dev/sdc1; echo $?
    /dev/sdc1: PARTUUID="4b6f59ea-01"
    0


 And yes, we have PARTUUID also for MBR partitions, the method used to
 generate the UUID is the same like kernel uses for root= command
 line option.

 Note that my recommendation is to use lsblk, for example:

    # lsblk --noheading --output FSTYPE /dev/sda1
    vfat

 it reads info from udev db (libblkid is only fallback here), and it
 provides better way how to control output.


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab3JIJbG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Oct 2013 05:31:06 -0400
Date: Wed, 9 Oct 2013 11:31:02 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] blockdev: Remove the --setbsz (set blocksize) option
 which has never worked.
Message-ID: <20131009093102.GI13559@x2.net.home>
References: <1381222450-30380-1-git-send-email-rjones@redhat.com>
 <5254113A.2010709@draigBrady.com>
 <20131008140940.GW1887@redhat.com>
 <52542B27.4050901@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52542B27.4050901@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 08, 2013 at 04:56:23PM +0100, Pádraig Brady wrote:
> For my own reference, the way I see it,
> when accessing block devices Linux uses these block sizes:
> 
> physical	defined by the hardware device
> logical		the smallest addressable unit used for the device
> file system	ditto for the file system
> 
> --[gs]etbsz refers the _logical_ block size for the device.

 Well, let's be more pedantic ;-)

 The disks and raids provides I/O limits:

   physical block size  (BLKPBSZGET)
   logical block size   (BLKSSZGET)

 but kernel also uses 
 
   soft block size  BLKBSZGET
   
 this size is never smaller than logical size and (I guess) usually
 same as PAGE_SIZE. So it's really not *device* logical block size,
 it's more about the way how kernel uses the device.

> So why might one want to --setbsz?
> I agree that would be fairly specialized.

 Yes, it's practically useless in tool like blockdev(8).
 
> I searched for uses of --setbz and noticed a couple:
> Perf testing:
>   https://lkml.org/lkml/2003/12/30/81
> Functionality testing:
>   http://www.linux-archive.org/device-mapper-development/699549-blockdev-fix-crash-when-block-size-changed-i-o-issued-simultaneously.html

 Good point (it seems I was too rash to apply Rich's patch;-)

 Maybe we can keep --setbsz in the code for testing purpose and for
 backward compatibility, then all we need is describe the ioctl in the
 blockdev(8) man page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

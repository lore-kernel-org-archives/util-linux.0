Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36333 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933064AbbCPRUC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Mar 2015 13:20:02 -0400
Received: by padcy3 with SMTP id cy3so70467436pad.3
        for <util-linux@vger.kernel.org>; Mon, 16 Mar 2015 10:20:02 -0700 (PDT)
Date: Mon, 16 Mar 2015 17:19:59 +0000
From: Isaac Dunham <ibid.ag@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Trying to avoid incompatability on a mount enhancement
Message-ID: <20150316171958.GA13750@newbook>
References: <20150314220249.GC1808@Sparta>
 <20150316102233.GA28925@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150316102233.GA28925@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 16, 2015 at 11:22:33AM +0100, Karel Zak wrote:
> On Sat, Mar 14, 2015 at 10:02:50PM +0000, Isaac Dunham wrote:
> > Hello,
> > I've been thinking about adding a feature to Busybox mount, but I'd
> > like to check on options that are already claimed in util-linux so I
> > don't cause a major incompatability.
> > 
> > The feature I'm thinking about is roughly analogous to "mkdir -p" or
> > "cpio -d":
> > it creates the mountpoints if needed.
> 
>  man mount:
> 
>  x-mount.mkdir[=mode]
> 
>         Allow  to  make  a target directory (mountpoint).  The
>         optional argument mode specifies the filesystem access mode
>         used for mkdir(2) in octal notation.   The default  mode  is
>         0755.  This functionality is supported only for root users.
> 
> 
>  ... so:
> 
>         mount /dev/sda1 /mnt/foo -o x-mount.mkdir
> 

Thank you for responding.
I read about that some time after I sent the email; now comes the question
of whether Busybox will accept it.

I've already gotten a comment to the effect that x-mount.mkdir is "ugly"
(no clarifications provided), and that it's lacking the ability to set
owner/group for the mountpoint.
(The individual who opposes this is arguing in favor of adding a similar
but more expanded capability to mdev, the Busybox hotplugger.)

Thanks,
Isaac Dunham


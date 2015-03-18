Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbbCRKRV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Mar 2015 06:17:21 -0400
Date: Wed, 18 Mar 2015 11:17:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: question about findmnt --target
Message-ID: <20150318101718.GB28925@ws.net.home>
References: <201503171608.58423.sweet_f_a@gmx.de>
 <20150317163426.GW28925@ws.net.home>
 <55092A36.7060004@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55092A36.7060004@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 18, 2015 at 08:33:10AM +0100, Bernhard Voelker wrote:
> On 03/17/2015 05:34 PM, Karel Zak wrote:
> > Maybe we need a new option to disable the evaluation of the target
> > path elements. (--strict-target)
> 
> Hey, we already have a tool for that: 'mountpoint' ;-)

 Yes, it's possible solution, but if we think about findmnt as
 "complete" tool to search in mount tables than I expect that it
 provides all necessary functionality.

> What's wrong with
> 
>   mountpoint "$DIR_B" >/dev/null \
>     && findmnt --target "$DIR_B" \
>     && ...

 race, if you umount between mountpoint and findmnt.
 
 And it will also read and parse /proc/self/mountinfo in both tools. 
 
 And force kernel to compose mount table is already reported performance 
 issue on some large systems. The real solution and long-term wish is to 
 have per-mountpoint kernel API, something like
 
    fd = mountfd("/mnt", O_RDONLY);
    read(fd, buf, sizeof(fs_mountinfo));

 and in O_RDWR to mount, remount and umount, and then send old mount(2)
 syscall to hell...

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

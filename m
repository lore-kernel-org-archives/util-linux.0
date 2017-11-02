Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:37730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933207AbdKBSUx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Nov 2017 14:20:53 -0400
Date: Thu, 2 Nov 2017 19:20:51 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "Yuriy M. Kaminskiy" <yumkam@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
Message-ID: <20171102192051.441215c6@kitsune.suse.cz>
In-Reply-To: <6685d3eb-09b9-3904-1565-2bcfdc83eac5@suse.cz>
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
        <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
        <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
        <m3wp6u5k8z.fsf@gmail.com>
        <68bc995a-3b0c-5b2c-cb7a-5f0052d19bef@suse.cz>
        <45a7e1bc-62cb-cf96-07c7-c4801dcf23d4@suse.cz>
        <20171002150048.3a609f57@kitsune.suse.cz>
        <eb224df4-615b-18e2-a9ee-5d98db9db225@suse.cz>
        <20171002155004.5878caee@kitsune.suse.cz>
        <6685d3eb-09b9-3904-1565-2bcfdc83eac5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2 Oct 2017 16:11:04 +0200
Stanislav Brabec <sbrabec@suse.cz> wrote:

> Michal Suchánek wrote:
> > On Mon, 2 Oct 2017 15:06:33 +0200
> > Stanislav Brabec <sbrabec@suse.cz> wrote:
> >   
> >> Michal Suchánek wrote:  
> >>> it is completely reasonable to return ENOMEDIUM from kernel when
> >>> the tray is open and let userspace decide if it wants to attempt
> >>> to close the tray and how long it wants to wait for the tray to
> >>> close (it may be blocked/broken).
> >>>     
> >> But then, what is the purpose of /proc/sys/dev/cdrom/autoclose?  
> > 
> > It can be used as a hint in mount if closing the tray is desired or
> > not.  
> 
> Such feature could be completely implemented in the user space, so
> there is no reason to stay in the kernel in such a limited form.
> 
> 20 years ago, it was a completely working implementation inside the
> kernel. User space just called mount(), and it succeeded.

Ok, if you can point on a particular kernel version and driver that
worked it might be interesting to see the implementation.

> 
> If that requires user space loop loop, then there is no reason to
> implement sysfs entry just to perform tray close inside mount()
> syscall and then fail anyway.
> 

As things are the kernel calls the tray_move function to close the
tray. This function exits before the tray closes. The kernel proceeds
to try to read the medium. There is a wait loop in ioctl calls (but not
block calls) to check for ASC/ASCQ 04/01 (unit becoming ready).
However, my cdrom reports 3A/02 (no medium, tray open) while the tray
is closing. There is no code for 'tray closing'. Hence the open() call
is not aware that the tray is supposed to close shortly and does not
wait for it.

Tracking the 'closing' state in the kernel does not look pretty. Best
kernel-side option would be to wait for some arbitrary time in the
tray_move function until the drive state changes from 'tray open'. I
suspect waiting for arbitrary time or indefinitely until the tray
closes may upset people. Then again, this is CD drive so it is anything
but fast (unless emulated ;-)

Thanks

Michal

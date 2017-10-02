Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:44566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751036AbdJBNAu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 09:00:50 -0400
Date: Mon, 2 Oct 2017 15:00:48 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "Yuriy M. Kaminskiy" <yumkam@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
Message-ID: <20171002150048.3a609f57@kitsune.suse.cz>
In-Reply-To: <45a7e1bc-62cb-cf96-07c7-c4801dcf23d4@suse.cz>
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
        <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
        <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
        <m3wp6u5k8z.fsf@gmail.com>
        <68bc995a-3b0c-5b2c-cb7a-5f0052d19bef@suse.cz>
        <45a7e1bc-62cb-cf96-07c7-c4801dcf23d4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 28 Jul 2017 17:48:22 +0200
Stanislav Brabec <sbrabec@suse.cz> wrote:

> Dne 28.7.2017 v 17:26 Stanislav Brabec napsal(a):
> > Dne 27.7.2017 v 10:58 Yuriy M. Kaminskiy napsal(a):  
> >> (And, I used cdrom a long time ago, but IIRC there were some driver
> >> settings to automatically close tray on device open, so that this
> >> patch should not be needed?)  
> > 
> > Thanks for this hint. Yes, you are true:
> > /proc/sys/dev/cdrom/autoclose
> > /proc/sys/dev/cdrom/autoeject
> > 
> > But this does not work with the current mount. The mount request
> > will expire on timeout earlier than the tray of ordinary CDROM
> > closes.
> > 
> > But yes, it is possible to implement a different, simpler patch that
> > will make the autoclose feature working, and not cause delays in
> > case of no medium.
> >   
> 
> I did some testing.
> 
> The kernel autoclose feature should do exactly the same as my patch
> attempts. But kernel seems to be broken. Before the tray actually
> closes, kernel returns ENOMEDIUM.
> 
> From strace log when a standard DVD drive is open with a DVD laying on
> the tray:
> 
> 17:30:32.719041 access("/dev/sr0", F_OK) = 0 <0.000005>
> (here the tray starts to close)
> 17:30:32.719054 open("/dev/sr0", O_RDONLY|O_CLOEXEC) = -1 ENOMEDIUM
> (No medium found) <1.450436>
> ...
> 17:30:34.169943 mount("/dev/sr0", "/mnt", "vfat",
> MS_MGC_VAL|MS_SILENT, NULL) = -1 ENOMEDIUM (No medium found)
> <0.083741>
> 
> I am nearly sure that it worked ~20 years ago.
> 

Since we have facility for

 - telling if the drive is closed
 - telling if the drive can be closed
 - closing the drive

it is completely reasonable to return ENOMEDIUM from kernel when the
tray is open and let userspace decide if it wants to attempt to close
the tray and how long it wants to wait for the tray to close (it may be
blocked/broken).

Thanks

Michal

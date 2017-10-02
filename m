Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:56914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751104AbdJBOYw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 10:24:52 -0400
Date: Mon, 2 Oct 2017 16:24:50 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "Yuriy M. Kaminskiy" <yumkam@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
Message-ID: <20171002162450.69980989@kitsune.suse.cz>
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

Then mount should probably get an option to attempt to close the tray
or not. Closing the tray is not always desirable.

Thanks

Michal

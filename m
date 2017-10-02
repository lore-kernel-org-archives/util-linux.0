Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:52035 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751128AbdJBNuG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 09:50:06 -0400
Date: Mon, 2 Oct 2017 15:50:04 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "Yuriy M. Kaminskiy" <yumkam@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
Message-ID: <20171002155004.5878caee@kitsune.suse.cz>
In-Reply-To: <eb224df4-615b-18e2-a9ee-5d98db9db225@suse.cz>
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
        <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
        <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
        <m3wp6u5k8z.fsf@gmail.com>
        <68bc995a-3b0c-5b2c-cb7a-5f0052d19bef@suse.cz>
        <45a7e1bc-62cb-cf96-07c7-c4801dcf23d4@suse.cz>
        <20171002150048.3a609f57@kitsune.suse.cz>
        <eb224df4-615b-18e2-a9ee-5d98db9db225@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2 Oct 2017 15:06:33 +0200
Stanislav Brabec <sbrabec@suse.cz> wrote:

> Michal Suchánek wrote:
> > it is completely reasonable to return ENOMEDIUM from kernel when the
> > tray is open and let userspace decide if it wants to attempt to
> > close the tray and how long it wants to wait for the tray to close
> > (it may be blocked/broken).
> >   
> But then, what is the purpose of /proc/sys/dev/cdrom/autoclose?

It can be used as a hint in mount if closing the tray is desired or
not.

I guess this used to work with IDE drivers not using SCSI emulation.

With SCSI the close tray command is executed like any other with
default timeout and obviously does time out in most cases. 

But how long should the kernel wait? Is 1 minute ok? Should it wait 5
minutes in case the user did not align the medium properly and needs to
realign it? Who should set this timeout, where?

Thanks

Michal

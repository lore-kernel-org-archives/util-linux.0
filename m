Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:54952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751082AbdJBOLG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 10:11:06 -0400
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: "Yuriy M. Kaminskiy" <yumkam@gmail.com>, util-linux@vger.kernel.org
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
 <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
 <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz> <m3wp6u5k8z.fsf@gmail.com>
 <68bc995a-3b0c-5b2c-cb7a-5f0052d19bef@suse.cz>
 <45a7e1bc-62cb-cf96-07c7-c4801dcf23d4@suse.cz>
 <20171002150048.3a609f57@kitsune.suse.cz>
 <eb224df4-615b-18e2-a9ee-5d98db9db225@suse.cz>
 <20171002155004.5878caee@kitsune.suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <6685d3eb-09b9-3904-1565-2bcfdc83eac5@suse.cz>
Date: Mon, 2 Oct 2017 16:11:04 +0200
MIME-Version: 1.0
In-Reply-To: <20171002155004.5878caee@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Michal Suchánek wrote:
> On Mon, 2 Oct 2017 15:06:33 +0200
> Stanislav Brabec <sbrabec@suse.cz> wrote:
> 
>> Michal Suchánek wrote:
>>> it is completely reasonable to return ENOMEDIUM from kernel when the
>>> tray is open and let userspace decide if it wants to attempt to
>>> close the tray and how long it wants to wait for the tray to close
>>> (it may be blocked/broken).
>>>   
>> But then, what is the purpose of /proc/sys/dev/cdrom/autoclose?
> 
> It can be used as a hint in mount if closing the tray is desired or
> not.

Such feature could be completely implemented in the user space, so there
is no reason to stay in the kernel in such a limited form.

20 years ago, it was a completely working implementation inside the
kernel. User space just called mount(), and it succeeded.

If that requires user space loop loop, then there is no reason to
implement sysfs entry just to perform tray close inside mount() syscall
and then fail anyway.

> I guess this used to work with IDE drivers not using SCSI emulation.
> 
> With SCSI the close tray command is executed like any other with
> default timeout and obviously does time out in most cases. 
> 
> But how long should the kernel wait? Is 1 minute ok? Should it wait 5
> minutes in case the user did not align the medium properly and needs to
> realign it? Who should set this timeout, where?
> 
The timeout should be equal to the time to close tray on the slowest
device. Guessing something about 3 to 5 seconds may be fine. After that
time (or several times until that time), just check when the tray starts
to report that it is closed.

By the way, most drives open the tray in the case of medium misalignment.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

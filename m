Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:45616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750957AbdJBNGe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 09:06:34 -0400
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
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <eb224df4-615b-18e2-a9ee-5d98db9db225@suse.cz>
Date: Mon, 2 Oct 2017 15:06:33 +0200
MIME-Version: 1.0
In-Reply-To: <20171002150048.3a609f57@kitsune.suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Michal Suchánek wrote:
> it is completely reasonable to return ENOMEDIUM from kernel when the
> tray is open and let userspace decide if it wants to attempt to close
> the tray and how long it wants to wait for the tray to close (it may be
> blocked/broken).
> 
But then, what is the purpose of /proc/sys/dev/cdrom/autoclose?

Just to start closing the tray?

If it is true, the logic should be:

If (error is ENOMEDIUM
    AND /proc/sys/dev/cdrom/autoclose is 1
    AND tray can be closed)
THEN
    sleep few seconds and retry


Alternatively, implement also:

If (error is ENOMEDIUM
    AND /proc/sys/dev/cdrom/autoclose is 0
    AND tray can be closed)
THEN
    close tray
    IF (close tray succeeded)
    THEN sleep few seconds and retry

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

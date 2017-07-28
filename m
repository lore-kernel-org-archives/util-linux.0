Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:53955 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752141AbdG1P0V (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 28 Jul 2017 11:26:21 -0400
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>, util-linux@vger.kernel.org
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
 <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
 <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz> <m3wp6u5k8z.fsf@gmail.com>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <68bc995a-3b0c-5b2c-cb7a-5f0052d19bef@suse.cz>
Date: Fri, 28 Jul 2017 17:26:20 +0200
MIME-Version: 1.0
In-Reply-To: <m3wp6u5k8z.fsf@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dne 27.7.2017 v 10:58 Yuriy M. Kaminskiy napsal(a):
>>  	case ENOMEDIUM:
>> +		cdrom = open(mnt_context_get_source(cxt), O_RDONLY | O_NONBLOCK);
>> +		if (cdrom != -1) {
>> +			if (retries < CRDOM_TRAYOPEN_RETRIES &&
>> +			    (ioctl(cdrom, CDROM_GET_CAPABILITY, NULL) & CDC_CLOSE_TRAY) &&
> 
> If ioctl is not supported, and ioctl() returns -1, (ioctl() & FOO) is
> true.

Yes, ugly code, but even if -1 passes the check, CDROM_DRIVE_STATUS will
not return CDS_TRAY_OPEN.

> I guess this should be something like
> +                            (rc = ioctl(cdrom, CDROM_GET_CAPABILITY, NULL)) != -1 &&
> +                             (rc & CDC_CLOSE_TRAY) &&
> instead.

That would be cleaner but more complicated.

> (And, I used cdrom a long time ago, but IIRC there were some driver
> settings to automatically close tray on device open, so that this patch
> should not be needed?)

Thanks for this hint. Yes, you are true:
/proc/sys/dev/cdrom/autoclose
/proc/sys/dev/cdrom/autoeject

But this does not work with the current mount. The mount request will
expire on timeout earlier than the tray of ordinary CDROM closes.

But yes, it is possible to implement a different, simpler patch that
will make the autoclose feature working, and not cause delays in case of
no medium.

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

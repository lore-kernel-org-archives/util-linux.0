Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
 <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
 <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
 <20170801121615.nxqolue5qv3rwlrh@ws.net.home>
 <20170905110413.jy24jrfd2pr7ts4k@ws>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <dd52f640-cf48-a190-3c5c-b856aeb2dadf@suse.cz>
Date: Tue, 5 Sep 2017 14:53:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170905110413.jy24jrfd2pr7ts4k@ws>
Content-Type: text/plain; charset=iso-8859-2
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> Stanislav, do you want to update the patch before the next release?

Probably not. Kernel autoclose feature should be fixed instead, and this
patch will not be needed.

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

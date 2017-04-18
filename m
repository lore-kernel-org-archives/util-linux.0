Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] libmount: Ensure utab.lock mode 644
To: Karel Zak <kzak@redhat.com>
References: <e837973e-9f84-827f-ba86-1799d291bf8b@suse.cz>
 <20170418092328.rnyzxw2w7f6hc3r5@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <6a7174b7-1d8d-7f23-16b0-e403cd936250@suse.cz>
Date: Tue, 18 Apr 2017 14:15:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170418092328.rnyzxw2w7f6hc3r5@ws.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Dne 18.4.2017 v 11:23 Karel Zak napsal(a):
> On Tue, Apr 11, 2017 at 04:12:52PM +0200, Stanislav Brabec wrote:
>> Ensure that the mode is always 644.
>>
> 
> Hmm... interesting issue. systemd?

Partially. A combination of restrictive umask, user mount on login and
later umount. mnt_monitor_get_fd() then fails.

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

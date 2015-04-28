Return-Path: sbrabec@suse.cz
Message-ID: <553FA739.5010007@suse.cz>
Date: Tue, 28 Apr 2015 17:28:57 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck: implement fsck -r {fd}
References: <553E53D7.8020800@suse.cz> <20150428115210.GW27969@ws.net.home>
In-Reply-To: <20150428115210.GW27969@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>
>   Applied, thanks. See notes below.
>
> On Mon, Apr 27, 2015 at 05:20:55PM +0200, Stanislav Brabec wrote:
>> Note: Code in if and else is intentionally partially duplicated. Current
>> human readable output of floats does not conform to locale conventions,
>> and may be changed in future. But we want to keep machine readable output
>> exactly same as it is now.
>
> The question is if we can change the human readable output. It was
> requested by Google and I guess they parse the output.
>
I created the alternative output format just for purpose of machine 
parsing: No need for scanf(), just space separated values.

I was also thinking about possibility to switch between human-readable 
and easily parseable output even to a specified FD, but I did not 
implement it.

I could be easy: Positive number would mean easily parseable output, 
negative number human readable. Just zero will be a problem (but we can 
still parse it on ASCII level and allow -r-0.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

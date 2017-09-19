Return-Path: sbrabec@suse.cz
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] If using wide nscurses, use wide tinfo (tinfow)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <89952e72-6858-5a11-8157-995f75b3774b@suse.cz>
 <20170919110556.g4chfnwz3wkcoe5o@ws.net.home>
Message-ID: <82afdf03-bfcb-700f-67a4-35f1aa631df0@suse.cz>
Date: Tue, 19 Sep 2017 14:10:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170919110556.g4chfnwz3wkcoe5o@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Sep 18, 2017 at 06:10:09PM +0200, Stanislav Brabec wrote:
>> util-linux checks for libtinfo, even if libncursesw is used. It can cause
>> ugly crashes inside ncurses, e. g. in cfdisk.
> 
> Hmm... this i is first time I see this problem. Ah yes, it seems we
> need another permutation for the wonderful ncurses world :-)

I got additional information about this issue:

In past, there was only tinfo. Few weeks ago tinfo and tinfow stopped to
be binary compatible and tinfow was created. It caused many crashes.
Then ncurses developers decided to make them binary compatible again,
but the format split will probably stay, open to future development.

So we can suppose that:

IF tinfow does not exist AND ncursesw is used THEN we can safely use tinfo.

IF tinfow exists AND ncursesw is used THEN it is unsafe to use tinfo and
we should (have to?) use tinfow.

=> My patch is too strict.

> I've committed a little different solution. I've added UL_TINFO_CHECK()
> and call it from configure with "tinfow" and fallback to "tinfo" if
> not found the widechar version or for non-widechar ncurses.
> 
> Please, test it for your environment. I'd like to release -rc1 ASAP.

Works perfectly! Thanks.

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

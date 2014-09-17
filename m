Return-Path: elseifthen@gmx.com
Message-ID: <54198DE1.8040008@gmx.com>
Date: Wed, 17 Sep 2014 09:34:25 -0400
From: elseifthen <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: * RECALL * [PATCH 1/2] hwclock: hctosys drift compensation
References: <5415EC97.4060305@gmx.com> <5416F1CC.2010007@gmx.com> <20140916093525.GG7867@x2.net.home> <54183647.2080101@gmx.com> <20140917095528.GJ7867@x2.net.home>
In-Reply-To: <20140917095528.GJ7867@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>


On 09/17/2014 05:55 AM, Karel Zak wrote:

>> My initial thought when I read u-l's todo list was that adjtimex [ -c | -a ]
>> depend upon /etc/adjtime *drift* data.  Do we care about breaking that?
> 
> I'm not sure, but I guess adjtimex reads /etc/adjtime to get info
> about UTC/LOCAL only. Well, it seems we need to check adjtimex code.

man 8 adjtimex
       -c[count], --compare[=count]
              ...  CMOS clock readings are adjusted
              for systematic drift using using the correction in /etc/adjtime
              -- see hwclock(8)...

> Note that we have hwclock --compare to provide adjtimex -c functionality 
> with in hwclock.

I have not had a chance to examine it closely yet, but it appears to be quite 
rudimentary at this point when compared to adjtimex -c.  I'm not sure I understand
the purpose of trying to build adjtimex into hwclock anyway.  Why not just use
adjtimex to do adjtimex things? 
 
>> I have often thought that hwclock should have a separate 'configuration' file,
>> for example, to allow specific init behavior customization without requiring
>> system admins to modify the init scripts.
> 
> The old RHEL/Fedora has /etc/sysconfig/hwclock where is possible
> to specify hwclock command line, so no one is forced to modify init
> scripts. All you need is to read the file from your init scripts.

But that is distro specific. Rather than having everyone baking their own
solution it seems more practical for hwclock to have its own config file.
This todo item seems like a good opportunity to do so.

> (but yes, we (upstream) still support the original hwclock(8) use-cases
>  and non-systemd installations)

I'm glad you included this comment.  I wouldn't wasting my time trying to
improve hwclock otherwise. I have no interest in dragging the systemd war
into this conversation, but my distro of choice is pushing back against it.

Also with IoT putting Linux into everything from automobiles to light bulbs,
and some of them interested in keeping good date-time, I think hwclock's init 
capabilities could remain relevant for some time to come. Linux is about more
then just distros, yes?

Will

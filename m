Return-Path: d@falconindy.com
Date: Tue, 7 Aug 2012 07:35:21 -0400
From: Dave Reisner <d@falconindy.com>
To: Karel Zak <kzak@redhat.com>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
Message-ID: <20120807113521.GC564@rampage>
References: <501D42D2.6050904@draigBrady.com>
 <20120806081533.GA24621@x2.net.home>
 <20120806111059.GB24621@x2.net.home>
 <501FD845.50001@draigBrady.com>
 <20120807080939.GF24621@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120807080939.GF24621@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 07, 2012 at 10:09:39AM +0200, Karel Zak wrote:
> On Mon, Aug 06, 2012 at 03:44:21PM +0100, Pádraig Brady wrote:
> > I did a quick test...
> 
>  Thanks, I'll use it in regression tests ;-) (I was busy yesterday to
>  write any reg.tests.)
> 
> > TARGET                 SOURCE     FSTYPE OPTIONS
> > /home/padraig/tst/ascii /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
> > /home/padraig/tst/ascii
> > TARGET                       SOURCE     FSTYPE OPTIONS
> > /home/padraig/tst/co\x0atrol /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
> > /home/padraig/tst/co\x0atrol
> > TARGET                       SOURCE     FSTYPE OPTIONS
> > /home/padraig/tst/back\slash /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
> > /home/padraig/tst/back\slash
> > TARGET                       SOURCE     FSTYPE OPTIONS
> > /home/padraig/tst/es\x63aped /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
> > /home/padraig/tst/es\x5cx63aped
> > TARGET SOURCE     FSTYPE OPTIONS
> > 
> >        /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
> > /home/padraig/tst/non\xfffffffatf8
> > TARGET                         SOURCE     FSTYPE OPTIONS
> > /home/padraig/tst/日一二三四五六 /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
> > /home/padraig/tst/\xffffffe6\xffffff97...
> > 
> > So two questions.
> > 
> > 1. Should the back\slash case be back\x5cslash in both cases?
> 
>  back\slash is not \x<xdigit> sequence, so escape is unnecessary
> 
>  Note that \\server\path is pretty common for cifs and use \x5c
>  for all '\' will make the findmnt output unreadable in many cases.
>  IMHO is better to be "smart" and use escape sequences only when it's
>  really necessary.
> 
> > 2. The nonútf8 one produces an errant new line.
> > Also in this case could you fall back to using \x escapes for the whole string?
> 
>  Yeah, nonútf8 output seems strange, I'll fix it.
> 
> 
>  I'll also update findmnt (and others) man pages to explain when and
>  how we use \x escapes. Is there any elegant way how to convert \x
>  sequences back to the native strings in shell? Maybe we can add some
>  hint to the man pages too.
> 

You can do something as simple as:

  printf '%b' "$mangled_content"

And it works even in POSIX shell. However, the %b formatter unescapes
simple control character sequences as well, so "foo\bar" will end up as
"foar" because the '\b' is consumed as a backspace. I ended up writing
my own unmangle routine to properly, and only, handle octal and hex
escapes:

https://github.com/falconindy/arch-install-scripts/blob/master/common#L70

Dave

>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: util-linux-owner@vger.kernel.org
Received: from shell.v3.sk ([92.60.52.57]:39232 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeDYH1B (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Apr 2018 03:27:01 -0400
Message-ID: <1524641212.713764.130.camel@v3.sk>
Subject: Re: terminal-colors.d(5) clarifications needed
From: Lubomir Rintel <lkundrak@v3.sk>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Wed, 25 Apr 2018 09:26:52 +0200
In-Reply-To: <20180424075949.uzti4kt4mvfreuzo@ws.net.home>
References: <1524492459.713764.57.camel@v3.sk>
         <20180424075949.uzti4kt4mvfreuzo@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2018-04-24 at 09:59 +0200, Karel Zak wrote:
> On Mon, Apr 23, 2018 at 04:07:39PM +0200, Lubomir Rintel wrote:
> > 1.) It is unclear whether multiple .schem files should override
> > each
> >     other or be merged. We use the overriding behavior -- take the
> >     highest priority one and ignore the rest.
> 
> From the man page:
> 
> If there are more files that match for a utility, then the file with
> the more specific  filename  wins.   For  example,  the  filename
> "@xterm.scheme"  has  less  priority  than "dmesg@xterm.scheme".  The
> lowest priority are those files without a utility name and terminal
> identifier (e.g. "disable").
> 
> https://github.com/karelzak/util-linux/blob/master/lib/colors.c#L77
> 
>  * The terminal-colors.d/ evaluation is based on "scores":
>  *
>  *  filename                    score
>  *  ---------------------------------------
>  *  type                        1
>  *  @termname.type              10 + 1
>  *  utilname.type               20 + 1
>  *  utilname@termname.type      20 + 10 + 1
>  *
>  * the match with higher score wins. The score is per type.
> 
> The "type" is "disable", "enable" or "scheme".

Some misunderstanding here. Perhaps I was not too clear -- I'll try to
rephrase. Suppose I have both "utilname.type" and
"utilname@termname.type":

utilname.type:

error 1;1
warning 2;2

utilname@termname.type:

warning 3;3

What is the effective result?

Is it (overriding behavior):

warning 3;3

Or (merging behavior):

error 1;1
warning 3;3

We assume "overriding", but the documentation is not clear enough to
me.

> > 3.) What is the "Color names" paragraph for? How was the set
> > chosen?
> >     (Why is "white" not present?) Can it be used in place of
> >     an ansi-sequence and translated somehow? We just ignore it.
> 
> It's list of human readable aliases for colors. Not sure why we do
> not
> have "white" :-)
> 
> https://github.com/karelzak/util-linux/blob/master/include/color-
> names.h

Now, what's special about brown? :)

> https://github.com/karelzak/util-linux/blob/master/lib/color-
> names.c#L23
> 
>
> > 4.) Of what use would "Escape sequences" in ansi-sequence be? We
> > don't
> >     accept that.
> 
> This is extension based on coreutils. IMHO it's not important.

I it correct to say that only ANSI terminals are actually supported?
Are there even terminals that use coloring in a way that's incompatible
with ANSI escape sequences?

I'm asking because the fact that colors are represented as color codes
without the leading escape suggests that either the application somehow
figures out the correct escape (does termcap/terminfo know that?) or
just slaps in ESC [ assuming an ANSI terminal.

You also seem to just translate the "Color names" to ANSI escapes.

If it's indeed true, then I guess you could just drop the "Escape
sequences" paragraph, because it doesn't make any sense on ANSI
terminals. Or does it?

> > 5.) We don't implement TERMINAL_COLORS_DEBUG because it's unclear
> > what
> >     should it do.
> 
> Yes, this is unnecessary.
> 
> > Perhaps you could help me getting things done right, comment on the
> > points above, and maybe figure out how can the manual be improved
> > for
> > future implementers?
> 
> I'll improve the man page. Thanks for your feedback.

Feel free to Cc me with the patch, I'd be happy to provide my pair of
eyes to see if things make sense to me.

> Maybe we can convert our util-linux terminal-colors.d implementation
> to simple shared library. Would be something like this acceptable for
> NetworkManager? 
> 
> The interface is pretty simple (for example fdisk):
> 
>   colors_init(colormode, "fdisk");
> 
>   ...
>   color_scheme_enable("welcome", UL_COLOR_GREEN);
>   fdisk_info(cxt, _("Welcome to fdisk (%s)."), PACKAGE_STRING);
>   color_disable();
> 
> 
> where "colormode" is NEVER, ALWAYS, AUTO. The UL_COLOR_GREEN is
> the default color.
> 
> It would be pretty simple to convert it to stared library; just use
> less generic prefix (than color_), add control struct to avoid global
> variables.

Well, perhaps not. We tend to be super careful about adding
dependencies. I suspect we'd need to provide a way to disable the
functionality because some users just slap in busybox in place of util-
linux. Given how minimal our terminal-colors.d implementation it it's
probably not worth doing.

If you care about terminal-colors.d being more ubiquitous while also
sharing the implementation as much as possible then an effort would be
best spent making Glib use it. We, and everyone else, would inherit the
functionality and since recently Glib uses coloring in its logging
machinery.

> Note that the most important feature of terminal-colors.d is to
> provide a way how to disable/enable colors for all system or specific
> terminal. We need a way how to keep terminal usable for people who
> cannot use colors. The "scheme" stuff is the next level :-)

Yes, that's precisely why we're doing this too :)

> 
>     Karel

Thanks for the clarifications. It's much appreciated.

Lubo

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755830AbeDXH7w (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 24 Apr 2018 03:59:52 -0400
Date: Tue, 24 Apr 2018 09:59:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: util-linux@vger.kernel.org
Subject: Re: terminal-colors.d(5) clarifications needed
Message-ID: <20180424075949.uzti4kt4mvfreuzo@ws.net.home>
References: <1524492459.713764.57.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524492459.713764.57.camel@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:07:39PM +0200, Lubomir Rintel wrote:
> 1.) It is unclear whether multiple .schem files should override each
>     other or be merged. We use the overriding behavior -- take the
>     highest priority one and ignore the rest.

>From the man page:

If there are more files that match for a utility, then the file with
the more specific  filename  wins.   For  example,  the  filename
"@xterm.scheme"  has  less  priority  than "dmesg@xterm.scheme".  The
lowest priority are those files without a utility name and terminal
identifier (e.g. "disable").

https://github.com/karelzak/util-linux/blob/master/lib/colors.c#L77

 * The terminal-colors.d/ evaluation is based on "scores":
 *
 *  filename                    score
 *  ---------------------------------------
 *  type                        1
 *  @termname.type              10 + 1
 *  utilname.type               20 + 1
 *  utilname@termname.type      20 + 10 + 1
 *
 * the match with higher score wins. The score is per type.

The "type" is "disable", "enable" or "scheme".

> 2.) Is "name.schem" or "@term.schem" "more specific"? We assume it's
>     "name.schem".

Yes.

> 3.) What is the "Color names" paragraph for? How was the set chosen?
>     (Why is "white" not present?) Can it be used in place of
>     an ansi-sequence and translated somehow? We just ignore it.

It's list of human readable aliases for colors. Not sure why we do not
have "white" :-)

https://github.com/karelzak/util-linux/blob/master/include/color-names.h
https://github.com/karelzak/util-linux/blob/master/lib/color-names.c#L23


> 4.) Of what use would "Escape sequences" in ansi-sequence be? We don't
>     accept that.

This is extension based on coreutils. IMHO it's not important.

> 5.) We don't implement TERMINAL_COLORS_DEBUG because it's unclear what
>     should it do.

Yes, this is unnecessary.

> Perhaps you could help me getting things done right, comment on the
> points above, and maybe figure out how can the manual be improved for
> future implementers?

I'll improve the man page. Thanks for your feedback.

Maybe we can convert our util-linux terminal-colors.d implementation
to simple shared library. Would be something like this acceptable for
NetworkManager? 

The interface is pretty simple (for example fdisk):

  colors_init(colormode, "fdisk");

  ...
  color_scheme_enable("welcome", UL_COLOR_GREEN);
  fdisk_info(cxt, _("Welcome to fdisk (%s)."), PACKAGE_STRING);
  color_disable();


where "colormode" is NEVER, ALWAYS, AUTO. The UL_COLOR_GREEN is
the default color.

It would be pretty simple to convert it to stared library; just use
less generic prefix (than color_), add control struct to avoid global
variables.


Note that the most important feature of terminal-colors.d is to
provide a way how to disable/enable colors for all system or specific
terminal. We need a way how to keep terminal usable for people who
cannot use colors. The "scheme" stuff is the next level :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

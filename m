Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932471AbeD0J7T (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 27 Apr 2018 05:59:19 -0400
Date: Fri, 27 Apr 2018 11:59:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: util-linux@vger.kernel.org
Subject: Re: terminal-colors.d(5) clarifications needed
Message-ID: <20180427095916.ez5rzg4bq5znfeiu@ws.net.home>
References: <1524492459.713764.57.camel@v3.sk>
 <20180424075949.uzti4kt4mvfreuzo@ws.net.home>
 <1524641212.713764.130.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524641212.713764.130.camel@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 25, 2018 at 09:26:52AM +0200, Lubomir Rintel wrote:
> Some misunderstanding here. Perhaps I was not too clear -- I'll try to
> rephrase. Suppose I have both "utilname.type" and
> "utilname@termname.type":
> 
> utilname.type:
> 
> error 1;1
> warning 2;2
> 
> utilname@termname.type:
> 
> warning 3;3
> 
> What is the effective result?
> 
> Is it (overriding behavior):
> 
> warning 3;3

This is the result.

> Or (merging behavior):
> 
> error 1;1
> warning 3;3

Only one file is open according to score calculated from the file name.
The winner is used for everything, no merging at all.

> > > 4.) Of what use would "Escape sequences" in ansi-sequence be? We
> > > don't
> > >     accept that.
> > 
> > This is extension based on coreutils. IMHO it's not important.
> 
> I it correct to say that only ANSI terminals are actually supported?

Yes.

> Are there even terminals that use coloring in a way that's incompatible
> with ANSI escape sequences?

We use only 

    ncolors = tigetnum("colors");

and if ncolors <= 2 then all the stuff is disabled for the terminal.

> I'm asking because the fact that colors are represented as color codes
> without the leading escape suggests that either the application somehow

 12;34

is internally converted to "\033[12;34m". It's only user friendly way
how to write the codes to the file. The result is always \033[...

> figures out the correct escape (does termcap/terminfo know that?) or
> just slaps in ESC [ assuming an ANSI terminal.

Frankly, it would be possible to be more smart with the codes (like
coretils, see below), but I have doubts it's important enough... we do
not have any bug report in last 5 years, so I don't care ;-)

> You also seem to just translate the "Color names" to ANSI escapes.

Yes.

> If it's indeed true, then I guess you could just drop the "Escape
> sequences" paragraph, because it doesn't make any sense on ANSI
> terminals. Or does it?

It allows to specify control chars

# echo "example \n" > /etc/terminal-colors.d/foo.scheme
# ./test_colors --name foo --color-scheme example

Hello World!
# 

... not sure how usable it's, but it was suggested to be more
compatible with coreutils dir_colors, so we support it.


Note that dir_colors from coreutils also supports non-ANSI as they
have LEFTCODE and RIGHTCODE setting to overwrite begin and end of the
sequence, so you can manually set something else than "\033[" and "m".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

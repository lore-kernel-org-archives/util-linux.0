Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38894 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075AbaEYUvW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 25 May 2014 16:51:22 -0400
Message-Id: <1401051081.24456.121397993.69EFB4EB@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAG27Bk2bgpkodp2FgxmXkUhoSe8rWAuBFh40bU6t+1rmavHg2g@mail.gmail.com>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
 <1400929696-12548-2-git-send-email-kerolasa@iki.fi>
 <1400934651.15812.121082081.6ADC22B3@webmail.messagingengine.com>
 <CAG27Bk2bgpkodp2FgxmXkUhoSe8rWAuBFh40bU6t+1rmavHg2g@mail.gmail.com>
Subject: Re: [PATCH 1/4] setterm: add usage() descriptions
Date: Sun, 25 May 2014 22:51:21 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, May 25, 2014, at 12:57, Sami Kerola wrote:
> Ah, I see. It would be really good to get an example of literate
> argument to both howtos.
> 
> Documentation/howto-man-page.txt
> Documentation/howto-usage-function.txt
> 
> Maybe something like this
> 
> diff --git a/Documentation/howto-man-page.txt b/Documentation/howto-man-page.txt
> [...]
>  .TP
> +\fB\-l\fR, \fB\-\-literal\fR \fIword\fR
> +Tell in description option argument is required and that it can be only
> +.BR word .

Well, yes, but it should be \fBword\fR. -- bold.

> + -L, --literal [arg|foo] required argument is one of the literal strings

Yes, but better not use the word "arg" because it sounds too much
like it has to be replaced with something.  Better: "--literal [foo|baz]".

> >> +     fputs(_(" --foreground    <default|color>   set foreground color\n"), out);
> >
> > default|<color>
> 
> Colors are literal strings so [color], and that can be short cut to
> [default|color] where color possibilities are explained in later line.

...  No!  Yes, colors are literal strings, but not the word color itself,
that's why it's written as <color>.  ...  Okay, let's say this differently:
--foreground is an option, it can take nine or ten different arguments.
One of the possible arguments is the literal word "default", and all
the other ones are names for colors, but not the word "color" itself,
of course -- so it is written as "default|<color>".  And the argument
of --foreground is not optional, so no square brackets.


> >> +     fputs(_(" --regtabs       <1-160>           set default tab stop position\n"), out);
> >
> > To be consistent this should be "--regtabs <number>", and then add that
> > <number> can be 1..160.  But that loses conciseness.
> 
> Options --tab argument <number> defines length of a specific tab,
> while the --regtabs is a range. In former the number is value, and in
> later more like literal string, constant, or a definition.

??  ...  I think you have the two mixed up.  The option --tabs takes a sequence
of numbers as arguments, so it should be "<number>..." (it probably should be
an ascending sequence, but the man page doesn't say).  The option --regtabs
takes a single number as argument, so "<number>" -- 'regtabs' seems to be
short for "regular tabs" or "tabs at a regular interval", and the number gives
the size of the interval.  All these numbers are constant values.

> >> +     fputs(_(" --blank         <0-60|force|poke> set inactivity interval\n"), out);
> >
> > --blank  [<number>|force|poke]
> > and <number> can be 1..60 (minutes)
> 
> Same here. This dualistic 'number as value' and 'number as definition'

I don't understand what you mean with this dualistic nature.

> may need an example to howtos files. IMHO the long description in
> which range is '<number>' and later text tells '<number> has range 1
> to 60' is too verbose, good usage() is brief, man page as verbose as
> needed.

Yes, I agree that using <number> and then explaining what <number> can be
is somewhat verbose, so it is okay to use "--blank  [0-60|force|poke]",
like the man page does.

Benno

-- 
http://www.fastmail.fm - Send your email first class


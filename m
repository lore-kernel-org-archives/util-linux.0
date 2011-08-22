Return-Path: bensberg@justemail.net
Message-Id: <1314045499.25233.140258132498281@webmail.messagingengine.com>
From: "Benno Schulenberg" <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Karel Zak" <kzak@redhat.com>, "util-linux"
 <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com>
References: <20110815141948.GH2038@nb.net.home><CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com><1313485424.19019.140258130122469@webmail.messagingengine.com><20110816104652.GA14535@nb.net.home><CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com><1313831405.14363.140258131741205@webmail.messagingengine.com>
 <CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com>
Subject: Re: man-pages and usage() howto
Date: Mon, 22 Aug 2011 22:38:19 +0200
List-ID: <util-linux.vger.kernel.org>


On Sat, 20 Aug 2011 21:08 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
> On Sat, Aug 20, 2011 at 11:10, Benno Schulenberg <bensberg@justemail.net> wrote:
> > On Wed, 17 Aug 2011 15:07 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
> >> Having also definition for OPTION_HELP && OPTION_VERSION would be
> >> good.
> >
> > That won't work -- the amount of indentation for the option description
> > is not the same for all utilities.  And to make it the same for all would
> > create ugly and unneeded wide open text spaces for some tools.
> 
> To me it does not sound a big deal if --help and --version
> description begins from different indent than rest of lines. I
> wrote example output that way, so that you can judge how that
> will look.

When --help and --version are always the last two options of the
usage help text, a differing indentation is acceptable.  But if --help
is ordered alphabetically, it will look broken.

> \fB\-o\fR, \fB\-\-optional\fR[=<\fIarg\fR>]
> This option uses optional argument.

As Karel said, the majority convention now is to not use pointy brackets
for arguments in man pages.  The italics/underlining is enough to make
them stand out.

I would also suggest to not use "arg" but the full word "argument", so as
to encourage writers to not unnecessarily abbreviate the argument name,
to use for example "seconds" and not "secs", use "number" and not "num".

A thing about the formatting: why us \fB and \fR and \fB and \fR?
Why not use the macro .BR at the start of the line instead?
(I do not understand your comment about some macros not being
visually different from plain .B or .I.)

Another thing: the man page formatter itself puts a double space after a
period when in the man page source the next sentence begins on a new
line.  So when in the source a new sentence begins somewhere midline,
it should use a double space before its initial letter.

>From your usage howto:
>  -n, --no-argument option requires no_argument
>  -o, --optional[=<arg>] option has optional_argument
>  -r, --required <arg> option requires required_argument

Why the underscores?  I would suggest the following:

  -n, --no-argument       option takes no argument
  -o, --optional[=<arg>]  option takes optional argument
  -r, --required <arg>    option requires an argument

(As in a usage text space is limited, abbreviations are okay.)

Regards,

Benno

-- 
http://www.fastmail.fm - Access your email from home and the web

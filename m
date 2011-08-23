Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <1314045499.25233.140258132498281@webmail.messagingengine.com>
References: <20110815141948.GH2038@nb.net.home>
	<CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
	<1313485424.19019.140258130122469@webmail.messagingengine.com>
	<20110816104652.GA14535@nb.net.home>
	<CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com>
	<1313831405.14363.140258131741205@webmail.messagingengine.com>
	<CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com>
	<1314045499.25233.140258132498281@webmail.messagingengine.com>
Date: Tue, 23 Aug 2011 10:15:14 +0200
Message-ID: <CAG27Bk2NS7-tRH4Acp-_WFhAmxELm4cCZ79mwgbXWnDJ7gFAfw@mail.gmail.com>
Subject: Re: man-pages and usage() howto
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 22, 2011 at 22:38, Benno Schulenberg <bensberg@justemail.net> w=
rote:
> On Sat, 20 Aug 2011 21:08 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
>> To me it does not sound a big deal if --help and --version
>> description begins from different indent than rest of lines. I
>> wrote example output that way, so that you can judge how that
>> will look.
>
> When --help and --version are always the last two options of the
> usage help text, a differing indentation is acceptable. =A0But if --help
> is ordered alphabetically, it will look broken.

True, and that's why I wrote they should be last entries.

>> \fB\-o\fR, \fB\-\-optional\fR[=3D<\fIarg\fR>]
>> This option uses optional argument.
>
> As Karel said, the majority convention now is to not use pointy brackets
> for arguments in man pages. =A0The italics/underlining is enough to make
> them stand out.

I guess you did not read from git the section.

.SH OPTIONS
.TP
\fB\-n\fR, \fB\-\-no\-argument\fR
This option does not use argument.
.TP
\fB\-o\fR, \fB\-\-optional\fR [\fIarg\fR]
Tell in description an
.I arg
is optional, and what happens when is or is not given.
.TP
\fB\-r\fR, \fB\-\-required\fR \fIarg\fR
Tell in description option
.I arg
is required.

As you can see no diamond brackets there.

> I would also suggest to not use "arg" but the full word "argument", so as
> to encourage writers to not unnecessarily abbreviate the argument name,
> to use for example "seconds" and not "secs", use "number" and not "num".

Good point. I will fix that when I'm at home again.

> A thing about the formatting: why us \fB and \fR and \fB and \fR?
> Why not use the macro .BR at the start of the line instead?

No matter how I tried to use various .B, .BR

> (I do not understand your comment about some macros not being
> visually different from plain .B or .I.)

Either my term, groff or pager is/are broken, or I have wooden eyes or
the different highlights do not stand out, see yourself:

http://ut3.org/~kerolasa/groff-highlight.png

What I tried to say; Do not get fooled that different macros will look
different so that you can refer visually in between different text
elements. For example in the screen shot on top the required argument
has same appearance when it is next to switch & in text. I think that
sort of consistency in style makes things more understandable.

> Another thing: the man page formatter itself puts a double space after a
> period when in the man page source the next sentence begins on a new
> line. =A0So when in the source a new sentence begins somewhere midline,
> it should use a double space before its initial letter.

Are you sure it does that? See the screenshot notes section third
paragraph line two, words `macros. See' has only single space in
between them. Even there would be two spaces I do not agree that groff
input writer should imitate output. It should be enough that words and
sentences are white space separated, groff will take care the rest.

> From your usage howto:
>> =A0-n, --no-argument option requires no_argument
>> =A0-o, --optional[=3D<arg>] option has optional_argument
>> =A0-r, --required <arg> option requires required_argument
>
> Why the underscores? =A0I would suggest the following:
>
> =A0-n, --no-argument =A0 =A0 =A0 option takes no argument
> =A0-o, --optional[=3D<arg>] =A0option takes optional argument
> =A0-r, --required <arg> =A0 =A0option requires an argument
>
> (As in a usage text space is limited, abbreviations are okay.)

The weird underscores are used in option structure. Now when you
mention that I think having such unexplained reference is not good.
I'll write the description using ordinary text.

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/

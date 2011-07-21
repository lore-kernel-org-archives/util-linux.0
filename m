Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110721190328.GH22568@nb.net.home>
References: <CAG27Bk0XXawQERH19+iUguDame2Pts_+bvrt8Of0+ib9KSW3NA@mail.gmail.com>
	<20110718221751.GD4354@nb.redhat.com>
	<CAG27Bk3vs54m7b6y_M_uq4RuyPBn-yhAEt2GhicsyY8F_+jJfw@mail.gmail.com>
	<20110721154303.GF22568@nb.net.home>
	<CAG27Bk1R_fG+SkFd1JfoiEyg7z8saJv4V+=K02Cz8_OHL9tz=w@mail.gmail.com>
	<20110721190328.GH22568@nb.net.home>
Date: Thu, 21 Jul 2011 22:03:12 +0200
Message-ID: <CAG27Bk13jzu8BMyNGgCDzjgo9B0yXqFj3RNn5XLejjuEqX02ZA@mail.gmail.com>
Subject: Re: [git pull] schedutils
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 21, 2011 at 21:03, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Jul 21, 2011 at 08:37:52PM +0200, Sami Kerola wrote:
>> > =A0* I think that
>> > =A0 =A0 =A0 =A0-c, --class NUM
>> > =A0 is better than
>> > =A0 =A0 =A0 =A0-c, --class=3DNUM
>>
>> With equals sign is FSFism, which seemed like good starting point...
>
> =A0:-)
>
> =A0The '=3D' is required only for optional arguments, the it's probably
> =A0the best to use
>
> =A0 =A0--foo[=3DNUM]

I've already forgot what was the original switch did, but that is
exactly how optional argument should be marked up to make *nix command
line tools to look & feel the same. Which IMHO is important for users.

>> > =A0I have fixed this in ionice man page, but not in usage(). It would =
be
>> > =A0nice to use in all man pages and usage() functions the same syntax.
>> > =A0Maybe we can create any template or so to have it documented.
>>
>> ...but you are absolutely right again. Converting README.devel in
>> small chunks to a Documentation directory might be a way to go.
>
> =A0Good idea!

I'll propose in future something, unless someone else is quicker.

>> BTW what would you think about having a util-linux.h with inline
>
> =A0Should be enough to use c.h ?

Possibly.

>> function to print in usage help & version option descriptions and
>> proper version output function. The first would make translation teams
>> happier when they do not need to write time after time the same
>> translations. Second would simply unify how version is printed, and if
>
> =A0Well, .po files never contains duplicate strings.

Yes and no. What I mean is this:

util-linux/po grep -c 'display this help and exit' util-linux.pot
27

By writing the strings once & reusing the separated stings in usage()
functions should fix the issue.

>> In practice the file would be similar to coreutils system.h.
>
> =A0Hmm... I don't like
>
> =A0#define case_GETOPT_VERSION_CHAR(Program_name, Authors)
> =A0 =A0 =A0 =A0 =A0case GETOPT_VERSION_CHAR:
>
> =A0We don't use the same char everywhere and hide keywords (e.g. case)
> =A0to macros is not nice too.
>
> =A0It would be enough to use
>
> =A0 case 'V':
> =A0 =A0 =A0 =A0ul_print_version();
> =A0 =A0 =A0 =A0break;
>
> =A0The result should be readable C language, not any gnulib meta-language=
 :-)

Yup, I agree. Doing the very same as coreutils is possibly not a good
match. Partially copying good ideas seems better, but that just
requires bit of thinking which ideas apply well. Uh, programming is
difficult.

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/

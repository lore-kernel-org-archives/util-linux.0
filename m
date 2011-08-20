Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <1313831405.14363.140258131741205@webmail.messagingengine.com>
References: <20110815141948.GH2038@nb.net.home>
	<CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
	<1313485424.19019.140258130122469@webmail.messagingengine.com>
	<20110816104652.GA14535@nb.net.home>
	<CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com>
	<1313831405.14363.140258131741205@webmail.messagingengine.com>
Date: Sat, 20 Aug 2011 21:08:08 +0200
Message-ID: <CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com>
Subject: Re: man-pages and usage() howto
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 20, 2011 at 11:10, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Wed, 17 Aug 2011 15:07 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
>> On Tue, Aug 16, 2011 at 12:39, Karel Zak <kzak@redhat.com> wrote:
>>>
>>  -n, --no-argument     this option requires no_argument
>>  -o, --optional[=arg]  this option has optional_argument
>>  -r, --required <arg>  this option requires required_argument
>
> The middle one would need the pointy brackets, too, no?
>
>  -o, --optional[=<arg>]  this option has optional_argument

You are right. Fixed to howto-usage-function.txt

>> How putting to c.h the following?
>>
>> #define USAGE_HEADER _("\nUsage:\n")
>> #define USAGE_OPTIONS _("\nOptions:\n")
>> #define USAGE_SHORT_TAIL _("\n")
>> #define USAGE_MAN_TAIL _("For more details see %s.")
>
> Especially the latter would be nice: at the moment there are
> many such lines with just a differing final word.
>
>> Having also definition for OPTION_HELP && OPTION_VERSION would be
>> good.
>
> That won't work -- the amount of indentation for the option description
> is not the same for all utilities.  And to make it the same for all would
> create ugly and unneeded wide open text spaces for some tools.

To me it does not sound a big deal if --help and --version
description begins from different indent than rest of lines. I
wrote example output that way, so that you can judge how that
will look.

https://github.com/kerolasa/lelux-utiliteetit/blob/docs-dir/Documentation/howto-usage-function.txt

I do not understand why it would be sensible to ask translation
teams to make tens of versions near same help & usage strings
while these string could simply be a bit ugly.

>>>  I made the decision, --option <argument>.  [...]
>>>
>>>  It would be also nice to sync man pages with usage() format.
>
> Do you mean that you want to use "--option <argument>" also in the
> man pages, Karel?  Or do we stick there to italics for arguments?
> (Which translates to underlining on terminals.)

What ever was meant the howto is incomplete.

https://github.com/kerolasa/lelux-utiliteetit/blob/docs-dir/Documentation/howto-man-page.txt

IMHO the following looks quite ok, and not too different to
usage().

.TP
\fB\-n\fR, \fB\-\-no\-argument\fR
This option does not use argument.
.TP
\fB\-o\fR, \fB\-\-optional\fR[=<\fIarg\fR>]
This option uses optional argument.
.TP
\fB\-r\fR, \fB\-\-required\fR <\fIarg\fR>
This option requires an argument.

Comments?

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/

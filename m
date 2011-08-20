Return-Path: bensberg@justemail.net
Message-Id: <1313831405.14363.140258131741205@webmail.messagingengine.com>
From: "Benno Schulenberg" <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Karel Zak" <kzak@redhat.com>, "util-linux"
 <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com>
References: <20110815141948.GH2038@nb.net.home><CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com><1313485424.19019.140258130122469@webmail.messagingengine.com><20110816104652.GA14535@nb.net.home>
 <CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com>
Subject: Re: man-pages and usage() howto
Date: Sat, 20 Aug 2011 11:10:05 +0200
List-ID: <util-linux.vger.kernel.org>

On Wed, 17 Aug 2011 15:07 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
> On Tue, Aug 16, 2011 at 12:39, Karel Zak <kzak@redhat.com> wrote:
> >
> >    --date <time>
> >
> >  the important is visual difference between static option name
> >  and variable option argument.
> 
> Diamond brackets make visual difference to look quite nice. I do
> like this.

Yes, it does look better than all uppercase, so I'll accept.
(That I stuck to uppercase is because it wastes less space,
and with just 80 characters width this sometimes matters,
plus it seemed widespread tradition.)

>  -n, --no-argument     this option requires no_argument
>  -o, --optional[=arg]  this option has optional_argument
>  -r, --required <arg>  this option requires required_argument

The middle one would need the pointy brackets, too, no?

 -o, --optional[=<arg>]  this option has optional_argument

> >  I'm just working on Benno's patches and I found that we need
> >  some explicitly defined rules for usage():
> >
> >    - "Usage:" and "Options:" use separate lines and strings, before
> >       the sections has to be empty line:
> >
> >       fputs(_("\nUsage:\n"), out);
> >       ...
> >       fputs(_("\nOptions:\n"), out);
> >
> >     (so this two string will be translated only once)

As a translator I do not quite like the separation of the 
"\nUsage:\n" string from the actual synopsis -- it is good
to have some context in the string.  But I'll accept.  The
initial space of the actual synopsis strings will eventually
let translators understand what they are.

> How putting to c.h the following?
> 
> #define USAGE_HEADER _("\nUsage:\n")
> #define USAGE_OPTIONS _("\nOptions:\n")
> #define USAGE_SHORT_TAIL _("\n")
> #define USAGE_MAN_TAIL _("For more details see %s.")

Especially the latter would be nice: at the moment there are
many such lines with just a differing final word.

> Having also definition for OPTION_HELP && OPTION_VERSION would be
> good.

That won't work -- the amount of indentation for the option description
is not the same for all utilities.  And to make it the same for all would
create ugly and unneeded wide open text spaces for some tools.


> >  I made the decision, --option <argument>.  [...]
> >
> >  It would be also nice to sync man pages with usage() format.

Do you mean that you want to use "--option <argument>" also in the
man pages, Karel?  Or do we stick there to italics for arguments?
(Which translates to underlining on terminals.)

Regards,

Benno

-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free

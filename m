Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH 07/12] hwclock: update --help content and grammar
Date: Thu, 22 Jun 2017 04:04:58 +0200
Cc: Karel Zak <kzak@redhat.com>,
 util-linux@vger.kernel.org
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com> <20170621145537.5kwvb3zws26awlye@ws.net.home> <1de4c787-0e91-bdbd-1466-68416fc15335@gmx.com>
In-Reply-To: <1de4c787-0e91-bdbd-1466-68416fc15335@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201706220404.59013.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 21 June 2017, J William Piggott wrote:
> On 06/21/2017 10:55 AM, Karel Zak wrote:
> > On Wed, Jun 21, 2017 at 03:05:04PM +0200, Ruediger Meier wrote:
> >> On Tuesday 20 June 2017, Karel Zak wrote:
> >>> On Sun, Jun 18, 2017 at 08:45:09PM -0400, J William Piggott wrote:
> >>>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> >>>> ---
> >>>>  include/c.h         |  4 ++--
> >>>>  sys-utils/hwclock.c | 48
> >>>> +++++++++++++++++++++--------------------------- 2 files
> >>>> changed, 23 insertions(+), 29 deletions(-)
> >>>>
> >>>> diff --git a/include/c.h b/include/c.h
> >>>> index 9c19965..bd073fc 100644
> >>>> --- a/include/c.h
> >>>> +++ b/include/c.h
> >>>> @@ -319,8 +319,8 @@ static inline int xusleep(useconds_t usec)
> >>>>  #define USAGE_OPTIONS    _("\nOptions:\n")
> >>>>  #define USAGE_FUNCTIONS  _("\nFunctions:\n")
> >>>>  #define USAGE_SEPARATOR    "\n"
> >>>> -#define USAGE_HELP       _(" -h, --help     display this help
> >>>> and exit\n") -#define USAGE_VERSION    _(" -V, --version  output
> >>>> version information and exit\n") +#define USAGE_HELP       _("
> >>>> -h, --help     display this information and exit\n")
> >>>
> >>>  "display this help and exit\n"
> >>> or
> >>>  "display help information and exit\n"
> >>>
> >>> sounds better than "this information".
> >>
> >> IMO "this" is important because it makes clear that running --help
> >> would not give you any better information than the one you see
> >> already.
> >>
> >> Compare this:
> >> $ xz --help | grep help
> >>   -h, --help        display this short help and exit
> >>   -H, --long-help   display the long help (lists also the ...
> >>
> >> $ xz --long-help | grep help
> >>   -h, --help        display the short help (lists only the basic
> >> ... -H, --long-help   display this long help and exit
> >>
> >>
> >> Our old errtryhelp, USAGE_HELP and USAGE_VERSION were 100% the
> >> same like coreutils. This was a nice consensus and even a bit
> >> shorter.
> >>
> >> Anyways, instead of improving the grammer and correctness I would
> >> rather make these trivial option descriptions as short as
> >> possible, like
>
> My intent was to have these two very similar messages using the same
> language. I think it would be easier to understand for non-native
> speakers and easier for translators to work with if they did. I'm all
> for making them more concise, but how about this:
>
>   -h, --help     display this help
>   -V, --version  display version
> or
>   -h, --help     show this help
>   -V, --version  show version
>
> I like display better.

The more I think about it the more I am against any change at all. We 
have some commands with different short- or longopts for help/version. 
These commands hardcoded our old strings and now it looks inconsistent 
again.

So for now I would revert this "include/c.h" part of your patch.

If we still want to change it we should wait until my other usage/stderr 
cleanup settled down. For example I've added now --help and --version 
longopts for *all* our commands. So another idea would be to only show 
the longopts in the short help. Then all tools could use the macros.

Like

   --help     display this help
   --version  display version

... and corresponding short opts will be documented for correctness in 
the man pages only. IMO this would be ok for these trivial options. And 
personally I don't want to be teached about 'fsck -?' or 'chsh -u'. 
Lets hide these random short opts.


> >>  -h, --help     display this help
> >>  -V, --version  show version
> >>
> >> Everybody knows what these options do when they exist.
> >
> > Good points, please, send a patch. It would be also nice to add any
> > comment to the c.h to avoid future updates on this area.
> >
> >     Karel
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

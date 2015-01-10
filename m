Return-Path: elseifthen@gmx.com
Message-ID: <54B16A8A.3090605@gmx.com>
Date: Sat, 10 Jan 2015 13:08:10 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>
CC: Karel Zak <kzak@redhat.com>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] hwclock: update man page for v2.26 rc
References: <54AE031C.30907@gmx.com> <54AE052C.6050202@gmx.com> <1420893866.3537848.212162497.2B990B0E@webmail.messagingengine.com>
In-Reply-To: <1420893866.3537848.212162497.2B990B0E@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

On 01/10/2015 07:44 AM, Benno Schulenberg wrote:
> 
> On Thu, Jan 8, 2015, at 05:18, JWP wrote:
>> +.\" 2015-01-07 J William Piggott
>> +.\" Authored new section: DATE-TIME CONFIGURATION.
>> +.\" Subsections: Keeping Time..., LOCAL vs UTC, POSIX vs 'RIGHT'.
>> +.\" Errata and drop outdated language.
>> +.\" Updates for v2.26
> 
> Please don't add such changelog stuff to files -- this is what git is for.

I went back and fourth on this myself, Benno. I agree we do not want full
changelogs in files. My thinking in this particular case was, that there
has not been a significant update to this man-page in a couple of decades
and not everyone using it will have a local git repo. Someone may question,
who wrote this stuff?

Also, since I authored some completely new content I was thinking of any
copyright/copyleft issues; although I did not actually claim any. At least
the change is dated in the file.

Before adding this I checked other utli-linux man-pages and some of them
have extensive top comments. Including some changelogs, granted they are
old, but there are recent top comments still being added. Take a look:

cat $(find -name "*.[1-9]") | grep '^\.\\"' | less

Anyway, I am fine with striping it out. No big deal either way to me.

> 
>> +.\" Included for troff portability.
>> +.\" Continuation line for .TP header.
>> +.de TQ
>> [...]
> 
> Is this really needed?  Is there any chance that this new hwclock
> will get installed on a legacy Unix system (instead of on a recent
> Linux system with complete man macros)?


I don't know. I did not think this new hwclock would be used in DEC
Alpha's either, but it is. Despite its name, I have read that util-
linux is used elsewhere. BSD comes to mind. This is the most portable
way to do it. Having said that, the howto-man-page.txt does use TQ
without defining it. Again, it's fine with me Karel thinks it is not
needed, I'll strip it out.


> 
>> +is a tool for accessing the Hardware Clock.  It can: display the
>> +Hardware Clock time; set the Hardware Clock to a specified time; set the
>> +Hardware Clock from the System Clock; set the System Clock from the
>> +Hardware Clock; compensate for Hardware Clock drift; correct the System
>> +Clock timescale; set the kernel's timezone, NTP timescale, and epoch
>> +(Alpha only); compare the System and Hardware Clocks; and predict future
>> +Hardware Clock values based on its drift rate.
> 
> Nice.

Thank you!

> 
>> +.
> 
> Why all these added dots?  No other man page contains them.
>


Because troff source is not allowed to have empty lines. Troff
skips lines with only a dot. This is even stated in the 
./Documentation/howto-man-page.txt page.

Perhaps no other util-linux pages use it, but many man-pages do.

I'm fine with not having them at all, but there were existing
empty lines delimiting things like options so I left them there.


>> +The following functions are mutually exclusive, only one can be given at
>> +a time. If none are given the default is
>> +.BR \-\-show .
> 
> s/none are/none is/
> because at most one may be given.

But there are multiple choices and 'none' is plural.
"If it is not given" is singular, but there are multiple choices.
"If one is not given" would work. I like it the way it is.

> 
>> -.B hwclock
>> +.B \%hwclock
> 
> What does \% do?  Why is it not used fully everywhere where
> .B hwclock occurs?


It is a soft hyphen. It should be used to prevent troff from
hyphenating commands, command strings, variable names, and
paths. When they appear in TP or TQ macros, or are otherwise
at that left margin, it is not necessary. It is probably a good
habit to just use them everywhere though. Except, never use it 
in the NAME section, the source format there is critical for
the whatis database. If I missed any it was an error on my part.
Looks like I missed the @ADJTIME_PATH@ macros too.

To see the difference it makes view the previous version with

MANWIDTH=40 man ./sys-utils/hwclock.8

You can try using various widths to hit different word hyphenations.

> 
>> [...]
> 
> Too much text to review.  :|
> 
> For such a huge change, it would have been nice to keep the
> formatting changes and text changes in separate patches.

I know Benno, I am sorry about that. I apologized for it in the
cover letter. I need to do better at remembering to make regular 
commits.

Somewhat in my defense, I attempted to comply with this rule when
I submitted a patch focused on string formatting (line-breaks) and 
was promptly hauled on the carpet for it. I am trying to learn the
the ropes here... hopefully sooner rather than later!

Speaking of the translation stuff, I have a question for you. First,
I admit my ignorance when it comes to the translation process. One of
these days I make the time to read about gettext; the documentation
seems quite lengthy. So, what I do not understand is why translation
software would flag a text line for changes in whitespace, punctuation,
formatting structure like line-breaks, or non-printing characters. I 
understand punctuation can change the meaning, but it seems unlikely that
it would impact the translation, assuming the translator parsed out the 
intended meaning the first time.


> 
> Benno
> 

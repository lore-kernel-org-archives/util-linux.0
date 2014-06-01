Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
Date: Mon, 2 Jun 2014 00:35:39 +0200
Cc: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@justemail.net>,
        "Util-Linux" <util-linux@vger.kernel.org>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi> <201405291223.40734.sweet_f_a@gmx.de> <CAG27Bk02R6UE4qqws=KOh5YKZ+hZJUyM1i8Z2dZ0h65a5Bpu2A@mail.gmail.com>
In-Reply-To: <CAG27Bk02R6UE4qqws=KOh5YKZ+hZJUyM1i8Z2dZ0h65a5Bpu2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201406020035.40358.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Friday 30 May 2014, Sami Kerola wrote:
> On 29 May 2014 11:23, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > On Thursday 29 May 2014, Sami Kerola wrote:
> >> On 27 May 2014 15:46, Karel Zak <kzak@redhat.com> wrote:
> >> > On Mon, May 26, 2014 at 04:46:12PM +0100, Sami Kerola wrote:
> >> >> git://github.com/kerolasa/lelux-utiliteetit.git rename
> >> >
> >> >  Not merged, it seems that the tests still uses the current
> >> > directory rather than $TS_OUTDIR, right?
> >>
> >> Oh, that's a beginner mistake. Fix is available in same git remote
> >> location. All I did was a cd before file operations in each
> >> script, something like this:
> >>
> >> +++ b/tests/ts/rename/basic
> >> @@ -22,6 +22,7 @@ TS_DESC="basic check"
> >>  ts_init "$*"
> >>
> >>  ts_check_test_command "$TS_CMD_RENAME"
> >> +cd $TS_OUTDIR
> >
> > I know we are doing similar already in other tests too. IMO cd in
> > scripts can be very dangerous, specially if there is no error
> > handling.
> >
> > For example if ts_init is broken (while you are working on it) and
> > TS_OUTDIR would be unset then "cd $TS_OUTDIR" would jump into your
> > $HOME ... which could be really bad.
> >
> > At least I would quote it
> >   cd "$TS_OUTDIR"
> > or even better
> >   cd "$TS_OUTDIR" || exit 1
>
> Hi Rudi,
>
> Good point. I changed my git to have the better change dir you
> proposed.

BTW I just noticed that bash's
$ cd ''
does NOT return error. But
$ /usr/bin/cd ''
does like it should IMO.

> What would you think adding exit on error[1], disallow referrals to
> unset variables[2], and make any errors in pipe chains to cause exit
> on error to blow up[3], as default in ts_init()? I use in my own
> scripts these as default settings, and when I refactor scripts I tend
> to add these to make them more robust. Down side is that these
> settings often cause quite a bit changes, which would mean the change
> should not be considered before the release v2.25 is out.

I'am not fully convinced about this. It would require much review and 
code change of all tests and functions.

> [1] set -e && trap 'ts_failed "exit on error"' ERR
> [2] set -u
> [3] set -o pipefail

IMO "pipefail" and "-e" are very debatable. Sometimes I like pipefail 
but mostly not. Look for example something like this "do something with 
some files if we found one":
$ ls | grep "a-file-which-exists-sometimes" | xargs -r do_something

pipefail would mess up do_something's return value. And "-e" would even 
abort the script.

$ file_list=$(ls | grep "a-file-which-exists-sometimes")
would also fail with "-e". 

I'm even a bit unhappy that currently some tests have already "set -o 
pipefail". It may break certain functions sourced from 
tests/functions.sh. It's very hard to write global shell functions 
which would survive any shopt combination.

cu,
Rudi

Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:58179 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbaE2KXo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 May 2014 06:23:44 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
Date: Thu, 29 May 2014 12:23:40 +0200
Cc: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@justemail.net>,
        "Util-Linux" <util-linux@vger.kernel.org>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi> <20140527144601.GB385@x2.net.home> <CAG27Bk2FVPQgR8Qd-y3KfN9X9zs7w_jr1GiRqFGtdMjdZNk1Bw@mail.gmail.com>
In-Reply-To: <CAG27Bk2FVPQgR8Qd-y3KfN9X9zs7w_jr1GiRqFGtdMjdZNk1Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405291223.40734.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 29 May 2014, Sami Kerola wrote:
> On 27 May 2014 15:46, Karel Zak <kzak@redhat.com> wrote:
> > On Mon, May 26, 2014 at 04:46:12PM +0100, Sami Kerola wrote:
> >> git://github.com/kerolasa/lelux-utiliteetit.git rename
> >
> >  Not merged, it seems that the tests still uses the current directory
> >  rather than $TS_OUTDIR, right?
> 
> Oh, that's a beginner mistake. Fix is available in same git remote
> location. All I did was a cd before file operations in each script,
> something like this:
> 
> +++ b/tests/ts/rename/basic
> @@ -22,6 +22,7 @@ TS_DESC="basic check"
>  ts_init "$*"
> 
>  ts_check_test_command "$TS_CMD_RENAME"
> +cd $TS_OUTDIR
> 

I know we are doing similar already in other tests too. IMO cd in scripts can be very dangerous, specially if there is no error handling.

For example if ts_init is broken (while you are working on it) and TS_OUTDIR would be unset then "cd $TS_OUTDIR" would jump into your $HOME ... which could be really bad.

At least I would quote it
  cd "$TS_OUTDIR"
or even better
  cd "$TS_OUTDIR" || exit 1

cu,
Rudi

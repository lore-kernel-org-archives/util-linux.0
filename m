Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37936 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbbCKJ4m (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 Mar 2015 05:56:42 -0400
Received: by widex7 with SMTP id ex7so36695711wid.3
        for <util-linux@vger.kernel.org>; Wed, 11 Mar 2015 02:56:41 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAP-up9B=PYfQaYe6qi8bCYCkbPQJq3_3qoaHPxrki1_nF2J4_Q@mail.gmail.com>
References: <CAP-up9B=PYfQaYe6qi8bCYCkbPQJq3_3qoaHPxrki1_nF2J4_Q@mail.gmail.com>
Date: Wed, 11 Mar 2015 09:56:41 +0000
Message-ID: <CAG27Bk2-7N=dFfFYEnC2yudasyg1v3mLLQ6mN4uOFzOOLSAHdA@mail.gmail.com>
Subject: Re: logger --tag
From: Sami Kerola <kerolasa@iki.fi>
To: Rainer Gerhards <rgerhards@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10 March 2015 at 17:32, Rainer Gerhards <rgerhards@gmail.com> wrote:
> I have been working on some fixes to logger the past days (issues are
> available on github). While I am almost done with that,

Hi Rainer,

How I wish I would have contacted rsyslog maillist after first sweep of
major changes with logger.  Great job various issues are fixed but
pity they end up to release.  Sorry for the problems caused, there
are lessons to be learned;

1) add tests when making major changes

2) try to find people who know better and ask if they would have
time and interest to test Newer, Better, Improved, More Broken,
version of the software

> I just noticed a problem that seems to exist for rather long (at
> least it is present in 2.20):
>
> logger accepts spaces in the tag name, e.g.
>
> logger -t "tag with spaces" test
>
> This will lead to a tag "tag with spaces:" being written. Actually, in
> 2.20 this is a problem of syslog(3), which should not accept spaces.
>
> Spaces are invalid inside a tag value (rfc 3164, rfc5424 and
> traditional log socket format). The lead to misinterpretation. In the
> case of rsyslog, the problem is not easily visible to the casual
> observer, but can cause problems e.g. when writing logs to databases
> or other tabular frontends.
>
> When the new --rfc5424 option is used, a space inside the tag
> invalidates the message (5424 is strict in contrary to 3164).
>
> As the bug seems to be present for a long time, probably ever since, I
> am unsure how to handle that. Options are (among others):
>
> 1) be to be strict by default, and emit an error message if a space is
> contained inside a tag value. But that could potentially break
> existing scripts.
>
> 2) be strict if and only if --rfc5424 is selected, but keep lazy in
> all other cases
>
> 3) be strict if any rfc format is specified, but keep lazy in all other cases.
>
> 4) add a new option --strict (or whatever) and emit an error if it
> either --rfc3164, --rfc5424 *or* --strict is given (--strict would
> only affect system log socket format).
>
> Options 2 to 4 would not break existing scripts, as these are new 2.26
> options. I tend to option 4, which has the only downside that we still
> permit invalid format to the local log socket.
>
> What is the opinion here on this list?

The option 2 sounds good, but I'm worried existing use might still be
affected if the tag strictness is enforced immediately.  The logger is
after all using rfc5424 format as default when communicating with a
remote server.

How about adding a check, and a warning something like

warnx(_("invalid tag formats are not allowed after 2018, see man logger(1)"));

And of course there should be section in manual page telling what
characters are allowed in tags, is that isalnum() with "C" locale?  The
'after 2018' should also be clarified to mean first release in that
year.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

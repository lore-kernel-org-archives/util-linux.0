Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41372 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbbCKMDk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Mar 2015 08:03:40 -0400
Date: Wed, 11 Mar 2015 13:03:37 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Rainer Gerhards <rgerhards@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: logger --tag
Message-ID: <20150311120337.GG26473@ws.net.home>
References: <CAP-up9B=PYfQaYe6qi8bCYCkbPQJq3_3qoaHPxrki1_nF2J4_Q@mail.gmail.com>
 <CAG27Bk2-7N=dFfFYEnC2yudasyg1v3mLLQ6mN4uOFzOOLSAHdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2-7N=dFfFYEnC2yudasyg1v3mLLQ6mN4uOFzOOLSAHdA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 11, 2015 at 09:56:41AM +0000, Sami Kerola wrote:
> there are lessons to be learned;

Cool! :-)

> > Spaces are invalid inside a tag value (rfc 3164, rfc5424 and
> > traditional log socket format). The lead to misinterpretation. In the
> > case of rsyslog, the problem is not easily visible to the casual
> > observer, but can cause problems e.g. when writing logs to databases
> > or other tabular frontends.

in other words, it's always mistake to use space in tags.
...

> > 1) be to be strict by default, and emit an error message if a space is
> > contained inside a tag value. But that could potentially break
> > existing scripts.
> >
> > 2) be strict if and only if --rfc5424 is selected, but keep lazy in
> > all other cases
> >
> > 3) be strict if any rfc format is specified, but keep lazy in all other cases.
> >
> > 4) add a new option --strict (or whatever) and emit an error if it
> > either --rfc3164, --rfc5424 *or* --strict is given (--strict would
> > only affect system log socket format).
> >
> > Options 2 to 4 would not break existing scripts, as these are new 2.26
> > options. I tend to option 4, which has the only downside that we still
> > permit invalid format to the local log socket.
> >
> > What is the opinion here on this list?

I vote for 4) and describe the problem in man page and hightlight in
the man page that --strict is automatically enabled for all --rfc*
formats.

> How about adding a check, and a warning something like
> 
> warnx(_("invalid tag formats are not allowed after 2018, see man logger(1)"));

Frankly, I don't like when utils produce some extra warnings, it will
generate mess and many many warnings on systems where the space-in-tag 
is no problem and where all works as expected for years.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

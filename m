Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755105AbaLHLAa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Dec 2014 06:00:30 -0500
Date: Mon, 8 Dec 2014 12:00:21 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 01/10] lib/mbalign: fix unsigned integer overflow
 [AddressSanitizer]
Message-ID: <20141208110021.GB19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
 <1417355862-16935-2-git-send-email-kerolasa@iki.fi>
 <547FA265.6040806@draigBrady.com>
 <CAG27Bk0SOOXzB2aJC66AO2pBeicRYHAosmAsd5kdUx8W3meiCg@mail.gmail.com>
 <54844055.7030602@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <54844055.7030602@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 07, 2014 at 11:56:05AM +0000, Pádraig Brady wrote:
> On 04/12/14 20:14, Sami Kerola wrote:
> > On 3 December 2014 at 23:53, Pádraig Brady <P@draigbrady.com> wrote:
> >> On 30/11/14 13:57, Sami Kerola wrote:
> >>> This error was reported 155 times.
> >>>
> >>> lib/mbsalign.c:322:18: runtime error: unsigned integer overflow: 0 - 1
> >>> cannot be represented in type 'size_t' (aka 'unsigned long')
> >>
> >> What compiler and version are you using for this?
> >> I don't get the error with gcc 4.9.2 with -fsanitize=undefined
> >> Note the error is incorrect I think as the variable is not read
> >> after the overflow.
> > 
> > Hi Pádraig,
> > 
> > Sorry it took ages to reply to a trivial question.
> > 
> > $ clang --version
> > clang version 3.5.0 (tags/RELEASE_350/final)
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> > 
> > I have not done sanitation runs with gcc.
> > 
> > The system is archlinux with testing repos enabled with daily updates,
> > that should mean a lot of libraries and such are fairly recent.
> 
> Thanks for the info.
> BTW I don't see it with clang 3.4.2.
> This seems like a too problematic warning TBH,
> as unsigned overflow is defined,
> the overflow value is not used in this case,
> this seems like a very common idiom.

 Yes, the question is if this is a good idiom ;-) IMHO it would be
 better to have robust and more explicit code where unsigned numbers
 never overflow. You're right the code is correct for now, but maybe
 one day someone will edit the code and introduce unexpected bug with
 unsigned...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

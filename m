Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130514104504.GF18123@x2.net.home>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
	<1367520701-14962-14-git-send-email-kerolasa@iki.fi>
	<20130514104504.GF18123@x2.net.home>
Date: Tue, 21 May 2013 21:34:39 +0100
Message-ID: <CAG27Bk00BAopjTyKRUcZh_JMP9q2uyVyewV_0BDWr7f8k4bqOA@mail.gmail.com>
Subject: Re: [PATCH 13/16] cal: stop trimming whitespaces
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 14 May 2013 11:45, Karel Zak <kzak@redhat.com> wrote:
> On Thu, May 02, 2013 at 07:51:38PM +0100, Sami Kerola wrote:
>> Remove trailing spaces from output it is trivial
>
> and introduce a regression and ugly output, see "cal -3":

[d'oh]

> I guess we have regression test just to check for regressions.

Fixed here.

https://github.com/kerolasa/lelux-utiliteetit/commit/a0a150f8c14ac6b62483d03ec446f07e751903bf#L0L564

As all can see removal of couple white spaces removed regression.

I also dropped the global variables patch (earlier nr 14) from the
fourth branch. There are no other changes in 'cal-fourth' branch.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/

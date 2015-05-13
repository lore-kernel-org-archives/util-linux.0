Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] libfdisk: (gpt) fix attributes endianess
Date: Wed, 13 May 2015 11:58:05 +0200
Cc: util-linux@vger.kernel.org, Michael Marineau <michael.marineau@coreos.com>
References: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de> <201505120847.40612.sweet_f_a@gmx.de> <20150513091700.GC4834@ws.net.home>
In-Reply-To: <20150513091700.GC4834@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201505131158.06032.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 13 May 2015, Karel Zak wrote:
> On Tue, May 12, 2015 at 08:47:40AM +0200, Ruediger Meier wrote:
> > On Monday 11 May 2015, Karel Zak wrote:
> > > On Fri, May 08, 2015 at 01:39:53PM +0200, Ruediger Meier wrote:
> > > > The new libfdisk/gpt test (4a4a0927) discovered that we read
> > > > and write partition attributes wrongly on BE systems.
> > >
> > > It was pretty hidden bug (as the problem was in the both set/get
> > > functions).
> >
> > BTW maybe we could add the new raw attributes interface to sfdisk
> > too. Like
> > $ ./sfdisk --part-attrs img 1 "0x0000000000000001"
> > (and also for stdin text input)
> >
> > This would make sfdisk forward compatible (in case they invent new
> > attributes) and we could remove test_fdisk_gpt helper again.
>
>  Send patch :-)

Ok, but still two questions.

1.
Like the example above I'd like to simply interprete hex numbers as 
bitsets. But because of strtol() hex numbers are working already now. 
This does the same:
$ ./sfdisk --part-attrs img 1 "56"
$ ./sfdisk --part-attrs img 1 "0x38"

I guess nobody ever used hexnumbers for GUID so far but the dumps from 
the future sfdisk would behave strange with sfdisk-2.26. So should we 
use a new prefix "bitset:0x..." or "raw:0x..."? 

2.
Rather than suporting whole bitsets only we could simply allow "any bit" 
to let this just work:
$ ./sfdisk --part-attrs img 1 "23"
unsupported GPT attribute bit '23'

cu,
Rudi

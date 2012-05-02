Return-Path: dave@gnu.org
Subject: Re: [PATCH] fdisk: isolate dos label logic
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120502084711.GA24055@x2.net.home>
References: <1335650565.2545.5.camel@offbook>
	 <20120502084711.GA24055@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 May 2012 10:56:42 +0200
Message-ID: <1335949002.2734.8.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-05-02 at 10:47 +0200, Karel Zak wrote:
> On Sun, Apr 29, 2012 at 12:02:45AM +0200, Davidlohr Bueso wrote:
> >  fdisk/Makefile.am     |    2 +
> >  fdisk/fdisk.c         |  420 +------------------------------------------------
> >  fdisk/fdisk.h         |   64 ++++++++-
> >  fdisk/fdiskdoslabel.c |  323 +++++++++++++++++++++++++++++++++++++
> >  fdisk/fdiskdoslabel.h |   50 ++++++
> >  5 files changed, 446 insertions(+), 413 deletions(-)
> >  create mode 100644 fdisk/fdiskdoslabel.c
> >  create mode 100644 fdisk/fdiskdoslabel.h
> 
>  Applied, but I guess it's the first step only -- for example
>  new_partition(), add_partition(), ... still contain DOS label code.
>  It would be nice to completely move the code to fdiskdoslabel.c
>  before we start to work on the new internal API.

Yes, absolutely. This patch was ugly enough that I didn't want to
complicate it any further :) I plan on getting rid of the rest of DOS
code in fdisk.c soon.

> 
>  Thanks!
> 
>     Karel
> 
> 

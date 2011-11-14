Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx11-mx.siemens-enterprise.com ([62.134.46.9]:60523 "EHLO
	senmx11-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752723Ab1KNJIU convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 04:08:20 -0500
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Davidlohr Bueso <dave@gnu.org>,
        Bernhard Voelker <mail@bernhard-voelker.de>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Mon, 14 Nov 2011 10:08:17 +0100
Subject: RE: [PATCH 10/15] prlimit: refactor code: separate modify and
	showclearly
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D86D86A9B@MCHP058A.global-ad.net>
References: <4EC07375.20005@bernhard-voelker.de>
 <1321268061.8015.3.camel@offworld>
In-Reply-To: <1321268061.8015.3.camel@offworld>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:

> On Mon, 2011-11-14 at 02:48 +0100, Bernhard Voelker wrote:
> > [PATCH 10/15] prlimit: refactor code: separate modify and show clearly
> > 
> > Struct prlimit now has a flag whether a limit has to be modified,
> > and a flag whether the limit has to be shown; names "modify" and
> > "show". Furthermore, move show_limits() to main().
> > 
> > Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
> > ---
> >   sys-utils/prlimit.c |   37 +++++++++++++++++++------------------
> >   1 files changed, 19 insertions(+), 18 deletions(-)
> > 
> > diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
> > index 4124faa..fc11a94 100644
> > --- a/sys-utils/prlimit.c
> > +++ b/sys-utils/prlimit.c
> > @@ -85,12 +85,12 @@ static struct prlimit_desc prlimit_desc[] =
> > 
> >   struct prlimit {
> >   	struct rlimit rlim;
> > -	int found;
> 
> Wait, doesn't patch 07 add this variable?

well, actually yes ... but effectively (to not break the order
in PRLIMIT_EMPTY_LIMIT), I decided to rename-and-move that
variable:

> >   	struct prlimit_desc *desc;
> >   	int modify;
> > +	int show;
> >   };
> > 
> > -#define PRLIMIT_EMPTY_LIMIT	{{ 0, 0, }, NULL, 0 }
> > +#define PRLIMIT_EMPTY_LIMIT	{{ 0, 0, }, NULL, 0, 0 }

Bye,
Berny
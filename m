Return-Path: dave@gnu.org
Subject: Re: [PATCH 2/2] fdisk: API: comment labels array
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120724124945.GM736@x2.net.home>
References: <1343133630.2686.16.camel@offbook>
	 <20120724124945.GM736@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Jul 2012 14:57:17 +0200
Message-ID: <1343134637.2686.19.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-07-24 at 14:49 +0200, Karel Zak wrote:
> On Tue, Jul 24, 2012 at 02:40:30PM +0200, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> >  fdisks/utils.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/fdisks/utils.c b/fdisks/utils.c
> > index 8de64c2..c4ffe04 100644
> > --- a/fdisks/utils.c
> > +++ b/fdisks/utils.c
> > @@ -35,7 +35,9 @@
> >  int fdisk_debug_mask;
> >  
> >  /*
> > - * label probing functions
> > + * Label probing functions.
> > + * Must have the same order as fdisk_labeltype as the index
> > + * depends on it.
> 
> This (rely on comment) is bad way.
> 
> >   */
> >  static const struct fdisk_label *labels[] =
> >  {
> 
> Use:
> 
>  static const struct fdisk_label[] =
>  {
>     [XXX_LABEL] = &xxx_label,
>     [YYY_LABEL] = &yyy_label
>  }
> 

Yes, this is how we normally do it, but since we have an offset of 1 to
the index, it looks weired. I guess we need to straighten out
fdisk_labeltype and fix the menu along with it.

>     Karel
> 

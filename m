Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:51064 "EHLO
	homiemail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754274Ab2EFTFO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 May 2012 15:05:14 -0400
Subject: Re: [PATCH 5/5] fdisk: sgi: abort on HDIO_GETGEO failure
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120506181700.GC6429@skipper.site>
References: <1336306225.2685.14.camel@offbook>
	 <20120506181700.GC6429@skipper.site>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 May 2012 21:05:11 +0200
Message-ID: <1336331111.2685.22.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 2012-05-06 at 20:17 +0200, Petr Uzel wrote:
> On Sun, May 06, 2012 at 02:10:25PM +0200, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > When the HDIO_GETGEO ioctl fails on non IRIX/MIPS platforms (ie:
> > inappropriate ioctl for device) the variables that describe the
> > geometry are compromissed. One clear example is a division by 0 bug
> > because the cylinder size is 0 is verify_sgi():
> 
> I agree with the change, however I think that more descriptive error
> message should be printed; see below.
> 
> > 
> > $> fdisk sgi.img
> > Welcome to fdisk (util-linux 2.21.392-4b1c).
> > 
> > ...
> > 
> > Command (m for help): x
> > 
> > Expert command (m for help): g
> > Building a new SGI disklabel.
> > Partition 11 of type SGI volume and of size 7.9 MiB is set
> > Floating point exception
> > 
> > Fix this by simply exiting the program instead of leaving it in a vulnerable state.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> >  fdisk/fdisksgilabel.c |   39 ++++++++++++++++++++-------------------
> >  1 files changed, 20 insertions(+), 19 deletions(-)
> > 
> > diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
> > index 822f55d..b61f102 100644
> > --- a/fdisk/fdisksgilabel.c
> > +++ b/fdisk/fdisksgilabel.c
> > @@ -705,25 +705,26 @@ create_sgilabel(void)
> >  	res = blkdev_get_sectors(fd, &llsectors);
> >  
> >  #ifdef HDIO_GETGEO
> > -	if (!ioctl(fd, HDIO_GETGEO, &geometry)) {
> > -		heads = geometry.heads;
> > -		sectors = geometry.sectors;
> > -		if (res == 0) {
> > -			/* the get device size ioctl was successful */
> > -			unsigned long long llcyls;
> > -			llcyls = llsectors / (heads * sectors * sec_fac);
> > -			cylinders = llcyls;
> > -			if (cylinders != llcyls)	/* truncated? */
> > -				cylinders = ~0;
> > -		} else {
> > -			/* otherwise print error and use truncated version */
> > -			cylinders = geometry.cylinders;
> > -			fprintf(stderr,
> > -				_("Warning:  BLKGETSIZE ioctl failed on %s.  "
> > -				  "Using geometry cylinder value of %d.\n"
> > -				  "This value may be truncated for devices"
> > -				  " > 33.8 GB.\n"), disk_device, cylinders);
> > -		}
> > +	if (ioctl(fd, HDIO_GETGEO, &geometry) < 0)
> > +		err(EXIT_FAILURE, _("ioctl failed on %s"), disk_device);
> 
> s/"ioctl failed..."/"HDIO_GETGEO ioctl failed..."

I don't care either way - perhaps even a "cannot get geometry" message.
Karel, its up to you.

Thanks for looking into this patchet!

- Davidlohr

> 
> [SNIP]
> 
> Petr
> 
> --
> Petr Uzel
> IRC: ptr_uzl @ freenode



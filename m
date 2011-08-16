Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734Ab1HPPDi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2011 11:03:38 -0400
Date: Tue, 16 Aug 2011 17:03:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] partx: support loop devices
Message-ID: <20110816150333.GD14535@nb.net.home>
References: <1313381477.2509.1.camel@offbook> <20110815115855.GE1843@nb.net.home> <1313500807.2586.1.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313500807.2586.1.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 16, 2011 at 09:20:07AM -0400, Davidlohr Bueso wrote:
> On Mon, 2011-08-15 at 13:58 +0200, Karel Zak wrote:
> > On Mon, Aug 15, 2011 at 12:11:17AM -0400, Davidlohr Bueso wrote:
> > > @@ -800,14 +857,23 @@ int main(int argc, char **argv)
> > >  	if (what == ACT_ADD || what == ACT_DELETE) {
> > >  		struct stat x;
> > >  
> > > -		if (stat(wholedisk, &x) || !S_ISBLK(x.st_mode))
> > > -			errx(EXIT_FAILURE, _("%s: not a block device"), wholedisk);
> > > +		if (stat(wholedisk, &x) || !S_ISBLK(x.st_mode)) {
> > 
> >   && S_ISREG() :-)
> > 
> > > +			/* not a blkdev, try to associate it to a loop device */
> > 
> >             if (what == ACT_DELETE)
> >                 errx(EXIT_FAILURE, _("%s: cannot delete partitions"), wholedisk);
> > 
> > > +			if (!loopmod_supports_parts())
> > > +				errx(EXIT_FAILURE, _("%s: does not support loop device partitions"), 
> > > +				     wholedisk);
> > > +			assoc_loopdev(wholedisk);
> > > +			wholedisk = xstrdup(lc.device);
> > > +		}
> > >  	}
> > >  	if ((fd = open(wholedisk, O_RDONLY)) == -1)
> > >  		err(EXIT_FAILURE, _("%s: open failed"), wholedisk);
> > >  
> > > -	if (what == ACT_DELETE)
> > > +	if (what == ACT_DELETE) {
> > > +		if (loopdev)
> > > +			errx(EXIT_FAILURE, _("%s: cannot delete partitions"), wholedisk);
> > >  		rc = del_parts(fd, wholedisk, disk_devno, lower, upper);
> > > +	}
> > 
> >  Does it make sense to initialize loop device if ACT_DELETE is requested?
> 
> Ah, yes, good catch. Below is the corrected patch, do you think this
> feature could go into 2.20?

 2.21, for 2.20 is too late

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

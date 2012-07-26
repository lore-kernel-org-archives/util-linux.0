Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61283 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868Ab2GZKiY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 06:38:24 -0400
Date: Thu, 26 Jul 2012 12:38:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: John Lane <util-linux@jelmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk geometry
Message-ID: <20120726103819.GJ12592@x2.net.home>
References: <50109E8D.2000702@jelmail.com>
 <1343294980.2609.4.camel@offbook>
 <20120726095752.GD17589@x2.net.home>
 <1343298581.2609.8.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343298581.2609.8.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 26, 2012 at 12:29:41PM +0200, Davidlohr Bueso wrote:
> On Thu, 2012-07-26 at 11:57 +0200, Karel Zak wrote:
> > On Thu, Jul 26, 2012 at 11:29:40AM +0200, Davidlohr Bueso wrote:
> > > > (a) where fdisk gets the information about the geometry from in  this 
> > > > specific case?
> > > 
> > > fdisk gets the information from (i) user input, (ii) what the
> > > kernel/bios thinks the geometry is, with the HDIO_GETGEO ioctl and (iii)
> > > by inferring it from the partition table geometry.
> > 
> >  BTW, does it make any sense to read the geometry from partition table
> >  if the partition table has been aligned according to the device topology
> >  (for example 1MiB offset and grain)?
> 
> Hmm not really, no. In any case we got rid of the pt geometry,
> __discover_system_geometry() only gets the info from the kernel.

 I have moved get_partition_table_geometry() to dos_probe_label() :-)
 It seems we need if (dos_compatible) there.

 It means that for MBR we still read the PT geometry ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

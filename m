Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:35492 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751773Ab2GZK3p (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 06:29:45 -0400
Subject: Re: fdisk geometry
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: John Lane <util-linux@jelmail.com>, util-linux@vger.kernel.org
In-Reply-To: <20120726095752.GD17589@x2.net.home>
References: <50109E8D.2000702@jelmail.com> <1343294980.2609.4.camel@offbook>
	 <20120726095752.GD17589@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Jul 2012 12:29:41 +0200
Message-ID: <1343298581.2609.8.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-07-26 at 11:57 +0200, Karel Zak wrote:
> On Thu, Jul 26, 2012 at 11:29:40AM +0200, Davidlohr Bueso wrote:
> > > (a) where fdisk gets the information about the geometry from in  this 
> > > specific case?
> > 
> > fdisk gets the information from (i) user input, (ii) what the
> > kernel/bios thinks the geometry is, with the HDIO_GETGEO ioctl and (iii)
> > by inferring it from the partition table geometry.
> 
>  BTW, does it make any sense to read the geometry from partition table
>  if the partition table has been aligned according to the device topology
>  (for example 1MiB offset and grain)?

Hmm not really, no. In any case we got rid of the pt geometry,
__discover_system_geometry() only gets the info from the kernel.

> > > fdisk even bother displaying a geometry any more ? Doesn't it just serve 
> > > to confuse?
> 
>  IMHO for non-DOS compatible mode it would be better to ignore PT
>  geometry (read only info from kernel to have "some" values) and
>  don't display geometry in the default output, because it's completely
>  irrelevant.
> 
>  The same we can do with -S -C -H options -- it would be better to
>  print a warning if the options are specified for non-DOS mode.
> 

I agree.

>  I still see on many places suggestions like "use -S -H to align your
>  flash disk" or so... all this is legacy.
> 
>     Karel
> 



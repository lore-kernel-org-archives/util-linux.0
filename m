Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1706 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab2GZJ55 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 05:57:57 -0400
Date: Thu, 26 Jul 2012 11:57:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: John Lane <util-linux@jelmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk geometry
Message-ID: <20120726095752.GD17589@x2.net.home>
References: <50109E8D.2000702@jelmail.com>
 <1343294980.2609.4.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343294980.2609.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 26, 2012 at 11:29:40AM +0200, Davidlohr Bueso wrote:
> > (a) where fdisk gets the information about the geometry from in  this 
> > specific case?
> 
> fdisk gets the information from (i) user input, (ii) what the
> kernel/bios thinks the geometry is, with the HDIO_GETGEO ioctl and (iii)
> by inferring it from the partition table geometry.

 BTW, does it make any sense to read the geometry from partition table
 if the partition table has been aligned according to the device topology
 (for example 1MiB offset and grain)?

> > fdisk even bother displaying a geometry any more ? Doesn't it just serve 
> > to confuse?

 IMHO for non-DOS compatible mode it would be better to ignore PT
 geometry (read only info from kernel to have "some" values) and
 don't display geometry in the default output, because it's completely
 irrelevant.

 The same we can do with -S -C -H options -- it would be better to
 print a warning if the options are specified for non-DOS mode.

 I still see on many places suggestions like "use -S -H to align your
 flash disk" or so... all this is legacy.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

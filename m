Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10750 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab2DZHcn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Apr 2012 03:32:43 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3Q7Whoi000865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Apr 2012 03:32:43 -0400
Received: from x2 (ovpn-116-57.ams2.redhat.com [10.36.116.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q3Q7Wgnu013034
	for <util-linux@vger.kernel.org>; Thu, 26 Apr 2012 03:32:43 -0400
Date: Thu, 26 Apr 2012 09:32:41 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: findmnt: parsing mountpoints with spaces
Message-ID: <20120426073241.GA28346@x2.net.home>
References: <20120424144055.GB3813@magazyn-ziarno.zbozowa>
 <20120424175250.GC17370@x2.net.home>
 <20120424175505.GA5219@magazyn-ziarno.zbozowa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120424175505.GA5219@magazyn-ziarno.zbozowa>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 24, 2012 at 07:55:07PM +0200, Marcin Szewczyk wrote:
> On Tue, Apr 24, 2012 at 07:52:50PM +0200, Karel Zak wrote:
> > On Tue, Apr 24, 2012 at 04:40:55PM +0200, Marcin Szewczyk wrote:
> > > May I request a feature of escaping spaces and possibly other
> > > non-printable characters in a fstab manner (\040 for space)?
> > 
> >  Added to my TODO. Thanks.
> 
> Great. Thank You again.

Implemented, but it uses \x<hex> -- I think it's more readable and
also compatible with /dev/disk/by-* udev stuffl, latest DM, etc.

Maybe we can add something like --encode=hex|oct to specify wanted
encoding.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

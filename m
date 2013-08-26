Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f169.google.com ([209.85.216.169]:45158 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757101Ab3HZQwi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Aug 2013 12:52:38 -0400
Received: by mail-qc0-f169.google.com with SMTP id k8so788484qcq.0
        for <util-linux@vger.kernel.org>; Mon, 26 Aug 2013 09:52:37 -0700 (PDT)
Date: Mon, 26 Aug 2013 12:52:34 -0400
From: Dave Reisner <d@falconindy.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: building pylibmount when python -> python3
Message-ID: <20130826165234.GO699@rampage>
References: <20130826124730.GN699@rampage>
 <201308261243.52183.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201308261243.52183.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 26, 2013 at 12:43:51PM -0400, Mike Frysinger wrote:
> On Monday 26 August 2013 08:47:30 Dave Reisner wrote:
> > This came up in IRC and I thought it might be a good idea to mention it
> > to the list. With pylibmount recently being merged into git, some folks
> > might have trouble building from HEAD if their /usr/bin/python points to
> > a version python>=3.0. While the end goal (after discussion with Karel)
> > seems to be that we should be able to build this for both python2 and
> > python3, you can work around the build failure for now by simply passing
> > --with-python=/usr/bin/python2 (or --without-python if you don't care
> > for the new module).
> 
> that doesn't quite work due to logic in the configure script that rejects 
> anything other than "yes".  fixing that doesn't help as AM_PATH_PYTHON only 
> respects $PYTHON.  then you have to set it to the full path and not just 
> PYTHON=python2 because the configure script wants the full path (to run the 
> config script).  it's all pretty fragile atm.
> 
> i think the workaround is:
> 	$ PYTHON=/usr/bin/python2 ./configure
> (or point it at python2.7 if your distro installs a fuller version)
> -mike

Oops. I guess I should have checked the built package afterwards. Thanks
for the correction.

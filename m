Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19759 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360Ab2ATLaz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Jan 2012 06:30:55 -0500
Date: Fri, 20 Jan 2012 12:30:50 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Juergen Daubert <jue@jue.li>
Subject: Re: [ANNOUNCE] util-linux v2.21-rc1
Message-ID: <20120120113050.GB13157@x2.net.home>
References: <20120119092858.GC2371@x2.net.home>
 <20120120085828.GA11139@jue.netz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120120085828.GA11139@jue.netz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 20, 2012 at 09:58:28AM +0100, Juergen Daubert wrote:
> On Thu, Jan 19, 2012 at 10:28:58AM +0100, Karel Zak wrote:
> > 
> > The first util-linux 2.21 release candidate is available at
> > 
> 
> [...]
> 
> > findmnt(8):
> >    - supports alternative location of the fstab file
> >
> 
> This is a incompatible change that might break existing scripts.
> Currently it's possible to combine the -s option with other options
> like -snr, which leads to an error now. IMO it's not a good idea to 
> change existing program options in such a way.

 Good catch. Fixed, I have added a new option --tab-file <path>, the
 new option is usable with --fstab, --mtab and --kernel to overwrite
 the default paths, for example:

    findmnt --fstab --tab-file /etc/fstab.foo

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

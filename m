Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13058 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669Ab1HOJYy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Aug 2011 05:24:54 -0400
Date: Mon, 15 Aug 2011 11:24:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [patch 0/8] various lscpu patches
Message-ID: <20110815092450.GD1843@nb.net.home>
References: <20110810083645.135814950@de.ibm.com> <20110815084530.GA2400@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110815084530.GA2400@osiris.boeblingen.de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 15, 2011 at 10:45:30AM +0200, Heiko Carstens wrote:
> On Wed, Aug 10, 2011 at 10:36:45AM +0200, Heiko Carstens wrote:
> > Hi Karel,
> > 
> > here are a couple of fixes and improvemts for lscpu on s390.
> > Hopefully I didn't screw up anything ;)
> > At least on my Thinkpad everything still works as before and the output
> > on s390 machines is much improved.
> 
> FWIW, I set up a git branch with the lscpu changes:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/heiko/util-linux.git lscpu

 Looks good. Thanks. 
 
 I'm going to merge the changes after 2.20 release (~25th Aug).


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

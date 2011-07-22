Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28199 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab1GVJnH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Jul 2011 05:43:07 -0400
Date: Fri, 22 Jul 2011 11:43:04 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: ionice: requires scheduling since
	7ab08ba3e5e6f161b93ff2b3b7d5b18dc7b44510
Message-ID: <20110722094304.GQ22568@nb.net.home>
References: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3A66@MCHP058A.global-ad.net> <20110722085420.GP22568@nb.net.home> <7856072A9D04C24B82DFE2B1112FE38A08FE2D3AC2@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3AC2@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 22, 2011 at 10:57:28AM +0200, Voelker, Bernhard wrote:
> Karel Zak wrote:
> 
> > I'll improve the behavior:
> 
> great!
> 
> >  ionice                       : print the current I/O prio.
> >  ionice <COMMAND>             : exec command with default (best-effort) class
> >  ionice -p PID [...]          : return info about the PID(s)
> >  ionice -c CLASS COMMAND      : exec command with the class
> >  ionice -c CLASS -p PID [...] : modify PID(s) class
> >
> > Comments?

 Fixed.

 I've also added support for human readable class names, you can use:

   ionice -c best-effort /bin/foo


    Karel 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

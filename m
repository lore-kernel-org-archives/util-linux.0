Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29099 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731Ab1GVIyX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Jul 2011 04:54:23 -0400
Date: Fri, 22 Jul 2011 10:54:20 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: ionice: requires scheduling since
	7ab08ba3e5e6f161b93ff2b3b7d5b18dc7b44510
Message-ID: <20110722085420.GP22568@nb.net.home>
References: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3A66@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3A66@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 22, 2011 at 10:09:57AM +0200, Voelker, Bernhard wrote:
> Since 7ab08ba3e5e6f161b93ff2b3b7d5b18dc7b44510, ionice requires a "scheduling".
> 
>   $ schedutils/ionice 123
>   ionice: scheduling for the COMMAND not specified
> 
> As `ionice` is the sister of `nice`, I question why a certain prio/class is needed.
> What's wrong with not passing a certain prio/class?

 Good point, I'll fix it.

> Second, doesn't this break existing scripts which rely on "123" being executed?

 It has never been supported:

         $ ionice 123
         none: prio 4
         ionice: ioprio_get failed: No such process

 Unfortunately, the 123 has been always interpreted as PID, not as
 COMMAND. The another bug is that without -p the ioprio_get() has been
 called two times, the "none: prio 4" is for PID=0 ;-)

 I'll improve the behavior:

  ionice                       : print the current I/O prio.
  ionice <COMMAND>             : exec command with default (best-effort) class
  ionice -p PID [...]          : return info about the PID(s)
  ionice -c CLASS COMMAND      : exec command with the class
  ionice -c CLASS -p PID [...] : modify PID(s) class

Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

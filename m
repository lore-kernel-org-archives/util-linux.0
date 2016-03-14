Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:38409
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbcCNGnV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2016 02:43:21 -0400
Date: Mon, 14 Mar 2016 07:42:55 +0100
From: Andreas Henriksson <andreas@fatal.se>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] build: uuidd requires linux now, uses signalfd
Message-ID: <20160314064255.GA19644@fatal.se>
References: <1457891767-16753-1-git-send-email-andreas@fatal.se>
 <201603132145.44967.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603132145.44967.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Ruediger Meier.

On Sun, Mar 13, 2016 at 09:45:44PM +0100, Ruediger Meier wrote:
> On Sunday 13 March 2016, Andreas Henriksson wrote:
> > Specify that uuidd can only be built on Linux now since
> 
> Did you managed to build ipcs and ipcrm and do they work
> correctly? Which system have you tried?

No I have not. This was simply a reaction to the immediate problems
found in the build daemon logs after uploading 2.28-rc1 to
Debian Experimental, see
https://buildd.debian.org/status/package.php?p=util-linux&suite=experimental

It's possible additional fixes are needed. I don't run non-Linux myself.

Regards,
Andreas Henriksson

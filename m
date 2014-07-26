Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:53308 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaGZU0R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 16:26:17 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id BAB2EEC007
	for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 22:26:15 +0200 (CEST)
Date: Sat, 26 Jul 2014 22:26:13 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] buildsys: make tailf linux-only (needs inotify)
Message-ID: <20140726202613.GA4826@fatal.se>
References: <1406394071-1499-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406394071-1499-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello all!

On Sat, Jul 26, 2014 at 07:01:11PM +0200, Andreas Henriksson wrote:
> While tailf builds fine on other architectures, it relies
> on inotify to work properly. So for example on
[...]

Please ignore this! I was to quick to judge. The program
has non-inotify fallback code which does work... this is
likely just a problem in the testsuite.
I'll follow up shortly.

Regards,
Andreas Henriksson

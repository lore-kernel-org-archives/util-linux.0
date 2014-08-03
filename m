Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:34834 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaHCUXN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 16:23:13 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 0D0DA46093
	for <util-linux@vger.kernel.org>; Sun,  3 Aug 2014 22:23:10 +0200 (CEST)
Date: Sun, 3 Aug 2014 22:23:09 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Mike Frysinger <vapier@gentoo.org>, YunQiang Su <wzssyqa@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount/buildsys: move SELINUX_LIBS to LDFLAGS
Message-ID: <20140803202309.GA26295@fatal.se>
References: <1407010261-17305-1-git-send-email-andreas@fatal.se>
 <2625005.WTIbfJcupg@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2625005.WTIbfJcupg@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Mike Frysinger!

On Sun, Aug 03, 2014 at 09:34:25AM -0400, Mike Frysinger wrote:
[...]
> please post the full details here. 

I have no more details then those found in
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=721431

Maybe YunQiang Su can help out and provide some additional information
here....

> linkage (like -lselinux) are not ldflags.

Works for me, but likely I got LIBADD/LDFLAGS/LDADD wrong (again).

Regards,
Andreas Henriksson

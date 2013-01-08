Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13887 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756442Ab3AHOoP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Jan 2013 09:44:15 -0500
Date: Tue, 8 Jan 2013 15:43:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Move struct chardata and init_chardata to ttyutils
Message-ID: <20130108144329.GF18204@x2.net.home>
References: <20121219132917.GA26228@boole.suse.de>
 <1355927321-31673-1-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355927321-31673-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 19, 2012 at 03:28:41PM +0100, Werner Fink wrote:
> this one moves the struct chardata and init_chardata to include/ttyutils.h
> as well as to lib/include/ttyutils.c.  Also the macros CTL/CTRL are fixed
> in agetty.c and sulogin.c to use the XOR variant CTL.

 Merged, I have replaced the global variable with INIT_CHARDATA macro.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

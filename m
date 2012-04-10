Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756626Ab2DJKer (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Apr 2012 06:34:47 -0400
Date: Tue, 10 Apr 2012 12:34:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] sfdisk: fix calculation due to type mismatch (ix86)
Message-ID: <20120410103422.GJ19784@x2.net.home>
References: <1333723993-11424-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333723993-11424-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 06, 2012 at 04:53:13PM +0200, Petr Uzel wrote:
> Addresses: https://bugzilla.novell.com/show_bug.cgi?id=754789
> Reported-by: Dan Mares <dan.mares@norcrossgroup.com>
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>

 Ah.. pretty dirty bug. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53820 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471AbcBPOtU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Feb 2016 09:49:20 -0500
Date: Tue, 16 Feb 2016 15:49:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: add test for loop option in fstab
Message-ID: <20160216144918.iqmvz27qggxfnjng@ws.net.home>
References: <56BCE4F4.6020409@suse.cz>
 <201602151242.10369.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201602151242.10369.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 15, 2016 at 12:42:10PM +0100, Ruediger Meier wrote:
> On Thursday 11 February 2016, Stanislav Brabec wrote:
> > Add a new fstab tests which check loop mount of the same source
> > multiple times in multiple steps.
> 
> This test still fails if /etc/mtab is a regular file. 

The problem should be fixed now. Thanks!

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

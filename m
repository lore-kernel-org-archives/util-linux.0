Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53032 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbbEMJRD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 May 2015 05:17:03 -0400
Date: Wed, 13 May 2015 11:17:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Michael Marineau <michael.marineau@coreos.com>
Subject: Re: [PATCH] libfdisk: (gpt) fix attributes endianess
Message-ID: <20150513091700.GC4834@ws.net.home>
References: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de>
 <20150511102545.GM27969@ws.net.home>
 <201505120847.40612.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201505120847.40612.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 12, 2015 at 08:47:40AM +0200, Ruediger Meier wrote:
> On Monday 11 May 2015, Karel Zak wrote:
> > On Fri, May 08, 2015 at 01:39:53PM +0200, Ruediger Meier wrote:
> > > The new libfdisk/gpt test (4a4a0927) discovered that we read and
> > > write partition attributes wrongly on BE systems.
> >
> > It was pretty hidden bug (as the problem was in the both set/get
> > functions).
> 
> BTW maybe we could add the new raw attributes interface to sfdisk too. 
> Like
> $ ./sfdisk --part-attrs img 1 "0x0000000000000001"
> (and also for stdin text input)
> 
> This would make sfdisk forward compatible (in case they invent new 
> attributes) and we could remove test_fdisk_gpt helper again.

 Send patch :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

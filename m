Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbcDVJFw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Apr 2016 05:05:52 -0400
Date: Fri, 22 Apr 2016 11:05:50 +0200
From: Karel Zak <kzak@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] nsenter: fix ability to enter unprivileged containers
Message-ID: <20160422090550.krzkhn4itlij2zpm@ws.net.home>
References: <1460982392.2452.6.camel@HansenPartnership.com>
 <1460993854.7385.11.camel@HansenPartnership.com>
 <20160418171103.lcbrxvaldcyhemd3@ws.net.home>
 <1461000495.7385.18.camel@HansenPartnership.com>
 <87k2juu61i.fsf@x220.int.ebiederm.org>
 <1461013000.7385.28.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461013000.7385.28.camel@HansenPartnership.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 18, 2016 at 04:56:40PM -0400, James Bottomley wrote:
> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
> index d8690db..8dbd22b 100644
> --- a/sys-utils/nsenter.c
> +++ b/sys-utils/nsenter.c

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

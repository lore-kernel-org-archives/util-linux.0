Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4776 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087AbaCDKv1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Mar 2014 05:51:27 -0500
Date: Tue, 4 Mar 2014 11:51:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: read_hypervisor_dmi: only fallback to memory scan
 on x86/x86_64
Message-ID: <20140304105123.GD2783@x2.net.home>
References: <1393907981-24298-1-git-send-email-stewart@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393907981-24298-1-git-send-email-stewart@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 04, 2014 at 03:39:41PM +1100, Stewart Smith wrote:
>  sys-utils/lscpu-dmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

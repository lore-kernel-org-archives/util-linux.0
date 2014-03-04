Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087AbaCDKup (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Mar 2014 05:50:45 -0500
Date: Tue, 4 Mar 2014 11:48:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: don't assume filesystem supports d_type when
 searching for NUMA nodes
Message-ID: <20140304104814.GC2783@x2.net.home>
References: <1393907247-23750-1-git-send-email-stewart@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393907247-23750-1-git-send-email-stewart@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 04, 2014 at 03:27:27PM +1100, Stewart Smith wrote:
>  sys-utils/lscpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Good catch! Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

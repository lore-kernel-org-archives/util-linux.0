Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13658 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab2CULiw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Mar 2012 07:38:52 -0400
Date: Wed, 21 Mar 2012 12:38:49 +0100
From: Karel Zak <kzak@redhat.com>
To: don <haodong@linux.vnet.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Mount: fix recursively propagation mounting
Message-ID: <20120321113849.GA30693@x2.net.home>
References: <4F699C44.70700@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F699C44.70700@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 21, 2012 at 05:15:48PM +0800, don wrote:
>  mount/mount.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

 Applied, thanks.

 I have also added MS_SILENT to the acceptable flags and fixed the new
 mount code in libmount.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

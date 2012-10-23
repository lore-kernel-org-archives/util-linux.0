Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558Ab2JWMQO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 23 Oct 2012 08:16:14 -0400
Date: Tue, 23 Oct 2012 14:16:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Venkatraman S <venkat@linaro.org>
Cc: util-linux@vger.kernel.org, arnd.bergmann@linaro.org
Subject: Re: [RFC PATCH 0/4] Adding useful information into swap partition
 header
Message-ID: <20121023121610.GI21724@x2.net.home>
References: <1350925048-31084-1-git-send-email-venkat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350925048-31084-1-git-send-email-venkat@linaro.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 22, 2012 at 10:27:23PM +0530, Venkatraman S wrote:
> Venkatraman S (4):
>   libblkid/topology: add preferred_erase_size to topology probe
>   mkswap: refactor header preparation
>   mkswap: Add additional fields in swapheader
>   mkswap: Probe and embed useful block device info into swapheader

 I don't see a problem to support additional information in the swap
 header, but our rule is pretty simple: first in Linus' tree, after
 that in userspace.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbcFNInv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2016 04:43:51 -0400
Date: Tue, 14 Jun 2016 10:43:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add drawer support
Message-ID: <20160614084349.bmut3xx3aorkievj@ws.net.home>
References: <1465888954-62716-1-git-send-email-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465888954-62716-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

On Tue, Jun 14, 2016 at 09:22:33AM +0200, Heiko Carstens wrote:
> the recent IBM z13 machines added yet another cpu topology level which
> is called 'drawer'. I'd like to have support for this within lscpu as
> well. The kernel patch that makes the new sysfs interfaces available
> will be merged during the next merge window. Therefore the first
> kernel release that contains the required interfaces will be v4.8.

maybe you can use tests/ts/lscpu/mk-input.sh to create a dump from 
/proc and /sys. Then we can test this new feature independently on 
HW and kernel.

> Please consider this patch for inclusion.

The patch seem good. I'll merge it before the next release. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

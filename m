Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756434AbdDRJYB (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
        Tue, 18 Apr 2017 05:24:01 -0400
Date: Tue, 18 Apr 2017 11:23:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: util-linux-ng@vger.kernel.org, leif.lindholm@linaro.org,
        agraf@suse.de
Subject: Re: [PATCH] lspcu: use sysfs for table access if available
Message-ID: <20170418092357.f4dl6p7ka5ekegm2@ws.net.home>
References: <20170412091129.27283-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170412091129.27283-1-ard.biesheuvel@linaro.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 12, 2017 at 10:11:29AM +0100, Ard Biesheuvel wrote:
>  sys-utils/lscpu-dmi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935667AbdCXKtv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Mar 2017 06:49:51 -0400
Date: Fri, 24 Mar 2017 11:49:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: prevent OOB access while probing HFS+
Message-ID: <20170324104946.rk37klrch32t5p42@ws.net.home>
References: <20170315211159.GA29768@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315211159.GA29768@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 15, 2017 at 10:12:00PM +0100, Tobias Stoeckmann wrote:
> -	if (be32_to_cpu(key->parent_id) != HFSPLUS_POR_CNID)
> +	if (be32_to_cpu(key->parent_id) != HFSPLUS_POR_CNID ||
> +	    be16_to_cpu(key->unicode_len > 255))

Typo. Fixed. I guess it should be 

    be16_to_cpu(key->unicode_len) > 255

Note than we have regression tests for almost all filesystems. So you 

 $ cd tests
 $ ./run.sh blkid

to see result.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

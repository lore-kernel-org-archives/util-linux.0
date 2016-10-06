Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbcJFNAX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Oct 2016 09:00:23 -0400
Date: Thu, 6 Oct 2016 15:00:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] losetup --nooverlap: fix typo
Message-ID: <20161006130021.bolauunzvvvzm2jb@ws.net.home>
References: <fdaaf809-fdbf-e6bf-01d6-caa96a089c0a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fdaaf809-fdbf-e6bf-01d6-caa96a089c0a@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 05, 2016 at 08:55:42PM +0200, Stanislav Brabec wrote:
> Option is documented and used as --nooverlap, bud coded as --nooverlaps.
> --nooverlap is considered as shortened option, making the typo
> invisible.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  sys-utils/losetup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

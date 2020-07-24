Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_C,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2231CC433DF
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A0A20674
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 16:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGXQM6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:12:58 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:34498
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGXQM6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 12:12:58 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jul 2020 12:12:57 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcuu-util-linux-ng-3@m.gmane-mx.org>)
        id 1jz0Em-000116-HV
        for util-linux@vger.kernel.org; Fri, 24 Jul 2020 18:07:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     util-linux@vger.kernel.org
From:   <nunojsilva@ist.utl.pt> (Nuno Silva)
Subject: Re: [PATCH 01/12] Manual pages: blockdev.8: Minor wording and formatting fixes
Date:   Fri, 24 Jul 2020 17:07:51 +0100
Message-ID: <rff10n$77s$1@ciao.gmane.io>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2020-07-24, Michael Kerrisk (man-pages) wrote:

> Signed-off-by: Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com>
> ---
>  disk-utils/blockdev.8 | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/disk-utils/blockdev.8 b/disk-utils/blockdev.8
> index 361e6aad7..44ed9e1e9 100644
> --- a/disk-utils/blockdev.8
> +++ b/disk-utils/blockdev.8
[...]
> @@ -44,8 +46,9 @@ Flush buffers.
>  .IP "\fB\-\-getalignoff\fP"
>  Get alignment offset.
>  .IP "\fB\-\-getbsz\fP"
> -Print blocksize in bytes.  This size does not describe device topology.  It's
> -size used internally by kernel and it maybe modified (for example) by
> +Print the blocksize in bytes.
> +This size does not describe device topology.  It's
> +the size used internally by ithe kernel and it may be modified (for example) by

Should that be "the", not "ithe"?

-- 
Nuno Silva


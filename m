Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00BDC433EF
	for <util-linux@archiver.kernel.org>; Thu,  6 Jan 2022 10:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiAFKsQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Jan 2022 05:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237909AbiAFKsP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Jan 2022 05:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641466094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ieU0kK3MNNf8/S1ZpXsmW/XMkLYcdYnzSAeWKYYWukM=;
        b=ekXzzlRRXSqqfOfC19Lc9966dXt4gjspibOrvlSRQgUk0uX8OStzufsF8HXc1SlWZ4Mqd3
        uyYFJoFco/w7JL7mLKVlQ0ueXP1+Hp09jSjO+1+y+3Sqk0/TWm+5UqMm/WfNVnhPcXoqEi
        EXPt9Mv7FqRA/Haybw5bNc5U7+fgfXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-ywe-uNfyPCmdJroIBK3nBg-1; Thu, 06 Jan 2022 05:48:11 -0500
X-MC-Unique: ywe-uNfyPCmdJroIBK3nBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60759193F560;
        Thu,  6 Jan 2022 10:48:10 +0000 (UTC)
Received: from ws.net.home (ovpn-112-15.ams2.redhat.com [10.36.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE69484A0C;
        Thu,  6 Jan 2022 10:48:09 +0000 (UTC)
Date:   Thu, 6 Jan 2022 11:48:06 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] losetup: restore -f/loopdev alternative
Message-ID: <20220106104806.hgqz5hcddmqb5ak4@ws.net.home>
References: <20220106100307.3543758-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106100307.3543758-1-steve@sk2.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jan 06, 2022 at 11:03:07AM +0100, Stephen Kitt wrote:
>  sys-utils/losetup.8.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
> index 2a2577f0d..52df95bd6 100644
> --- a/sys-utils/losetup.8.adoc
> +++ b/sys-utils/losetup.8.adoc
> @@ -30,7 +30,7 @@ Detach all associated loop devices:
>  
>  Set up a loop device:
>  
> -*losetup* [*-o* _offset_] [*--sizelimit* _size_] [*--sector-size* _size_] [*-Pr*] [*--show*] *-f* _loopdev file_
> +*losetup* [*-o* _offset_] [*--sizelimit* _size_] [*--sector-size* _size_] [*-Pr*] [*--show*] *-f*|_loopdev file_

Ah, I've just applied https://github.com/util-linux/util-linux/pull/1556
with the same issue.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


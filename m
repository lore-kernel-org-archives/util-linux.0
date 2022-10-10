Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B572C433FE
	for <util-linux@archiver.kernel.org>; Mon, 10 Oct 2022 13:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJJNHC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Oct 2022 09:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJJNHB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2022 09:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C911C00
        for <util-linux@vger.kernel.org>; Mon, 10 Oct 2022 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665407218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6H2KX1bjGM6LExoYuKuGEw/wrIVoKHeUTbevVkzss8=;
        b=Q/5B1GpLSqrGyFeRGGHMnripvSmPDQJisnWRin7/lKZMWQqpHlHvpuLlSZbLzNV6X7yc9g
        vuhwoEMAs7TKWhKsKAt5XfIza3mWIgsFBBVpJPlzmi9IfkJwNDODIt7Vfihi/koMywsXji
        ifCQyTi8oU9CoLDDPRgdDDatO5u5Cfc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-qfYjcG_UNHmrON7NzGJMmA-1; Mon, 10 Oct 2022 09:06:55 -0400
X-MC-Unique: qfYjcG_UNHmrON7NzGJMmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC0101C006A3;
        Mon, 10 Oct 2022 13:06:54 +0000 (UTC)
Received: from fedora (ovpn-195-46.brq.redhat.com [10.40.195.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE225112D402;
        Mon, 10 Oct 2022 13:06:53 +0000 (UTC)
Date:   Mon, 10 Oct 2022 15:06:51 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        djwong@kernel.org, liuzhiqiang26@huawei.com,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] disk-utils/fsck.c: Processes may kill other processes.
Message-ID: <20221010130651.qnwjg36v6n3h6zfg@fedora>
References: <f53df0ef-8474-6b0c-1a36-cf3e1282106c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53df0ef-8474-6b0c-1a36-cf3e1282106c@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Oct 10, 2022 at 05:41:17PM +0800, zhanchengbin wrote:
> A error in disk-utils/fsck.c, if run the fsck -N command, processes
> don't execute, just show what would be done. However, the pid whose
> value is -1 is added to the instance_list list in the execute
> function,if the kill_all function is called later, kill(-1, signum)
> is executed, Signals are sent to all processes except the number one
> process and itself. Other processes will be killed if they use the
> default signal processing function.

Looks good thanks.

> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
                               ^^^
Here as well, please remove my Sob and you can add

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks!
-Lukas

> ---
>  disk-utils/fsck.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
> index 505952c81..800d3ce08 100644
> --- a/disk-utils/fsck.c
> +++ b/disk-utils/fsck.c
> @@ -730,6 +730,8 @@ static int kill_all(int signum)
>      for (inst = instance_list; inst; inst = inst->next) {
>          if (inst->flags & FLAG_DONE)
>              continue;
> +        if (inst->pid <= 0)
> +            continue;
>          kill(inst->pid, signum);
>          n++;
>      }
> -- 
> 2.27.0
> 


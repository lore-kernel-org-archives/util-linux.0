Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B22C433FE
	for <util-linux@archiver.kernel.org>; Mon, 17 Oct 2022 07:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJQHOU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Oct 2022 03:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJQHOS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 17 Oct 2022 03:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E24AD6C
        for <util-linux@vger.kernel.org>; Mon, 17 Oct 2022 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665990857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjoS3AxuM5VS/0rzapM9FpdTGiBXAaHQ0YB+LhUZbOk=;
        b=MDnhbJoISNi9A7xGXdsOj3Z8nBF/LW9byLduTcjp9jRBrsa1ZD94fSUOU4n1GS/0qfNan2
        2keppI5YOwuNdF0wl94voeNOXpWg+N2UeV4k9Y7OwTWFohg1I3cTSWDl9ekowYlYm8A8W+
        MhB+hBuIx9Pp6EQcPNbl6aguYBdVZGA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-Jy4rX7jIMXGOgJjzrjDs-g-1; Mon, 17 Oct 2022 03:14:13 -0400
X-MC-Unique: Jy4rX7jIMXGOgJjzrjDs-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61EE938041C0;
        Mon, 17 Oct 2022 07:14:13 +0000 (UTC)
Received: from ws.net.home (ovpn-193-171.brq.redhat.com [10.40.193.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0162D414A815;
        Mon, 17 Oct 2022 07:14:11 +0000 (UTC)
Date:   Mon, 17 Oct 2022 09:14:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     zhanchengbin <zhanchengbin1@huawei.com>,
        util-linux@vger.kernel.org, djwong@kernel.org,
        liuzhiqiang26@huawei.com, linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] disk-utils/fsck.c: Processes may kill other processes.
Message-ID: <20221017071409.uhagyb62gobjmzec@ws.net.home>
References: <f53df0ef-8474-6b0c-1a36-cf3e1282106c@huawei.com>
 <20221010130651.qnwjg36v6n3h6zfg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010130651.qnwjg36v6n3h6zfg@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Oct 10, 2022 at 03:06:51PM +0200, Lukas Czerner wrote:
> On Mon, Oct 10, 2022 at 05:41:17PM +0800, zhanchengbin wrote:
> > A error in disk-utils/fsck.c, if run the fsck -N command, processes
> > don't execute, just show what would be done. However, the pid whose
> > value is -1 is added to the instance_list list in the execute
> > function,if the kill_all function is called later, kill(-1, signum)
> > is executed, Signals are sent to all processes except the number one
> > process and itself. Other processes will be killed if they use the
> > default signal processing function.
> 
> Looks good thanks.
> 
> > 
> > Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
>                                ^^^
> Here as well, please remove my Sob and you can add
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


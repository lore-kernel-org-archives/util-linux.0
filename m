Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB9BC7EE23
	for <util-linux@archiver.kernel.org>; Mon, 22 May 2023 14:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjEVO4k (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 May 2023 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEVO4j (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 May 2023 10:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B5FB9
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684767351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+R1HJ7uakZ4tCvCdWxRdM8ukb6EIL7sJzAj856LrGNI=;
        b=PSRnJY9gBSVrBHEBDKRqMPJeC0TaPTkdzPeG8R0hBbNP/ONzQvGcHVb0otjM1fE+Wd1fzt
        ko5Du7R4iaGBRns4eom/nLwJxhajO+JQcW+m0S65GuuYBwQoaDtftnQ7q3hOS2NUO8Iccf
        lL8eGMD7azar1IzFds7jqS4yQRsSq2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-h_l4Uy1nORugiVUsgmKacg-1; Mon, 22 May 2023 10:55:48 -0400
X-MC-Unique: h_l4Uy1nORugiVUsgmKacg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41C6C101A52C;
        Mon, 22 May 2023 14:55:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFB732166B25;
        Mon, 22 May 2023 14:55:47 +0000 (UTC)
Date:   Mon, 22 May 2023 16:55:45 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Thomas Deutschmann <whissi@whissi.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: util-linux 2.39 doesn't work with <linux-5.12: mount(2) system
 call failed: Function not implemented
Message-ID: <20230522145545.s5q3h4kefman36on@ws.net.home>
References: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
 <09636701-1136-4174-a453-5076ef0328f6@t-8ch.de>
 <03db6ada-02ee-48a1-a2dd-47335e70a681@whissi.de>
 <e2c624df-575b-4c66-a8b8-a5fc80a44b08@t-8ch.de>
 <089b028f-7ccb-5389-4ba0-06830f27e738@whissi.de>
 <a774f583-f985-4849-9b75-4fed59a47209@t-8ch.de>
 <d9b49d0a-c7eb-e110-ca71-e621df4a52cf@whissi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9b49d0a-c7eb-e110-ca71-e621df4a52cf@whissi.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 22, 2023 at 04:09:28PM +0200, Thomas Deutschmann wrote:
> Hi,
> 
> On 2023-05-22 09:43, Thomas Weißschuh wrote:
> > I was finally able to reproduce the issue.
> > 
> > Could you test https://github.com/util-linux/util-linux/pull/2248 again?
> 
> This fixes the issue for me, thank you!
> 
> Just one comment regarding the design of the fix:
> 
> Due to the introduction of mount_setattr_is_supported(), util-linux will now
> "waste" one syscall on every mount -- even on a modern system -- right?
> 
> A more "natural" approach like calling new API first but when this will fail
> with ENOSYS then fallback to old API (so we would only spend an additional
> call on old systems which is fine because we assume that their number will
> decrease over time) cannot be implemented due to the way how the hook system
> works, right?
> 
> But maybe this "wasted" call isn't much to think about. I was just wondering
> when I saw a call like
> 
>   mount_setattr(-1, NULL, 0, NULL, 0)
> 
> even on modern systems.


The problem is that the new API is not 1:1 with the old API. The new
API is more complex and requires open mount node/fs, preparing mount
options differently, more syscalls, etc. IMHO, it will be a
maintenance nightmare to use "if (ENOSYS) old_way()" for all use
cases.


Maybe it's not optimal for performance, but I have split libmount to
separate modules and legacy mount and new mount API are completely
separated. There is always a "prepare" stage when the module analyzes
the mount options, initializes resources (open_tree(), etc.) and if
the new API is unsuccessful (ENOSYS) in this sage, then it disables
the whole module, and the legacy module can detect it and start to
play its role.

The extra syscall (for remount in this case) is not a big problem (I
think).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCF7C433EF
	for <util-linux@archiver.kernel.org>; Tue, 19 Apr 2022 09:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348238AbiDSJvo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Apr 2022 05:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbiDSJvn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2022 05:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C75A7BE14
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2022 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650361740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQbeNMG1bdo7OZ4FiUPEXvp0rG9xAV8YjTOxKY5QM8M=;
        b=fpML72Gbu7hoD1r3C1shVQkNWQC5me6X77VN7BAn70RKDHMFSEkLuhN6HDzwdCgDRCsihM
        eIG7W78acvmT3KnRbv6AC78QSjlU34gEUqjk8Bh7MLsESZPpISkrk5J/J3CqriGXdzCPYZ
        Vf5uzVhJPeSy+nwwffbvFK2VMDQBJgc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-1NfNqlZIP0qkSWp0g0HPSw-1; Tue, 19 Apr 2022 05:48:57 -0400
X-MC-Unique: 1NfNqlZIP0qkSWp0g0HPSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A6201C05EBB;
        Tue, 19 Apr 2022 09:48:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3610C15E71;
        Tue, 19 Apr 2022 09:48:56 +0000 (UTC)
Date:   Tue, 19 Apr 2022 11:48:54 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Enze Li <lienze@kylinos.cn>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] eject: set CD-ROM speed to auto when xargs < 0
Message-ID: <20220419094854.3dfrojbfvrps7slg@ws.net.home>
References: <20220414094627.2924087-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414094627.2924087-1-lienze@kylinos.cn>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 14, 2022 at 05:46:27PM +0800, Enze Li wrote:
> when I execute the following command,
> $ ./eject -x -1 -v
> 
> I get this output info,
> eject: using default device `/dev/sr0'
> eject: device name is `/dev/sr0'
> eject: /dev/sr0: not mounted
> eject: /dev/sr0: is whole-disk device
> eject: setting CD-ROM speed to -1X
>                                ^^^

I have fixed this in a different way. 

https://github.com/util-linux/util-linux/commit/3b888573661d43ea069e98a083bd10e33a2ece69

The problem is that it uses ctl->x_arg = strtoul_or_err() -- so
non-negative number is expected, but strtoul_or_err() does not work in
this way ...

Now:

    # ./eject -x -1 -v
    eject: invalid argument to --cdspeed/-x option: '-1': Numerical result out of range


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C86C7EE2D
	for <util-linux@archiver.kernel.org>; Sun, 21 May 2023 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjEUS2w (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 21 May 2023 14:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjEUSXr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 21 May 2023 14:23:47 -0400
Received: from fifth.space (fifth.space [45.32.148.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9787EBD
        for <util-linux@vger.kernel.org>; Sun, 21 May 2023 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fifth.space; s=20190812;
        t=1684692940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2YpYuDSNDHYdC/SI3rXvRYfYyR21vbVjwyAS/nLJMA=;
        b=TFvmYicGQl2s6rdEQN/jcg1TzZB0FfqLh2xy+1kx8NIeooAmKeFgmrtOCnO8k0RGwEnXfn
        jCbwqO9+mDo1Tg163gb5F3fgUJP6mWylqFfX9cpOItZc/wQylVGCdfZX088ZlKyOmnmzaR
        aVc7DkWrL56kGVx25rR/gsrwNhvj7kbxk1b7qZNhWquU6iLQGJINhXuNgaTB6hFvYkr1w/
        ygKNvIHl8qJSgDChejCiXJ5N1lUl8EhqfXT5BOjfavF0V0uL7FDP5RQ4K+eCEWPdLajIz6
        pGdgU9uGUQ4Ty9Hetye30djp3A8seEzj02nFwDVyS3/wiJtMBtpW1XqkZhCKwA==
Received: by fifth.space (OpenSMTPD) with ESMTPSA id 75a804e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <util-linux@vger.kernel.org>;
        Sun, 21 May 2023 20:15:36 +0200 (CEST)
Date:   Sun, 21 May 2023 20:15:34 +0200
From:   Quentin Rameau <quinq@fifth.space>
To:     util-linux@vger.kernel.org
Subject: Re: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <20230521201534.62dadbc8.quinq@fifth.space>
In-Reply-To: <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
References: <20230521181814.0b0f2d38.quinq@fifth.space>
        <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

> Hi Quentin,

Hi Thomas,

> > I just updated util-linux to 2.39 from 2.38.1 (on Alpine Linux),
> > and new mount triggers an error for an old sshfs fstab mount entry,
> > that was working until now.
> > 
> > The line in question is:
> > 
> > user@host:path /media/ssh/path sshfs defaults,nosuid,nodev,noexec,noatime,noauto,_netdev,user,idmap=user,allow_other,rec 0 0
> > 
> > and fails with:
> > 
> > $ mount /media/ssh/path
> > fuse: unknown option(s): `-o defaults'
> 
> Could you try https://github.com/util-linux/util-linux/pull/2250 ?

This makes that problem go away indeed, thank you!

On a side-note, should that flag be applied to other generic parameters
too, like user(s) for example?

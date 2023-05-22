Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E277C77B73
	for <util-linux@archiver.kernel.org>; Mon, 22 May 2023 16:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjEVQ5G (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 May 2023 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjEVQ5F (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 May 2023 12:57:05 -0400
Received: from fifth.space (fifth.space [45.32.148.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7ACD
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fifth.space; s=20190812;
        t=1684774621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1u+tiPl69t5yf7NYsTCzvRiwSQN5vYKb0n/7kcd3fxs=;
        b=uYdCVNH0NbaWc8KReXDHHnl52UmVaG2IuMEZ1F/OmKiAeQ7vWKHlSo3Kt+/0WZkfCva6gW
        Q4wz/GbkEdC/N1l2wHMGw23lbnEuZGN1lfpSRipMMIxZQaDLmnrd+eN2J1LUWSvjNdWN7p
        RTcfQr5owNNUfafXOBtsrXOUP11CtRSSzasvsU960NUCS6ot6eQ63oEvJ2sc2KycAPt32e
        VapbX6rxmtxhaZIfUKF9oF7ZAOYL3l70DLQfJ4HsI+3a7Zx6DgyKpQVMP+V35Ox8CYWS8z
        O5QkLCyclghS+uGeHcozn9Qhhw1o0lr9paM8cgTmLw9MmAYDAOXSqMikjxvOmQ==
Received: by fifth.space (OpenSMTPD) with ESMTPSA id ee156325 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <util-linux@vger.kernel.org>;
        Mon, 22 May 2023 18:57:01 +0200 (CEST)
Date:   Mon, 22 May 2023 18:56:59 +0200
From:   Quentin Rameau <quinq@fifth.space>
To:     util-linux@vger.kernel.org
Subject: Re: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <20230522185659.486273e8.quinq@fifth.space>
In-Reply-To: <02247015-d693-4c22-96a6-d89ecad0c82e@t-8ch.de>
References: <20230521181814.0b0f2d38.quinq@fifth.space>
        <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
        <20230521201534.62dadbc8.quinq@fifth.space>
        <9c4d0dc2-de5b-4e34-9489-01e00a71e2da@t-8ch.de>
        <20230521212018.17829eb5.quinq@fifth.space>
        <02247015-d693-4c22-96a6-d89ecad0c82e@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Thomas,

> > > > On a side-note, should that flag be applied to other generic parameters
> > > > too, like user(s) for example?    
> > > 
> > > I guess they are useful for the helpers.
> > > 
> > > If the helpers were able to handle it before it should be fine.
> > > (They were passed in 2.38)
> > > 
> > > One could even argue that "defaults" should have been fine to be passed,
> > > but now it's a regression so needs to be fixed.  
> > 
> > One difference that I can see is that before, "user" was being passed
> > but now, "user=$user" is being passed (and that gives an error too)
> > 
> > With mount patched with the above patch, and "user" option in the fstab
> > 
> > $ mount /mnt/ssh/path
> > fusermount3: unknown option 'user=quinq
> > 
> > But maybe that should be a different thread, what do you think?  
> 
> I can't reproduce this.
> 
> Could you provide more traces?
> 
> Or maybe try to adapt tests/ts/mount/special in the util-linux source to
> test for it. That would make it easier to reproduce and fix.

Sorry I'm just seeing your message coming home now from work,
but it seems that Karel already made a fix for it!

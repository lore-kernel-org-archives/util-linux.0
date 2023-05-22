Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF5C77B73
	for <util-linux@archiver.kernel.org>; Mon, 22 May 2023 06:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEVG6m (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 May 2023 02:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjEVG6M (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 May 2023 02:58:12 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31A1BEE
        for <util-linux@vger.kernel.org>; Sun, 21 May 2023 23:55:57 -0700 (PDT)
Date:   Mon, 22 May 2023 08:55:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684738555; bh=pPBavBNqd5e1aVV+TvoHYLTOn92EFvu05fnoNADqYcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ova75mPks6+/WkXTujKSLAuj1ImuB8rDOIWdEjmdm71DzvyIM2YqrtI6svFxT1NN9
         OcF4NObaB8XiD3FXmf9KqFV+VS2PUu6mm2WiXC/T8FrcaMMskbjTSriWgo51IFy/gU
         6RRZE60hV74v8QDd2trVANdAWfn2+pxOT+xq8NpY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Quentin Rameau <quinq@fifth.space>
Cc:     util-linux@vger.kernel.org
Subject: Re: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <02247015-d693-4c22-96a6-d89ecad0c82e@t-8ch.de>
References: <20230521181814.0b0f2d38.quinq@fifth.space>
 <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
 <20230521201534.62dadbc8.quinq@fifth.space>
 <9c4d0dc2-de5b-4e34-9489-01e00a71e2da@t-8ch.de>
 <20230521212018.17829eb5.quinq@fifth.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521212018.17829eb5.quinq@fifth.space>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-05-21 21:20:18+0200, Quentin Rameau wrote:
> > > On a side-note, should that flag be applied to other generic parameters
> > > too, like user(s) for example?  
> > 
> > I guess they are useful for the helpers.
> > 
> > If the helpers were able to handle it before it should be fine.
> > (They were passed in 2.38)
> > 
> > One could even argue that "defaults" should have been fine to be passed,
> > but now it's a regression so needs to be fixed.
> 
> One difference that I can see is that before, "user" was being passed
> but now, "user=$user" is being passed (and that gives an error too)
> 
> With mount patched with the above patch, and "user" option in the fstab
> 
> $ mount /mnt/ssh/path
> fusermount3: unknown option 'user=quinq
> 
> But maybe that should be a different thread, what do you think?

I can't reproduce this.

Could you provide more traces?

Or maybe try to adapt tests/ts/mount/special in the util-linux source to
test for it. That would make it easier to reproduce and fix.

Thomas

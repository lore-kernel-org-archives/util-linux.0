Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804F5C77B73
	for <util-linux@archiver.kernel.org>; Sun, 21 May 2023 18:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjEUS6F (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 21 May 2023 14:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUS6E (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 21 May 2023 14:58:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856DBB6
        for <util-linux@vger.kernel.org>; Sun, 21 May 2023 11:58:03 -0700 (PDT)
Date:   Sun, 21 May 2023 20:58:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684695482; bh=MxbJ4XUXwdqR4Yl3g0+AWLfrXFIpx8xNNtdP79njWzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3Qv7maMV70hD3aaeX64RByNXFpHpLPXMBEOq0B04LxI2JmwU1Ek9SON2oSI5aKCB
         E/KiZZF9zqIYcUMCrVECLHmlM6Ra2cRQPjtCQDACbLsUiY7WOc57ac84g1YEoqp/JB
         nQBgJCkgTtbK0AS/VA2qrMYatMAHFvc0vinH/ZqQ=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Quentin Rameau <quinq@fifth.space>
Cc:     util-linux@vger.kernel.org
Subject: Re: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <9c4d0dc2-de5b-4e34-9489-01e00a71e2da@t-8ch.de>
References: <20230521181814.0b0f2d38.quinq@fifth.space>
 <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
 <20230521201534.62dadbc8.quinq@fifth.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521201534.62dadbc8.quinq@fifth.space>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-05-21 20:15:34+0200, Quentin Rameau wrote:
> > Hi Quentin,
> 
> Hi Thomas,
> 
> > > I just updated util-linux to 2.39 from 2.38.1 (on Alpine Linux),
> > > and new mount triggers an error for an old sshfs fstab mount entry,
> > > that was working until now.
> > > 
> > > The line in question is:
> > > 
> > > user@host:path /media/ssh/path sshfs defaults,nosuid,nodev,noexec,noatime,noauto,_netdev,user,idmap=user,allow_other,rec 0 0
> > > 
> > > and fails with:
> > > 
> > > $ mount /media/ssh/path
> > > fuse: unknown option(s): `-o defaults'
> > 
> > Could you try https://github.com/util-linux/util-linux/pull/2250 ?
> 
> This makes that problem go away indeed, thank you!

Great, you're welcome!

> On a side-note, should that flag be applied to other generic parameters
> too, like user(s) for example?

I guess they are useful for the helpers.

If the helpers were able to handle it before it should be fine.
(They were passed in 2.38)

One could even argue that "defaults" should have been fine to be passed,
but now it's a regression so needs to be fixed.

Thomas

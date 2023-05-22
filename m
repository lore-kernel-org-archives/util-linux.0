Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E8C77B73
	for <util-linux@archiver.kernel.org>; Mon, 22 May 2023 16:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjEVQzz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 May 2023 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEVQzx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 May 2023 12:55:53 -0400
Received: from fifth.space (fifth.space [45.32.148.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97544F1
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fifth.space; s=20190812;
        t=1684774542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3iCToO9Cjm4Gmygu+IAZRrg/ygM96MvsCWZou/fhiwQ=;
        b=wW3RMUzN2t1AFExGWXvyOuNInduMX0Ax8y8USs+QEq5GGnSh6AIlFASn/gwPwOEZmIjc9w
        FbwNTGJ5ql8ZiukzlDYtaMcFSqvUL/4Flkw6rUz0+lM5XmWBhpH0zLy0g3pqj/2NevmKqm
        Y+Xv0uaplgExn7TMqzuGNabGB4MsMaACiPxQP2fsgzhx/Li6bqEyDvCLoKx+bw+tkcLlW6
        bdDNERMjl3TTCb7ue6jTEGrAp13KygcyQsAQgSX6KI3LgiPmre+g1T3DM75q45Ot3tl0nk
        MBz9m4ZKFe6lvmBu7NCcxOtLBrX1+UoGvaFeZWrom/dx59wk1AWERspx+FHZeQ==
Received: by fifth.space (OpenSMTPD) with ESMTPSA id 5fcfbf99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <util-linux@vger.kernel.org>;
        Mon, 22 May 2023 18:55:37 +0200 (CEST)
Date:   Mon, 22 May 2023 18:55:33 +0200
From:   Quentin Rameau <quinq@fifth.space>
To:     util-linux@vger.kernel.org
Subject: Re: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <20230522185533.32c53480.quinq@fifth.space>
In-Reply-To: <20230522153340.7ljlnnzik3ulpmcr@ws.net.home>
References: <20230521181814.0b0f2d38.quinq@fifth.space>
        <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
        <20230521201534.62dadbc8.quinq@fifth.space>
        <9c4d0dc2-de5b-4e34-9489-01e00a71e2da@t-8ch.de>
        <20230521212018.17829eb5.quinq@fifth.space>
        <20230522142154.wv3ttxztq7zjmbyl@ws.net.home>
        <20230522153340.7ljlnnzik3ulpmcr@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,

> On Mon, May 22, 2023 at 04:21:54PM +0200, Karel Zak wrote:
> > On Sun, May 21, 2023 at 09:20:18PM +0200, Quentin Rameau wrote:
> > > > One could even argue that "defaults" should have been fine to be passed,
> > > > but now it's a regression so needs to be fixed.
> > > 
> > > One difference that I can see is that before, "user" was being passed
> > > but now, "user=$user" is being passed (and that gives an error too)
> > > 
> > > With mount patched with the above patch, and "user" option in the fstab
> > > 
> > > $ mount /mnt/ssh/path
> > > fusermount3: unknown option 'user=quinq
> > > 
> > > But maybe that should be a different thread, what do you think?
> > 
> > I'll fix it. You're right.
> 
> You need https://github.com/util-linux/util-linux/commit/fe0b1e793c9017edba72768e2e0b4c769c204604

I can confirm that this fixes that second problem indeed, thanks!

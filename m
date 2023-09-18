Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DD4C46CA1
	for <util-linux@archiver.kernel.org>; Mon, 18 Sep 2023 11:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjIRL3H (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Sep 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbjIRL27 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Sep 2023 07:28:59 -0400
X-Greylist: delayed 67741 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 04:25:38 PDT
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE8107
        for <util-linux@vger.kernel.org>; Mon, 18 Sep 2023 04:25:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 957F21C91;
        Mon, 18 Sep 2023 13:25:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3fbRp13NVW5e; Mon, 18 Sep 2023 13:25:34 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 42FEE7B7;
        Mon, 18 Sep 2023 13:25:34 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1qiCNh-00H1RL-1J;
        Mon, 18 Sep 2023 13:25:33 +0200
Date:   Mon, 18 Sep 2023 13:25:33 +0200
From:   Samuel Thibault <samuel.thibault@aquilenet.fr>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Fix non-Linux build
Message-ID: <20230918112533.uafpxkcei4odkfj6@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20230917163631.xcmdnwodz4wrcpyq@begin>
 <20230918111109.2b25gk3zixqdj7zt@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918111109.2b25gk3zixqdj7zt@ws.net.home>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel Zak, le lun. 18 sept. 2023 13:11:09 +0200, a ecrit:
> On Sun, Sep 17, 2023 at 06:36:31PM +0200, Samuel Thibault wrote:
> > --- a/libmount/src/hooks.c
> > +++ b/libmount/src/hooks.c
> > @@ -315,9 +315,11 @@ static int call_hook(struct libmnt_context *cxt, struct hookset_hook *hook)
> >  {
> >  	int rc = 0;
> >  
> > +#if LINUX
> >  	if (mnt_context_is_fake(cxt))
> >  		DBG(CXT, ul_debugobj(cxt, " FAKE call"));
> >  	else
> > +#endif
> >  		rc = hook->func(cxt, hook->hookset, hook->data);
> 
> It seems better to not use libmount/src/hooks.c on non-Linux systems.
> Fixed (but not tested:-).

That works, thanks!

Samuel

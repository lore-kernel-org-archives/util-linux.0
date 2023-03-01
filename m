Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CD8C64ED6
	for <util-linux@archiver.kernel.org>; Wed,  1 Mar 2023 14:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCAO0J (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCAO0I (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Mar 2023 09:26:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E2FCA17
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 06:26:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B61201FE15;
        Wed,  1 Mar 2023 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677680765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yvZJwaqXsLsf3TA9uMBPGI8P6dWTaEjwGhEsf4m6/9A=;
        b=LxJVLXh2rg5NefSwUU1hx7dNT19ebyUZUiMArLJge82mDL89muUEzy8kn+REIGBgRB4SDh
        MSfTPAPptlR9dTqsqBVlpf/pTvaGD9breMjaFl/rC6/QfRWiURODt6yJ7gH3DbMgJY3JzE
        FHrpttubDzIEsLmpHZddpy4aoGd4j6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677680765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yvZJwaqXsLsf3TA9uMBPGI8P6dWTaEjwGhEsf4m6/9A=;
        b=ELmjaphHOAZFfvDeTcbp/k4m+qcQaM4GROWBABIlHYC9dssNyDeaQAoqfHi2rYbDuNHFxR
        xP7KiaTdXmfR9SBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F6EA2C141;
        Wed,  1 Mar 2023 14:26:05 +0000 (UTC)
Date:   Wed, 1 Mar 2023 15:26:04 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: Move clock.txt to /run
Message-ID: <20230301142604.GA19419@kitsune.suse.cz>
References: <20230301140957.21604-1-msuchanek@suse.de>
 <20230301141747.jpbvk4aieq3pdehh@zeha.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141747.jpbvk4aieq3pdehh@zeha.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:47PM +0100, Chris Hofstaedtler wrote:
> * Michal Suchanek <msuchanek@suse.de> [230301 15:10]:
> > Moving the clock.txt to /run which is in tmpfs should resolve the
> > problem even for users not running uuidd.
> [..]
> >  
> > -#define LIBUUID_CLOCK_FILE	"/var/lib/libuuid/clock.txt"
> > +#define LIBUUID_CLOCK_FILE	"/run/libuuid/clock.txt"
> 
> Last time I asked about this file on this mailing list, I was
> informed that clock.txt is supposed to survive reboots.
> Moving it to /run (or any other tmpfs) would break this.

What's so valuable in it that it needs to survive?

I don't have it at all.

Also the code seems to re-synchronize with the real time clock from time
to time which makes the content relevant only for limited periods of
time.

Thanks

Michal

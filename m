Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF7C05027
	for <util-linux@archiver.kernel.org>; Sun, 19 Feb 2023 17:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjBSRBn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 19 Feb 2023 12:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjBSRBm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Feb 2023 12:01:42 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0721F1258B
        for <util-linux@vger.kernel.org>; Sun, 19 Feb 2023 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=seVGxMHWs4Ic2Z/eawlW50AF7D/MvEhEDpR24GQX5WQ=; b=Kkw8LOqt6FlsH99UADkezA0Lo8
        s2AGsX4Kib6MLdqyxcYr0GAtVWhERvYlRBGjhKslRDpc/wqgOmmA7V4CfuxpeZ2KuFyash4nmpJua
        M/kuvNN9cBYAJE+4NCTkzLy115ITXkeptYf5Wu0kXI7cXLYYs0udlD1rQgs6uYSah+mdfQtrpOpJR
        M09P/ilpCjSq3z0G8h60aCnL7f5+NBKcDzT7Jau/FHOm6YU27b5nZK8wwBV9A29wKFawpZQ5FrGP6
        /n7R/lApDhLHmgXtIxoHfqFTJMxbieR9l+/bcZivpMZxs7eTtTnVvGYtSFG5/tU11YOt+ikFQxoGA
        p7/F9Sfg==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <zeha@debian.org>)
        id 1pTn3u-006673-GQ; Sun, 19 Feb 2023 17:01:19 +0000
Date:   Sun, 19 Feb 2023 18:01:16 +0100
From:   Chris Hofstaedtler <zeha@debian.org>
To:     Michael Richardson <mcr@sandelman.ca>
Cc:     util-linux@vger.kernel.org
Subject: Re: uuid and RFC4122
Message-ID: <20230219170116.q453di5cmknxn665@zeha.at>
References: <14266.1676658860@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14266.1676658860@localhost>
X-Debian-User: zeha
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Michael,

* Michael Richardson <mcr@sandelman.ca>:
> Hi, thanks for your work on debian packages.
> I'm contacting you wearing my IETF uuidrev WG co-chair on.
> 
> The https://datatracker.ietf.org/wg/uuidrev/documents/ WG was chartered to
> update RFC4122 last summer, and we expect to start a WGLC on RFC4122bis in
> the next few weeks.  This is just a heads up for now.
> 
> Some comments, even they are just "Looks Good to Me" from the util-linux
> folks would be awesome.

Thanks for reaching out, but from the Debian side I think we have
little to comment on (mostly for lack of expertise).

I've CC:ed the upstream mailing list, in the hope that upstream
util-linux folks have comments.

Best,
Chris


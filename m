Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE8BC38145
	for <util-linux@archiver.kernel.org>; Wed,  7 Sep 2022 13:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIGNEu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Sep 2022 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIGNEs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Sep 2022 09:04:48 -0400
X-Greylist: delayed 428 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 06:04:47 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABA10AE56
        for <util-linux@vger.kernel.org>; Wed,  7 Sep 2022 06:04:46 -0700 (PDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1A7DA72C90B
        for <util-linux@vger.kernel.org>; Wed,  7 Sep 2022 15:57:37 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 0D2157CF87C; Wed,  7 Sep 2022 15:57:37 +0300 (MSK)
Date:   Wed, 7 Sep 2022 15:57:37 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/timeutils: Add %s (seconds since the Epoch) to
 parse_timestamp()
Message-ID: <20220907125736.GA17101@altlinux.org>
References: <20220906070436.684-1-peter.ujfalusi@linux.intel.com>
 <20220906084716.4bgsdahoyjfaaksc@ws.net.home>
 <849c4ca2-a1b7-7429-1b3c-fc135d9f4d72@linux.intel.com>
 <20220907072048.5buz33o2df5cvdiw@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220907072048.5buz33o2df5cvdiw@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Sep 07, 2022 at 09:20:48AM +0200, Karel Zak wrote:
> On Tue, Sep 06, 2022 at 07:31:07PM +0300, Péter Ujfalusi wrote:
> > On 06/09/2022 11:47, Karel Zak wrote:
> > > On Tue, Sep 06, 2022 at 10:04:36AM +0300, Peter Ujfalusi wrote:
> > >>  lib/timeutils.c | 8 ++++++++
> > >>  1 file changed, 8 insertions(+)
> > > 
> > > Applied, thanks.
> > 
> > After some tinkering with a script where I needed this, would it make
> > sense to change the way how one should be specifying seconds since the
> > Epoch time to
> > '@'<number>
> 
> Yes, '@' seems more readable. I have no strong opinion about it, maybe
> we can support both convention (with and without @).

I suggest supporting just @seconds, this would also match the behaviour of
date(1) and the gnulib module it uses:

$ date -u -d @1348331662
Sat Sep 22 16:34:22 UTC 2012


-- 
ldv

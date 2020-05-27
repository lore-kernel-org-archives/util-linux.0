Return-Path: <SRS0=vWqr=7J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71DC433E0
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 13:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D223208C3
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 13:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVVVfbj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725267AbgE0NME (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 May 2020 09:12:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58169 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730223AbgE0NME (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 May 2020 09:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590585123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q1NmiWcEpLcNJKL58hFHDK3V99J7NnkglO1VsRjKVGo=;
        b=ZVVVfbj2nbk9A8rl66maBwVTcDXJmJHraIKBZCaIpeVrRTXKD8S6Ng+dlyANBJDXEAfKKl
        L/jcJ+rotC3Irs6WrBAjwv3Y8t1+1rvfHJITTRFWx+tYa82l3IdE5yOkhR+iI5BBun301h
        UAvB/blQGdBqaTxxefPpPs9kZeTUi2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-puii399POj-pN1MSRDqjqg-1; Wed, 27 May 2020 09:11:59 -0400
X-MC-Unique: puii399POj-pN1MSRDqjqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2135F461;
        Wed, 27 May 2020 13:11:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 560E210013DB;
        Wed, 27 May 2020 13:11:57 +0000 (UTC)
Date:   Wed, 27 May 2020 15:11:54 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>
Subject: Re: util-linux-2.35.2 test failures
Message-ID: <20200527131154.p2rqxhcz6d56ik7m@ws.net.home>
References: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, May 26, 2020 at 05:34:13PM -0500, Bruce Dubbs wrote:
> I'm getting three test failures and hope I can get someone to help.
> 
> The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and ipcs/mk-rm-shm.
> 
> Concentrating on mk-rm-msg, I found on the system:
> 
> ./tests/output/ipcs/mk-rm-msg
> ./tests/ts/ipcs/mk-rm-msg
> ./tests/expected/ipcs/mk-rm-msg
> 
> The contents of the output and the expected files are identical:
> 
> Message queue id: <was_number>
> 1
> Message queue id: <was_number>
> 
> I am running the tests as a non-privileged user.
> 
> If I run the commands:
> 
> $ ipcmk -Q  (returns 24)
> $ ipcs -q -i 24
> $ ipcrm -q 24
> $ echo $?
> 0
> 
> Everything looks OK.  Does anyone have an idea why this test (these tests)
> are failing?

I had no time to play with it yet, but according to feedback from 
https://github.com/karelzak/util-linux/issues/1042 there is some kernel
regression:

 The ipcs tests are failing due to a regression in kernels 5.6.8
 through 5.6.13. Or mainline commits between
 89163f93c6f969da5811af5377cc10173583123b and
 5e698222c70257d13ae0816720dde57c56f81e15 (apparently including your
 5.7.0-rc0).


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


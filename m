Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B3FC433EF
	for <util-linux@archiver.kernel.org>; Wed, 18 May 2022 09:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiERJE2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 18 May 2022 05:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiERJE1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 18 May 2022 05:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAFF913CA37
        for <util-linux@vger.kernel.org>; Wed, 18 May 2022 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652864664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ZFOaCe6gV1y/pJlXsSd532ONaqb2q9rwIRPINteTig=;
        b=CWRxYOG/UUoTgyYKtswBNTs39769UT7sOmtysEANzw7bXwZ1ehnp3vpsOdfdEulGvh4423
        +NT9g8FGiBoVKtOLqrBl1WTFb9GMWLivSo6OZNubVGegBzjtXmTP2tP59fSXwkVRNvvUmz
        Qvmqjpro6+4XyJcBgeoacCHleUIBYZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-VFb5eVykPNKRjpXQjKMOgg-1; Wed, 18 May 2022 05:04:21 -0400
X-MC-Unique: VFb5eVykPNKRjpXQjKMOgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BF178032E5;
        Wed, 18 May 2022 09:04:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E514F400E118;
        Wed, 18 May 2022 09:04:20 +0000 (UTC)
Date:   Wed, 18 May 2022 11:04:18 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Nathan Sharp <nwsharp@live.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH RFC 1/4] misc-utils: add the pipesz utility
Message-ID: <20220518090418.yrit7roh6lismut5@ws.net.home>
References: <20220412045930.236051-1-nwsharp@live.com>
 <SN6PR04MB3983957C75B4FF779E3D611CC2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
 <20220504105030.tqswjfqezivnodgb@ws.net.home>
 <SN6PR04MB3983208E1DE062616C7DCB44C2C59@SN6PR04MB3983.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB3983208E1DE062616C7DCB44C2C59@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, May 06, 2022 at 02:58:07AM +0000, Nathan Sharp wrote:
> Thank you! Let me know what changes you'd like to see and I'll whip up a v2!

Applied, thanks. Unexpected :-), but you have convinced me that more
getopt_long() is better than allocating extra stuff for such simple
util like pipesz :-)

You should contribute more often; I like your perfectionism (man
pages, meson, bash-completion, ...) :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


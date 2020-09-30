Return-Path: <SRS0=ZB3I=DH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE031C4727C
	for <util-linux@archiver.kernel.org>; Wed, 30 Sep 2020 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72ACB20706
	for <util-linux@archiver.kernel.org>; Wed, 30 Sep 2020 17:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hypYJlj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgI3Rkh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Sep 2020 13:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbgI3Rkg (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Sep 2020 13:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601487635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TO7PFSDunReEiaGHgmAi3JeepAS//Hct9qiORGJm0+Q=;
        b=hypYJlj6muLaqx2RAUae8AlQSkhqwtie0bxm36xi+P83nu1q5kkvMOrXqpln48ETjfaxLn
        AlzCbpu7lVpZbfU0B2SxYAfCdF71CmfHivsmwSgVA3ZPHKx350tsszL2Br2sMuFDfONf4a
        fdlQsNOi9+YA0LvSV4oEPSjCbY3xfL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-VDKP0w3QPn2jRUu6s8IgnQ-1; Wed, 30 Sep 2020 13:40:32 -0400
X-MC-Unique: VDKP0w3QPn2jRUu6s8IgnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B35BD8030C6;
        Wed, 30 Sep 2020 17:40:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 994047BE5B;
        Wed, 30 Sep 2020 17:40:30 +0000 (UTC)
Date:   Wed, 30 Sep 2020 19:40:27 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Jeffrey Bastian <jbastian@redhat.com>
Cc:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        util-linux@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Message-ID: <20200930174027.rohdyp2kubitbs24@ws.net.home>
References: <20200928094614.3648619-1-nakamura.shun@jp.fujitsu.com>
 <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
 <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Sep 30, 2020 at 09:44:09AM -0500, Jeffrey Bastian wrote:
> On Tue, Sep 29, 2020 at 12:46:27PM +0200, Karel Zak wrote:
> > On Mon, Sep 28, 2020 at 06:46:14PM +0900, Shunsuke Nakamura wrote:
> > >  sys-utils/lscpu-arm.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > 
> > Applied, thanks.
> 
> 
> With the other ARM patch applied ("use SMBIOS tables on ARM for lscpu"),
> the output changes on an FX700 system:
> 
> [root@fujitsu-fx700 ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
> Vendor ID:                       FUJITSU
> Model:                           0
> Model name:                      461F0010
> Stepping:                        0x1
> 
> 
> The values here come from the SMBIOS Type 4 record:
> 
> [root@fujitsu-fx700 ~]# strings /sys/firmware/dmi/entries/4-0/raw
> CPU1
> FUJITSU
> 461F0010
> 8K083MH14
> 
> 
> This FX700 system has firmware revision 1.4.0 (Jun 17 2020).

hmm... 461F0010 does not seem user-friendly, "A64FX" seems better. 

Shunsuke, what about to update the firmware strings? ;-) (as Jeffrey
suggested in RH bugzilla)

The another possibility is to exclude some vendors and do not use
SMBIOS for them (e.g. 0x46 for Fujitsu), but from my point of view
SMBIOS based solution is more elegant and ready for new CPU types than
in-lscpu hard coded tables.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <SRS0=OXhp=DG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157B5C4727C
	for <util-linux@archiver.kernel.org>; Tue, 29 Sep 2020 21:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3A92076A
	for <util-linux@archiver.kernel.org>; Tue, 29 Sep 2020 21:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I66IQCYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgI2Vpc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727922AbgI2Vpb (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 29 Sep 2020 17:45:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601415930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZP4NcDW6HxiRIuQHhBrdm/pjk92hqpr7BLp9Q0PmOAs=;
        b=I66IQCYr2u7EDCxYr55v4YUk69jOqJuiJlSqOraPwmljJWCqgkHSeDeXf+BOHgaMf+MoUY
        A8yNu+LTOmpsmlyf4VAuEv/cGDZSC3lKwZJHnQQrfUDTwp38cOLRpzrfCY4oyJMJ797Sr4
        8gn7hrOVAkGcZwv+Jq5+dOCdtrde+Nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-ehGx0qxROwabg6Ao8crVCA-1; Tue, 29 Sep 2020 17:45:27 -0400
X-MC-Unique: ehGx0qxROwabg6Ao8crVCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEC8BA744A
        for <util-linux@vger.kernel.org>; Tue, 29 Sep 2020 21:45:25 +0000 (UTC)
Received: from tarantula.users.ipa.redhat.com (unknown [10.10.115.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 572215D9D3;
        Tue, 29 Sep 2020 21:45:25 +0000 (UTC)
Date:   Tue, 29 Sep 2020 16:45:22 -0500
From:   Jeffrey Bastian <jbastian@redhat.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] use SMBIOS tables on ARM for lscpu
Message-ID: <20200929214522.6ijypguworp7hwlv@tarantula.users.ipa.redhat.com>
References: <20200924215617.c3oqc5tkuhjs5fyp@tarantula.users.ipa.redhat.com>
 <20200929113528.d46vxylxormyxel4@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200929113528.d46vxylxormyxel4@ws.net.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 29, 2020 at 01:35:28PM +0200, Karel Zak wrote:
>On Thu, Sep 24, 2020 at 04:56:17PM -0500, Jeffrey Bastian wrote:
>>  sys-utils/lscpu-arm.c | 88 ++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 87 insertions(+), 1 deletion(-)
>
>Applied, but I did some changes to the code to be more robust and to
>avoid dmi_header duplication in lscpu-arm.c and lscpu-dmi.c.
>
>https://github.com/karelzak/util-linux/commit/367c85c472869b75eaf770d4be0b360e30710b95
>
>Please, test it with your environment. I have no any ARM right now.

Thanks!  I wasn't sure how you wanted to handle the dmi duplicated code,
but I like what you did.

I tested this on several ARM servers and it worked well.  Note the
Amazon AWS m6g.large instance does not have a Type 4 entry in the SMBIOS
tables, so the fall back method was used (and it also works).


[ec2-user@aws-m6g.large ~]$ ls /sys/firmware/dmi/entries/4-0
ls: cannot access '/sys/firmware/dmi/entries/4-0': No such file or directory
[ec2-user@aws-m6g.large ~]$ ./lscpu | grep -e Vendor -e Model -e Stepping
Vendor ID:                       ARM
Model:                           1
Model name:                      Neoverse-N1
Stepping:                        r3p1


[root@hp-m400 ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
Vendor ID:                       AppliedMicro
Model:                           1
Model name:                      X-Gene
Stepping:                        0x0


[root@lenovo-hr330a ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
Vendor ID:                       Ampere(TM)
Model:                           2
Model name:                      eMAG
Stepping:                        0x3


[root@hpe-apollo-70 ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
Vendor ID:                       Cavium Inc.
Model:                           1
Model name:                      Cavium ThunderX2(R) CPU CN9975 v2.1 @ 2.0GHz
Stepping:                        0x1


[root@ampere-altra ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
Vendor ID:                       Ampere(TM)
Model:                           1
Model name:                      Ampere(TM) Altra(TM) Processor
Stepping:                        0x3


-- 
Jeff Bastian
Kernel QE - Hardware Enablement
Red Hat


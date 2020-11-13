Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84955C55ABD
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 18:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234E4206CA
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 18:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSjNtoyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgKMSVL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 13:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgKMSVL (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 13 Nov 2020 13:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605291670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3CJIH+Bh54pCEoDPbMv32C1Z/CRXmxGVxrNIkz9HT4=;
        b=iSjNtoyCLCM9di0F6mFL58+Q8IXiwQnEBguyBSYCtRYVCYDiYLlpSKJBahUyEVlWp1bTkj
        HhCAVdE1nMw7ANfj6x6o0ardFm7B1jMDMdo2XnLy/e3SHg1gCyrecYUDbk7RorSrnyL/En
        k8ZkhvnDKeH5DgNZCSLiOFEslJ3VduM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-3ZyBmL48N8SiZMMVTARwPQ-1; Fri, 13 Nov 2020 13:21:07 -0500
X-MC-Unique: 3ZyBmL48N8SiZMMVTARwPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5A6B8049D5
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 18:21:06 +0000 (UTC)
Received: from tarantula.users.ipa.redhat.com (ovpn-112-233.rdu2.redhat.com [10.10.112.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A5605C1C7
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 18:21:06 +0000 (UTC)
Date:   Fri, 13 Nov 2020 12:21:04 -0600
From:   Jeffrey Bastian <jbastian@redhat.com>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH v5] lscpu-arm: Add "BIOS Vendor ID" and "BIOS Model name"
 to show the SMBIOS information.
Message-ID: <20201113182104.or4tq6qiahxz2nf4@tarantula.users.ipa.redhat.com>
Mail-Followup-To: util-linux@vger.kernel.org
References: <20201111012400.23995-1-msys.mizuma@gmail.com>
 <20201113095906.tjd5iee4xb6cd72d@ws.net.home>
 <20201113164705.oyzgzeczxle3vwc5@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201113164705.oyzgzeczxle3vwc5@gabell>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Nov 13, 2020 at 11:47:05AM -0500, Masayoshi Mizuma wrote:
>On Fri, Nov 13, 2020 at 10:59:06AM +0100, Karel Zak wrote:
>> On Tue, Nov 10, 2020 at 08:24:00PM -0500, Masayoshi Mizuma wrote:
>> >  sys-utils/lscpu-arm.c | 22 ++++++++--------------
>> >  sys-utils/lscpu.c     |  4 ++++
>> >  sys-utils/lscpu.h     |  2 ++
>> >  3 files changed, 14 insertions(+), 14 deletions(-)
>>
>> Ported to the new lscpu and merged. Thanks (and extra thanks for
>> your patience :-).
>
>Thank you so much!
>
>>
>> I see one issue with the stuff from BIOS. It seems it reads the
>> information always from the same place. How does it work if I have two
>> different CPUs? I guess it always return the same model name, but what
>> if I have Cortex-A53 and Cortex-A72 on the same board?
>
>The first entry, /sys/firmware/dmi/entries/4-0/raw, is only used,
>so lscpu will show the same information of the SMBIOS type4 from
>the entry even if the system has two diffrent cpu models, like
>Cortex-A53 and Cortex-A72.
>I'm not familiar with the heterogenous SoC, probably each
>CPU model has own SMBIOS type4, right? for example, /sys/firmware/dmi/entries/4-0/raw
>is for Cortex-A53 and /sys/firmware/dmi/entries/4-1/raw is for Cortex-A72.

That's correct: there will be a 4-x/raw file for each CPU type.  So far
it's been safe to assume that all CPUs are the same in a system, but
with ARM big.LITTLE, that's no longer a safe assumption.  It will take a
bit more work to associate each SMBIOS entry with each CPU in
/proc/cpuinfo.

https://en.wikipedia.org/wiki/ARM_big.LITTLE


-- 
Jeff Bastian
Kernel QE - Hardware Enablement
Red Hat


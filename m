Return-Path: <SRS0=ZB3I=DH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13893C4727E
	for <util-linux@archiver.kernel.org>; Wed, 30 Sep 2020 14:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1267206FC
	for <util-linux@archiver.kernel.org>; Wed, 30 Sep 2020 14:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJkGEhfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgI3OoS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Sep 2020 10:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbgI3OoS (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Sep 2020 10:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601477058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMRy6jwjtBFH5c4v5KAYzrEinB+N2Mlh1hYGqFRe/Dk=;
        b=VJkGEhfXLMtCGO+HUK7OcuPdQMvqCe7Sg/rJX1pjKTRDIiaVhmmPTgMJPsYHWS9Doqzxgy
        ggNJ0Xyh1btYL8xYZLcyU8sYwyylSBnvAujENJawSvOAUnqp6aMgtnZEnk5sYlLA+2OouC
        ufKBrui6aFgoMqoGimPNxbrHqaJSjfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-eI5lPr01MeGQP-LKr6-eNw-1; Wed, 30 Sep 2020 10:44:14 -0400
X-MC-Unique: eI5lPr01MeGQP-LKr6-eNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5031A8015C3;
        Wed, 30 Sep 2020 14:44:13 +0000 (UTC)
Received: from tarantula.users.ipa.redhat.com (unknown [10.10.115.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EA3F5D9DC;
        Wed, 30 Sep 2020 14:44:12 +0000 (UTC)
Date:   Wed, 30 Sep 2020 09:44:09 -0500
From:   Jeffrey Bastian <jbastian@redhat.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        util-linux@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Message-ID: <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
References: <20200928094614.3648619-1-nakamura.shun@jp.fujitsu.com>
 <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 29, 2020 at 12:46:27PM +0200, Karel Zak wrote:
>On Mon, Sep 28, 2020 at 06:46:14PM +0900, Shunsuke Nakamura wrote:
>>  sys-utils/lscpu-arm.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
>Applied, thanks.


With the other ARM patch applied ("use SMBIOS tables on ARM for lscpu"),
the output changes on an FX700 system:

[root@fujitsu-fx700 ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
Vendor ID:                       FUJITSU
Model:                           0
Model name:                      461F0010
Stepping:                        0x1


The values here come from the SMBIOS Type 4 record:

[root@fujitsu-fx700 ~]# strings /sys/firmware/dmi/entries/4-0/raw
CPU1
FUJITSU
461F0010
8K083MH14


This FX700 system has firmware revision 1.4.0 (Jun 17 2020).


-- 
Jeff Bastian
Kernel QE - Hardware Enablement
Red Hat


Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2126C388F7
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 09:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CA02145D
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 09:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqR+DNtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgKMJyH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 04:54:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbgKMJyH (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 13 Nov 2020 04:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605261245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=o+hAG0mJh1SV1vp3uLoSxWMkJwuzSzNZCwP2PREEcNE=;
        b=OqR+DNtxEnIGXXaiiNHATHbbdvOr9Kn1lyNq6RWC3erloKwkwdXc7cKsozJF/xbeseNDnI
        esPsk119CuWUCQeqx8LwANTAtfuRDKDIz44pYknp7/xSmyTIBQ6biRX7UZu+b4EqEhZQEa
        fPx1oOh3xkDZtzyZ/WeKpYsdB7M5Ob0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-XWblVGfcOr-XXH3VFflNLQ-1; Fri, 13 Nov 2020 04:54:00 -0500
X-MC-Unique: XWblVGfcOr-XXH3VFflNLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E67F686ABD3;
        Fri, 13 Nov 2020 09:53:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EF5560C15;
        Fri, 13 Nov 2020 09:53:55 +0000 (UTC)
Date:   Fri, 13 Nov 2020 10:53:52 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Cai Qian <qcai@redhat.com>
Subject: new lscpu
Message-ID: <20201113095352.5abeznymfp3lnvoo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


Hi guys,

I have merged new lscpu(1) to our master branch. Changes:
                                      
* code is more readable and better structured (I hope)

* data about CPU and CPU-type are maintained in separate structs

* supports multiple CPU-types (model and topology) on one system
  (the old version reads topology only from CPU0 only)

  Example from system with A53 and A72 with different number of cores:
                                     
        Vendor ID:              ARM   
          Model name:           Cortex-A53                                     
            Model:              4     
            Thread(s) per core: 1     
            Core(s) per socket: 4     
            Socket(s):          1     
            Stepping:           r0p4  
            CPU max MHz:        1416.0000                                      
            CPU min MHz:        408.0000                                       
            BogoMIPS:           48.00 
            Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
          Model name:           Cortex-A72                                     
            Model:              2     
            Thread(s) per core: 1     
            Core(s) per socket: 2     
            Socket(s):          1     
            Stepping:           r0p2  
            CPU max MHz:        1800.0000                                      
            CPU min MHz:        408.0000
            BogoMIPS:           48.00 
            Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
                                      
                                      
* the default output on the terminal is organized in sections to make
  it more readable for humans, non-terminal output (>file, |grep, etc) is
  still "flat".
                                      
* the output for --extended and --parse provides more columns now 
                                      
* it uses cache IDs as exported by new kernels; it's possible that 
  --extended and --parse cache identifiers will not start from zero. 
  It's an expected change.
                                      
* all recent ARM related changes has been merged into the new code too
                                      
I have /sys and /proc dumps from many systems, but it's still possible
that the new lscpu will print non-senses in some cases. Please, test
it on your machines, exotic or unusual systems, etc. You know ... ;-)
Thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


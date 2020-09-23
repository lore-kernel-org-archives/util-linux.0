Return-Path: <SRS0=+2KV=DA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87497C2D0A8
	for <util-linux@archiver.kernel.org>; Wed, 23 Sep 2020 11:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E8C20725
	for <util-linux@archiver.kernel.org>; Wed, 23 Sep 2020 11:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOsPMHbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgIWLGE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgIWLGD (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 23 Sep 2020 07:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600859162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BtvwBdpuo0+TqmBEI8YetT7sc01zkOe4G4Wz0r0s48Q=;
        b=EOsPMHbqXl9cwMeBh7LEuYI4mKlYqa69BFNfofT0HqfbV3idxg7aQotKLF8anFRVFfRcSU
        etXc3YAwgAAPyeq+/VeXFGDPqhwSyiHUhNsM4BVuQj4M4fB5c+VUKpUqJo5UVBGOMpR7jk
        WaszFDCRvh0upxFZiMCMNaPiCJbq2ko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-bV1BZnTzNXayz9a3MXBniw-1; Wed, 23 Sep 2020 07:05:59 -0400
X-MC-Unique: bV1BZnTzNXayz9a3MXBniw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3918A85C733;
        Wed, 23 Sep 2020 11:05:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43CA873689;
        Wed, 23 Sep 2020 11:05:57 +0000 (UTC)
Date:   Wed, 23 Sep 2020 13:05:54 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Ian Kent <raven@themaw.net>, Michal Sekletar <msekleta@redhat.com>
Subject: mountbomber -- generate mount load
Message-ID: <20200923110554.agy6xevx3ll6uqh7@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi,

I have created an experimental testing tool to generate a large number of
mount/umount operations on a large number of mount points. The important feature
is that it does not use standard mount(8) command and it does not parse
anything in /proc. 

The goal is to have a standard tool to easily reproduce mount load without
writing a custom shell scripts.

The number of features is pretty basic and it supports only tmpfs now. Maybe
later it will support other filesystems, regular block devices (or loopdevs)
and more operations (like remount, execute scripts, etc.). We will see ...

The tool creates and cleanup all stuff, you do not have create mountpoints, etc.

It's maintained in separate branch in util-linux repository:

  git clone https://github.com/karelzak/util-linux.git --branch topic/mountbomber --single-branch
  cd util-linux
  ./autogen.sh
  ./configure
  make mountbomber


Examples:


  # mountbomber --parallel 1 --verbose \
                --oper "mount:all,@A,umount:rand,mount:last,->A(loops=2),umount:all"

  - one process, 100 mountpoints (default), random umount and mount two times


  # mountbomber --verbose --pool 10 \
                --oper "mount:all,@A,umount:next,mount:last,delay(500000),->A(loops=200),umount:all"

  - 200 times umount and mount in order


  # mountbomber --pool 10000 \
                --oper "mount:all,@A,umount:rand,mount:last,delay(1000),->A(seconds=60),umount:all"


   - 10 processes (default) repeating random umount/mount for 1 minute on 10000 mountpoints
   - your udisks will be pretty busy :-)

For more details:

  $ mountbomber --help 

there is no man page yet.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


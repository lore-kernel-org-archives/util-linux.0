Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4552C433E0
	for <util-linux@archiver.kernel.org>; Tue, 16 Feb 2021 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67BC64E04
	for <util-linux@archiver.kernel.org>; Tue, 16 Feb 2021 18:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBPSCI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:02:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhBPSCG (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 Feb 2021 13:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613498439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6EVOTmP0VDZBFGqP0tXxdJ2niy5LLaoo7kvFe7WWZRI=;
        b=LGjjA2F3Z/5BGp6FoGJCIxwjyilZAhWvkA+cih55QZYDuUzGZo+DSNjKma1c7fB7BYqk31
        vcNZv2Il5FkMg7f0NE64s0erglxh9R0OSIIJAPY32JZe81lV2azJslM1g/Z1JVgVT8rohs
        lklZJYr+kHEuH5nqnx8NsUrREAwZAlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-E5bmew0jMsOi8jOe1e1uRg-1; Tue, 16 Feb 2021 13:00:35 -0500
X-MC-Unique: E5bmew0jMsOi8jOe1e1uRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C7E1005501;
        Tue, 16 Feb 2021 18:00:34 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C3011975F;
        Tue, 16 Feb 2021 18:00:33 +0000 (UTC)
Date:   Tue, 16 Feb 2021 19:00:30 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: meson build-system
Message-ID: <20210216180030.a3pdnbcm3ps6dqmi@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi all,

A year ago Zbigniew (CC:) implemented meson build-system as a second
build system for util-linux. Today I finally updated it and pushed to
the topic/meson branch on github. You can try it:

   git checkout -f topic/meson
   meson build
   ninja -C build
   ls build/

No panic, we are going to keep autotools as our primary build-system
for the next years :-)

The goal is to try to provide an alternative, make it more stable,
and maybe in future use it. The current util-linux meson configuration is 
probably not mature enough to be used as a build-system for end-users and
downstream distributions, but it seems as a nice alternative for
developers, it's faster and it produces real binaries rather than
libtool scripts.

  $ git clean -xdf
  $ time ( meson build;  ninja -C build )
  real	0m9.093s
  user	0m12.797s
  sys   0m5.232s

  $ git clean -xdf
  $ time ( ./autogen.sh; ./configure; make -j )
  real	0m41.563s
  user	1m52.681s
  sys	0m30.346s

All the meson configuration is completely independent on autotools or
another code in the package. I'll probably merge it to the master
branch ASAP to make it easy to use for contributors.

Comments & objections?

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


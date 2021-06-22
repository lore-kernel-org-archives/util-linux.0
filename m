Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6843C49EA2
	for <util-linux@archiver.kernel.org>; Tue, 22 Jun 2021 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9878360234
	for <util-linux@archiver.kernel.org>; Tue, 22 Jun 2021 18:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFVSby (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232376AbhFVSby (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Jun 2021 14:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624386578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEYZwhKk1ngodGluU4ksWYCgwwJtWXNV/ArmL1ypsNs=;
        b=IwHeTCuSb42pNjicZDPP4ABWcbwXjQplNs0Q5xgKuFqdzEu5GJQXQv6DuTX5hpSlosaT2y
        qmDdHKT74KIXJUgpdgTV6iBXIxbJdfOH7S4wJWoXHkNqCJW6sAU8naWUfOg4thfZfid5ON
        VEPtg5jruc7P04L3aOSnwYqFxzYztOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-f-Z9Q_ynP_mAhbiPzz4Otg-1; Tue, 22 Jun 2021 14:29:36 -0400
X-MC-Unique: f-Z9Q_ynP_mAhbiPzz4Otg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE91C18D6A25;
        Tue, 22 Jun 2021 18:29:34 +0000 (UTC)
Received: from ws.net.home (ovpn-112-214.ams2.redhat.com [10.36.112.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E29260877;
        Tue, 22 Jun 2021 18:29:33 +0000 (UTC)
Date:   Tue, 22 Jun 2021 20:29:31 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0JDQvdC00YDQtdC5INCf0LXRgtGA0L7Qsg==?= 
        <a.petrov@swemel.ru>
Cc:     util-linux@vger.kernel.org
Subject: Re: Question
Message-ID: <20210622182931.egsc4enbhxvca2b5@ws.net.home>
References: <84051527-c1c5-371b-a4ae-f6482508c547@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84051527-c1c5-371b-a4ae-f6482508c547@swemel.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 22, 2021 at 01:17:56PM +0300, Андрей Петров wrote:
> Hi, i have a question about devname.c https://github.com/karelzak/util-linux/blob/master/libblkid/src/devname.c#L377
> 
> Why is there size is equal 110? Can't the device name be greater then 110?
> In linux https://github.com/torvalds/linux/blob/13311e74253fe64329390df80bed3f07314ddd61/include/linux/genhd.h#L27
> 
> DEVICE_NAME_LEN is defined as 32, wouldn't be better if you use this define
> in your program?

I have a better way how to fix it -- let's remove entire EVMS code from
the library. EVMS is dead project since year 2006.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


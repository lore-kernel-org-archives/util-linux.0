Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86171C2B9F4
	for <util-linux@archiver.kernel.org>; Thu, 17 Jun 2021 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4FA613D5
	for <util-linux@archiver.kernel.org>; Thu, 17 Jun 2021 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFQJBj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231328AbhFQJBh (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 17 Jun 2021 05:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623920370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpYpe7xT5lPlasiz6hJds5x4S9YWIwgNl48EVBhtz5A=;
        b=h86oqr8/ySZprVAHaLTREl9Ea7H+twnbVktmrTlC4Y+1UOEpcxAMyaOH4tAl/7CmD24TEW
        Qw2JQASwFJU85TQ0MMx6Nbw7jC4YQgM904B/JLK5qJhbHvp1SFMnYBO6sAWqlHjvb8bjK6
        5/XIjSjhgSxdYGtnd9UAW5WuZ9JYZGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-JlIOG30INKOu1tHTLx0-ww-1; Thu, 17 Jun 2021 04:59:26 -0400
X-MC-Unique: JlIOG30INKOu1tHTLx0-ww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EA5FBBF00;
        Thu, 17 Jun 2021 08:59:04 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D42D21000324;
        Thu, 17 Jun 2021 08:59:03 +0000 (UTC)
Date:   Thu, 17 Jun 2021 10:59:01 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: An obscure problem with v2.37 make check
Message-ID: <20210617085901.l45esa2fuzinn44w@ws.net.home>
References: <cdfa712c-c918-c5bd-e320-b3dbe8599bbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdfa712c-c918-c5bd-e320-b3dbe8599bbd@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jun 16, 2021 at 03:42:04PM -0500, Bruce Dubbs wrote:
> When I built version v2.37, make check hung on me.  The problem was in my
> kernel configuration, but I thought I would pass this on.
> 
> First of all, my biggest problem was finding out what had failed.  A simple
> 'make check' ran the tests and when it got to the end, hung.
> 
> I could not find any documentation about running the tests, but diving into
> the Makefile led me to tests/run.sh.  By default this runs tests using all
> cores, but it is unclear if this is meant to be run directly.
 
The tests are designed for smart people, like you who, are able to debug it ;-)

> In any case running run.sh --parallel=1 (instead of the default 24) allowed
> me to find the problem test, tests/ts/lsns/ioctl_ns.  In this test, it is
> doing:

The --parallel=1 is the default when you execute ./run.sh from command
line. This is the way I usually use the tests. The "make check"
executes it in parallel to make it faster for automated execution
(github actions, travis, random QA, etc.)

> 
> my_userns=$(stat -c %i -L /proc/self/ns/user)
> 
> My problem was that /proc/self/ns/user did not exist on my system.  This was
> due to a missing CONFIG option in my kernel configuration.  Adding that and
> rebuilding the kernel allowed all tests to pass.
> 
> One solution to this problem may be to test for the existence of the file
> before running 'stat' similar to the tests for programs like 'touch' and

Sounds good. Please, send patch.

For 3rd party programs you need "ts_check_prog <progname>" at the
beginning of the test.

> 'uniq'.  Since this is such an unusual situation, I can understand if you
> just ignore the issue, however I thought you should know about it.
 
It's definitely important to run the tests in more environments to
make it stable and I'm happy that we have contributors from
non-mainstream distributions.

So, thanks for your feedback.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


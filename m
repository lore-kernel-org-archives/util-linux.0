Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98791C433F5
	for <util-linux@archiver.kernel.org>; Mon, 28 Feb 2022 09:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiB1Jz0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiB1Jz0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 28 Feb 2022 04:55:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FEAF69CF2
        for <util-linux@vger.kernel.org>; Mon, 28 Feb 2022 01:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646042087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bonuetf/g/iwfQWxuFCeCO0N6lQZcXwF44TzWP9ta6k=;
        b=hrTEyMcboe+QU/xDvvB3VZrHSLbBvPYXLv9r5JO+7bNYsla75wbfkKCqUvFoIWJOtjWNdL
        8tOESIBxai7MOQxtKJM4PsNyW4mY7ybt9ocflvmt1Vo5xzwXv4IGvuwqZkqaLBkfXMsirl
        B0CkbI0dEx/dL3etWE/MDwJvqzmwQ9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-Ble6f0a0MdqkXrMek39d7g-1; Mon, 28 Feb 2022 04:54:44 -0500
X-MC-Unique: Ble6f0a0MdqkXrMek39d7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B06F5180FD71;
        Mon, 28 Feb 2022 09:54:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C3DD7FCE8;
        Mon, 28 Feb 2022 09:54:42 +0000 (UTC)
Date:   Mon, 28 Feb 2022 10:54:40 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Wesley Aptekar-Cassels <me@wesleyac.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: dmesg feature request: timestamps relative to current time
Message-ID: <20220228095440.6sircosgwaihjltp@ws.net.home>
References: <130eb608-f5c6-44c8-999a-6e56e4c05d9a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <130eb608-f5c6-44c8-999a-6e56e4c05d9a@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Feb 16, 2022 at 04:33:43PM +0800, Wesley Aptekar-Cassels wrote:
> Hi all,
> 
> When I use dmesg, I'm often annoyed that there isn't a good way to tell how
> long ago a specific log line was from. The only accurate way to do so that I've
> found is to look at /proc/uptime and compare that value to the log line I care
> about. The ctime and iso options could be useful, but as the manpage points
> out, they are inaccurate in the case of suspend/resume, and I'd still have to
> do math in my head to see how long ago something was, even if it's easier to do
> the conversion than with the default style of timestamp.
> 
> I'd like to see a value for the --time-format option that prints timestamps as
> values in seconds relative to the time dmesg was executed.

Do we really need it? :-) I mean that

     --time-format ctime

makes connection between the log messages and real clocks. Is it enough?

> This would allow
> people to quickly see how long ago a relevant event happened. I'm not sure
> whether it would make more sense to conceive of times in the past as being
> negative or positive, but one or the other would need to be selected (one might
> see both in the case of --follow)

I think negative numbers makes sense for this use-case. For example
"--time-format reltime" uses positive number relative to system start,
you want something like "reverse-reltime". Something like:

    [    -6.634976] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready

> I'm happy to write a patch if
> so, but wanted to check here first to see if it's something that'd be likely to
> be accepted.

I have nothing against this feature. So, go ahead if you want.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


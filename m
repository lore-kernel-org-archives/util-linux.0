Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F3DC001DF
	for <util-linux@archiver.kernel.org>; Tue,  1 Aug 2023 13:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjHANnV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Aug 2023 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjHANnE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2023 09:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9301BDB
        for <util-linux@vger.kernel.org>; Tue,  1 Aug 2023 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690897335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=peosiQq+41ISeqojuQkGVS9EDruP+yNqRM727UTxynE=;
        b=Rbgts5hkHagqiZmEnrDLv7LffD9SEjs2NoN2WLqajuf0gBdlJHIlB0bJN35wh0DIDreSWM
        7wExl9NIy5fVS9GAHrG7IckGU5r76ue8hEmexkY7ddudg7o4BuYz0M9UU4aLwGSUrX+ntg
        j+G0XQjzFNzVawuNo9aD3J9Qe7rO8BE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-oqCMaliBPXC8_tT9671kyw-1; Tue, 01 Aug 2023 09:42:14 -0400
X-MC-Unique: oqCMaliBPXC8_tT9671kyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1299B1044596;
        Tue,  1 Aug 2023 13:42:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9489640C206F;
        Tue,  1 Aug 2023 13:42:12 +0000 (UTC)
Date:   Tue, 1 Aug 2023 15:42:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] Alternative color configuration for dmesg
Message-ID: <20230801134210.ayct6znedmnh5vhn@ws.net.home>
References: <e6370090700c26776e2ce6444a05a2d2@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6370090700c26776e2ce6444a05a2d2@manjaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi,

On Sun, Jul 16, 2023 at 07:32:03PM +0200, Dragan Simic wrote:
> I'd like to implement support for an additional, alternative way for the
> color configuration in the dmesg utility.  It would use an environment
> variable to store the color configuration, in a way rather similar to what
> grep(1) does using the GREP_COLORS environment variable.

frankly, terminal-colors.d has been implemented to avoid environment
variables :-)

Anyway, I have nothing against support for <util>_COLORS= if it will
be implemented into lib/colors.c and the code will work together.

For example if terminal-colors.d/*.disable will force application to
ignore <util>_COLORS= too.

The ideal solution will be if the env.variable will be just another
way how to specify color scheme (alternative to .scheme file).

Maybe also follow conventions used by terminal-colors.d, it means
scheme, enable and disable options, for example:

    DMESG_COLORS=disable
    DMESG_COLORS=enable
    DMESG_COLORS=alart:37;41,warning:37;42

(not sure about the format, this just brain-storming ... ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


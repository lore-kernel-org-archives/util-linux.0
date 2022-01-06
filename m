Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF530C433EF
	for <util-linux@archiver.kernel.org>; Thu,  6 Jan 2022 13:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiAFN1z (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Jan 2022 08:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230323AbiAFN1z (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Jan 2022 08:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641475674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7DIS25WrDL09HIjNHJATJPZycasA4g7qzQu0BbnUj8=;
        b=TaQEKn1/Kr8QOjUXVzq0zeNmid+xvXJWU9a5S4J1F279gC1/brmngOZn6PgAOvDUBnyOUF
        mC+Ji6TnwUjFrWsFGPfz9kbXL5SjEZOPY9KkJN7PjphzwMYmwM6ZOcovtbFASBTKoGF5Sk
        ZHK5jQhAi1dhJQuiBDlRuHTvzoLG+Gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-XY1M1V3UPLS2T3L7fvjdfw-1; Thu, 06 Jan 2022 08:27:51 -0500
X-MC-Unique: XY1M1V3UPLS2T3L7fvjdfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 346BC1083F60;
        Thu,  6 Jan 2022 13:27:50 +0000 (UTC)
Received: from ws.net.home (ovpn-112-15.ams2.redhat.com [10.36.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3583422E0B;
        Thu,  6 Jan 2022 13:27:49 +0000 (UTC)
Date:   Thu, 6 Jan 2022 14:27:46 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     util-linux@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: su currently requires PAM
Message-ID: <20220106132746.pcxng3anm5kave6w@ws.net.home>
References: <0616772a-c45c-d003-c338-45dd7071fb70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0616772a-c45c-d003-c338-45dd7071fb70@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Dec 27, 2021 at 09:26:01AM -0600, Bruce Dubbs wrote:
> In linuxfromscratch, we have been using su from the shadow package because
> the util-linux version requires Linux-PAM.  Recently the maintainers of
> shadow have announced that they are deprecating su.  Our problem is that
> some of our users prefer to not install PAM.

I had a discussion about it with Serge (in CC), it seems the current
the conclusion is that "for now shadow will have to keep shipping su".

> Is it possible to make the requirement of Linux-PAM optional in the
> util-linux version of su?  From a preliminary inspection of the code, it
> looks like only login-utils/su-common.c would need to be modified with some
> #ifdef constructs, but I am not completely comfortable doing that myself.

The problem is not #ifdef, but that you need local reimplementation
for the very basic PAM functionality.                    

I have suggested creating some minimalistic library with PAM
compatible API, but without all the functionality. Maybe we can
develop this library in util-linux and later offer it to other
projects. Volunteers? ;-)
                                                         
Another possibility is to improve the original PAM to make it possible
to compile it without modules, etc.          

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


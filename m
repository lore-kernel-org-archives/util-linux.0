Return-Path: <SRS0=zmxI=DP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A6C46466
	for <util-linux@archiver.kernel.org>; Thu,  8 Oct 2020 07:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7943B206F4
	for <util-linux@archiver.kernel.org>; Thu,  8 Oct 2020 07:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnOTYRsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgJHHyK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 8 Oct 2020 03:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728591AbgJHHyB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Oct 2020 03:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602143640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UztAX6uWpGMc6KAGANBIx2LWK7F4mC8/ynY2W3z3KF0=;
        b=fnOTYRsYL/L/eR3Kjo5tz517jeyYhVBcGqIbZkq8Lo6bPFrTbgmLeGwl8tg4IvGQZLPlSW
        /nRnNTg5GCyKYVlP/ToqQfHNcDEFPEZZDYsD3aHiWF9+sWg4/rDvH5M2jjazeuiGZzpELv
        uJF1ZR7cRW3oLn7X0s5B8bUgZThbvnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-SMFin12YOP-QqTkNJd8kGg-1; Thu, 08 Oct 2020 03:53:56 -0400
X-MC-Unique: SMFin12YOP-QqTkNJd8kGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EDB61015EA2;
        Thu,  8 Oct 2020 07:53:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 536FE5C1BD;
        Thu,  8 Oct 2020 07:53:54 +0000 (UTC)
Date:   Thu, 8 Oct 2020 09:53:51 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     Util-Linux <util-linux@vger.kernel.org>,
        jun wang <junguo.wang@suse.com>
Subject: Re: [PATCH] bash-completion: Fix su
Message-ID: <20201008075351.ucusodaf3dqh5k4v@ws.net.home>
References: <423799ab-a6d8-987c-711e-cdda6ee72c3e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423799ab-a6d8-987c-711e-cdda6ee72c3e@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 08, 2020 at 08:50:39AM +0200, Stanislav Brabec wrote:
> Fix su -s <tab> that reports invalid chsh -l.
 
"cat /etc/shells" and "chsh -l" get the same output on my system, why
"chsh -l" is invalid? 

chsh -l uses getusershell() glibc function.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


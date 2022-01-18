Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F4C433EF
	for <util-linux@archiver.kernel.org>; Tue, 18 Jan 2022 11:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiARLf4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240443AbiARLfy (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jan 2022 06:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642505754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRlCwAXDADK4cS5DIfEFWn9mKgvOMywzeydlky+XsXo=;
        b=XVm7hc6QBtlLfrEQQi83RIA8sT3hozrEPRcmF4WK8haC0GAgIeMqVU5etrwpzGe5HxKqI3
        9Q8d2UC+ydvTfnNpq0LF2uCeeVn+pzGOro0ePpSR1j896LY9ee5+xu3VzGODQVYEq5BF9K
        i5fe6bh4/Baw/iTbI0Dc2DCtkEqTClk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-VDP8rs8RNyabtH6cauVrpA-1; Tue, 18 Jan 2022 06:35:52 -0500
X-MC-Unique: VDP8rs8RNyabtH6cauVrpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0441363A4;
        Tue, 18 Jan 2022 11:35:51 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C730A72FA9;
        Tue, 18 Jan 2022 11:35:50 +0000 (UTC)
Date:   Tue, 18 Jan 2022 12:35:48 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     util-linux@vger.kernel.org, Daniel Gerber <dg@atufi.org>
Subject: Re: [PATCH 0/2] unshare: some idmap fixes
Message-ID: <20220118113548.rq4acoc47igzbewo@ws.net.home>
References: <20220115162926.546843-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115162926.546843-1-seanga2@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jan 15, 2022 at 11:29:24AM -0500, Sean Anderson wrote:
> This series has some fixes to code and documentation around idmaps.
> 
> 
> Sean Anderson (2):
>   unshare: Fix parsing of id maps

I have fixed mem2strcpy().

>   unshare: Fix doc comments

Applied. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


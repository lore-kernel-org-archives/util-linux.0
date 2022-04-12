Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9175C433F5
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 11:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiDLLZx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352284AbiDLLZk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 07:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 839A86F48C
        for <util-linux@vger.kernel.org>; Tue, 12 Apr 2022 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649758082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4VEFaOdjGmzKAVu1MjgqJ4A46A6qyXTJUpX3nmvtHc=;
        b=TPoofSXLL+JVefiPGAT8zRsr1VpPSMG5WD2eUGl0dp9J/F6Wk52Kr5H7+pJurkHVvx72H1
        j01cV/X4q/SH1YYRZKNARCX1Pd4jUfhH9LPYpiX+67a6Rn4ZPon/Bg1vm+4WIdXMvtO18Z
        2tcA1uT/aWdNmk/Ic2DbI3QPevNPcyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-iR_7flEvOHOOusoW6dw-GA-1; Tue, 12 Apr 2022 06:07:59 -0400
X-MC-Unique: iR_7flEvOHOOusoW6dw-GA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44562811E78;
        Tue, 12 Apr 2022 10:07:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC71B40CFD1E;
        Tue, 12 Apr 2022 10:07:58 +0000 (UTC)
Date:   Tue, 12 Apr 2022 12:07:56 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Philippe Reynes <philippe.reynes@softathome.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/1] libfdisk: write mbr only when useful
Message-ID: <20220412100756.fxcz46jb3aj5dksv@ws.net.home>
References: <20220411124229.232299-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411124229.232299-1-philippe.reynes@softathome.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 11, 2022 at 02:42:28PM +0200, Philippe Reynes wrote:
>  libfdisk/src/gpt.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


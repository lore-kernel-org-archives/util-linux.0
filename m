Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF26C433F5
	for <util-linux@archiver.kernel.org>; Tue, 21 Sep 2021 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C949F610E8
	for <util-linux@archiver.kernel.org>; Tue, 21 Sep 2021 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhIUIsz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 21 Sep 2021 04:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231168AbhIUIsy (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Sep 2021 04:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632214046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b463GbasaLZJRPDq7q5qSLz1O8Dzchy3W8IPHX5jlcc=;
        b=eS2ezlRrCId872ZtZqzwwPIBQpN37xZjmUzFPkrUr/DbEsTAVa/OgJ7x1NavWHttHSisl+
        u4lW5J/zj6rYlfurl4o42JwbAGpIkVdasfn1NcC6oHkAtwGUTx4sIT4zpVPC0kwvZGWJ1o
        JAOPk9LvFV0m927mpwO+pHE84A+efe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-ppJBtMm8PM6Fj-wtF-tD2Q-1; Tue, 21 Sep 2021 04:47:25 -0400
X-MC-Unique: ppJBtMm8PM6Fj-wtF-tD2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64AEA1926DA7;
        Tue, 21 Sep 2021 08:47:24 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BACFC6D99A;
        Tue, 21 Sep 2021 08:47:23 +0000 (UTC)
Date:   Tue, 21 Sep 2021 10:47:21 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] unshare.1.adoc: Improve wording re namespace creation
Message-ID: <20210921084721.2w7wqyziyc2helzm@ws.net.home>
References: <20210909000828.203994-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909000828.203994-1-mtk.manpages@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Sep 09, 2021 at 02:08:27AM +0200, Michael Kerrisk wrote:
>  sys-utils/unshare.1.adoc | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied (both patches), thanks.

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


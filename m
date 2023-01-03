Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718DC3DA7D
	for <util-linux@archiver.kernel.org>; Tue,  3 Jan 2023 14:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjACOgo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 3 Jan 2023 09:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjACOgn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 3 Jan 2023 09:36:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC08F4
        for <util-linux@vger.kernel.org>; Tue,  3 Jan 2023 06:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672756554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FD59zpCHKMGzRG84VH0pobQ8k2uTeDxmBa6hbedx2Ys=;
        b=G2UsJcdgiVMJl71vDxeev2W2FCBYBDVyh3f7jmnq7ewUg8apFe1lNxTp1tCiBYNVy7y84K
        inJhBib3gggiJLApjw8sNPX3TA2oGBlLPWJW3PYP0QSSEl8hY1iEnGDZkUTqA0vwIlTgWx
        NNlzuni5nf6C6Tlg4zT6JyExENm/rac=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-nn92yWUePdGd8Ofu7f2WZA-1; Tue, 03 Jan 2023 09:35:51 -0500
X-MC-Unique: nn92yWUePdGd8Ofu7f2WZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAACE3C0DDA8;
        Tue,  3 Jan 2023 14:35:50 +0000 (UTC)
Received: from ws.net.home (ovpn-194-37.brq.redhat.com [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 657902166B26;
        Tue,  3 Jan 2023 14:35:50 +0000 (UTC)
Date:   Tue, 3 Jan 2023 15:35:48 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Chris Webb <chris@arachsys.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] unshare: fix a --map-auto error message
Message-ID: <20230103143548.q5ifvzbrtvkqu4jk@ws.net.home>
References: <Y6h7nVM0l4mAiBgw@arachsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6h7nVM0l4mAiBgw@arachsys.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Dec 25, 2022 at 04:34:37PM +0000, Chris Webb wrote:
>  sys-utils/unshare.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


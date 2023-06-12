Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27234C7EE25
	for <util-linux@archiver.kernel.org>; Mon, 12 Jun 2023 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbjFLLGZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 12 Jun 2023 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbjFLLFk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 12 Jun 2023 07:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FEA9EC6
        for <util-linux@vger.kernel.org>; Mon, 12 Jun 2023 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686567194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ZQLiSJrFy3j1EjOcyaeO7sHOQhPx1l065XEoJayoQE=;
        b=bxw+Eet2Z0oQEwP27ALe7klHkS60KMGifSfYOiJh9hK/YyOdl/gSv/RmbZUnls5ddkt7zV
        h8zvqcJnNTerfWyPLQVJZM4LeZ+jGQMqWGNwhaNFbB2i8TQ7SYaaII+dPaL5A5I4xsBc9y
        8efsss0g0DbCmMauTzNS/T6wgyznSEo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-Lqyx86liNjGjipmBVG2hjQ-1; Mon, 12 Jun 2023 06:53:13 -0400
X-MC-Unique: Lqyx86liNjGjipmBVG2hjQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 579A73801FFE;
        Mon, 12 Jun 2023 10:53:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5F98492CAC;
        Mon, 12 Jun 2023 10:53:12 +0000 (UTC)
Date:   Mon, 12 Jun 2023 12:53:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Enze Li <lienze@kylinos.cn>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] build-sys: rearrange gitignore in alphabetical order
Message-ID: <20230612105151.5zf7zomjgioey4pa@ws.net.home>
References: <20230609013704.2926603-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609013704.2926603-1-lienze@kylinos.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 09, 2023 at 09:37:03AM +0800, Enze Li wrote:
>  .gitignore | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied both patches, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


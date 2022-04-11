Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC24C433EF
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 10:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiDKK4I (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiDKK4H (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 06:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1C6B43EFA
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649674431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKxVQIwpXf3swYYqHVmlcywB7dIm13oqGbyNMQguMQY=;
        b=TclNbjvVS/KifLrEfiYJ9TkxLigkVy5Pr3cMZmlB3KKecKlV+hssPUimEKVvC7MzLRZMnD
        2xH8mCU5GkxpH5K+PA7/ecjZHBF0Udz7XVbs2EdafRBXAiY7+bTFzjt4zQiVjTGPMyA0Kp
        vqWfvXv0YEdcpR1mbIeq2UNPei0qnzs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-ZzUKiXiyOGST1HBHXd-o_g-1; Mon, 11 Apr 2022 06:53:48 -0400
X-MC-Unique: ZzUKiXiyOGST1HBHXd-o_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 451EA3C14CC2;
        Mon, 11 Apr 2022 10:53:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB95C28106;
        Mon, 11 Apr 2022 10:53:47 +0000 (UTC)
Date:   Mon, 11 Apr 2022 12:53:45 +0200
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     util-linux@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 1/2] blkpr: rename operation to command
Message-ID: <20220411105345.rre3xfxg6p7dnxso@ws.net.home>
References: <20220407034932.68323-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407034932.68323-1-pizhenwei@bytedance.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 07, 2022 at 11:49:31AM +0800, zhenwei pi wrote:
> Suggested by Karel, rename operation to command.
> Thus make this more clear.

Both patches applied. Thanks!

(I did small changes to formatting to make a little bit shorter and
usable for translators.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


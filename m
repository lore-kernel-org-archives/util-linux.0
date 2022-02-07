Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0FBC433F5
	for <util-linux@archiver.kernel.org>; Mon,  7 Feb 2022 21:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiBGVoO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiBGVoN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Feb 2022 16:44:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 255ACC061355
        for <util-linux@vger.kernel.org>; Mon,  7 Feb 2022 13:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644270252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ns1pIROa+7bG7PrhTlK+MACCG46piEDviaVYdYbKsHw=;
        b=LrpBUltl2VtC9iLu3hj9F3ZWdPVq8Vb/8ZlH1pQ7kqKF8ay5Hp8qLARmQQgR6yRZh2wGT/
        t8LkKP0Ka/0vTUHeFnFs8Q3wFMDpfiVVC4CieMdoN9XJR+vvM+23QvNGDcInKXYceZu0xi
        AF3ngze4ZzjIKZ1QkBkFMArvYKoO9nE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-pM_sqTenOJmosaBWEuKDNA-1; Mon, 07 Feb 2022 16:44:09 -0500
X-MC-Unique: pM_sqTenOJmosaBWEuKDNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 298921091DA0;
        Mon,  7 Feb 2022 21:44:08 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A30F101E5BF;
        Mon,  7 Feb 2022 21:44:07 +0000 (UTC)
Date:   Mon, 7 Feb 2022 22:44:04 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (MBR) recognize EBBR protective partitions
Message-ID: <20220207214404.w6c4wijiwrj5ou7d@ws.net.home>
References: <20211203155908.6906-1-vincent.stehle@arm.com>
 <YgFhmowzGeXjfDEH@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgFhmowzGeXjfDEH@debian>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Feb 07, 2022 at 07:14:50PM +0100, Vincent Stehlé wrote:
> Is there any concern with this patch[1] adding support for EBBR protective
> partitions to fdisk, please?
> 
> I have verified that it does still apply to the master branch of util-linux.
> Do not hesitate to let me know if changes need to be made.

The patch is fine. I've overlooked your patch in my INBOX :-( Sorry.
Applied now. 

Thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847FC433EF
	for <util-linux@archiver.kernel.org>; Wed, 13 Apr 2022 08:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiDMIPC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiDMIPB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 13 Apr 2022 04:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B9BE4E3A7
        for <util-linux@vger.kernel.org>; Wed, 13 Apr 2022 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649837559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHYVSBA/4XabkGxKXd6iIsHQuEr1+UFHqm2w446Czg4=;
        b=QIMNj8iPH+s5zCcGq7Tb2m5X6eRfS9l1YYxkBsVS4tphKjibTarnwW2P81uc3OerCgq1xq
        8VGOqRu55JZ1XKsGM410YZBOgrIS4oJS1vqnsBJygA2XEbwLrfcTNIKOAdRYljjijke+v9
        2BUbRZXlqIy+a+y9ok363Ot9TiXyrdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-NY9Ya3URPm2aelGwQjj25A-1; Wed, 13 Apr 2022 04:12:38 -0400
X-MC-Unique: NY9Ya3URPm2aelGwQjj25A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4E5980005D;
        Wed, 13 Apr 2022 08:12:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59CFF400E870;
        Wed, 13 Apr 2022 08:12:37 +0000 (UTC)
Date:   Wed, 13 Apr 2022 10:12:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC v2] libmount: accept X-mount.{owner,group,mode}=
Message-ID: <20220413081234.65rtnj56qocowifz@ws.net.home>
References: <20220406113814.twdo4mwkevwuayht@ws.net.home>
 <20220407183913.kvchb7hbrfhyxjoc@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220407183913.kvchb7hbrfhyxjoc@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 07, 2022 at 08:39:13PM +0200, наб wrote:
> Thanks for the pointers!

BTW, we have discussion about IDs mapping for filesystems at 
https://github.com/util-linux/util-linux/issues/1652

The idea is based on user namespaces. Please, see the discussion,
maybe it's something what could be attractive for your use-case too.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


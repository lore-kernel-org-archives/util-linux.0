Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34D4C43334
	for <util-linux@archiver.kernel.org>; Mon,  6 Jun 2022 10:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiFFKl0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiFFKlZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2022 06:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C8F037AAA
        for <util-linux@vger.kernel.org>; Mon,  6 Jun 2022 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654512082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbFYVrUrbRPEjNG6pimJOnKXFUo6hg6fEZZtNnjvOJ0=;
        b=g/t8QvCVuYWyaRt5PSBZ7JdVPrnpH6R+mFnyZPBhWEj0IfGsUVuNZE+nuqiHWL/b8OIy2k
        CoqxHj+qAMDc8DtgQOnO5JWdFk+70Ax9EB1R93lhSSx2OiiVfpB2o7AMfJ+ZjOPO9Cq7PS
        MaiIOFkRwDrBTiEUgO3xokqxF//lvkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-7WXnhYKDOyC-0O0Bx5t5Lg-1; Mon, 06 Jun 2022 06:41:20 -0400
X-MC-Unique: 7WXnhYKDOyC-0O0Bx5t5Lg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73F5A185A7BA;
        Mon,  6 Jun 2022 10:41:20 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9195492C3B;
        Mon,  6 Jun 2022 10:41:19 +0000 (UTC)
Date:   Mon, 6 Jun 2022 12:41:17 +0200
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] lsblk: introduce 'MQ' column
Message-ID: <20220606104117.lbv4tify3qjvp2t3@ws.net.home>
References: <20220603122402.3274789-1-pizhenwei@bytedance.com>
 <20220603122402.3274789-5-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603122402.3274789-5-pizhenwei@bytedance.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 03, 2022 at 08:24:01PM +0800, zhenwei pi wrote:
> +static void process_mq(struct lsblk_device *dev, char **str)
> +{
> +	DIR *dir;
> +	struct dirent *d;
> +	unsigned int queues = 0;
> +
> +	DBG(DEV, ul_debugobj(dev, "%s: process mq", dev->name));
> +
> +	dir = ul_path_opendir(dev->sysfs, "mq");
> +	if (!dir) {
> +		*str = xstrdup("1");
> +		DBG(DEV, ul_debugobj(dev, "%s: no mq supported, use a single queue", dev->name));
> +		return;
> +	}
> +
> +	while ((d = xreaddir(dir))) {
> +		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +			continue;

 xreaddir() filters "." and "..".

 Anyway, there is a function ul_path_count_dirents() that does all the
 work. I made the change in the code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


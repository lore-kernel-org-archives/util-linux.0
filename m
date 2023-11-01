Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EABC4332F
	for <util-linux@archiver.kernel.org>; Wed,  1 Nov 2023 11:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjKAL4d (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Nov 2023 07:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjKAL4c (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Nov 2023 07:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28836DC
        for <util-linux@vger.kernel.org>; Wed,  1 Nov 2023 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698839748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baCfH+6MKDGFsT+Bylfqjfx3tJ2jBLxyGupQS796/64=;
        b=FMI6Uqy92/0Ytk+sHOBKp8piT3/vA4Gg8yHE2vAczPMjV4tLdT2LTN5iG2+eCZqwWyCq9W
        ctIJE/ctcSFA2+7cy1V17/l6UuvfmAYjOG1T3KY+Pu90uXEu4qp/QZ9zCXahSPddoXuy3N
        qSCQhS3MTWktJKQ6cSPdot2ff55J+UI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-63FWbPAlMAGCRtLh9KIKcg-1; Wed, 01 Nov 2023 07:55:43 -0400
X-MC-Unique: 63FWbPAlMAGCRtLh9KIKcg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B39E185A782;
        Wed,  1 Nov 2023 11:55:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5D20492BFA;
        Wed,  1 Nov 2023 11:55:42 +0000 (UTC)
Date:   Wed, 1 Nov 2023 12:55:40 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     util-linux@vger.kernel.org, thomas@t-8ch.de, dsimic@manjaro.org
Subject: Re: [PATCH V2] loopdev: report lost loop device file error
Message-ID: <20231101115540.eqz6q3prnqhi43y5@ws.net.home>
References: <20231025203603.48584-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025203603.48584-1-junxiao.bi@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Oct 25, 2023 at 01:36:03PM -0700, Junxiao Bi wrote:
> If a /dev/loopX is lost because someone might have removed it by mistake,
> future losetup operations on that loop device will fail.

 Thanks Junxiao,

 I has move aggressive with the changes and there is result:
 https://github.com/util-linux/util-linux/pull/2566

 For me the most important is to report used devices although there is
 not /dev loop node.

> +static void loopcxt_scan_lost_device_file(struct loopdev_cxt *lc)
> +{
> +	static int scanned = 0;
> +	dev_t devno;
> +
> +	/*only scan sysfs once for losetup cmd*/
> +	if (!scanned)
> +		scanned = 1;
> +	else
> +		return;
> +	devno = sysfs_devname_to_devno(lc->device);
> +	if (devno <= 0)
> +		return;
> +
> +	fprintf(stderr, "%s is lost, run \"mknod %s b %d %d\" to recover it.\n",
> +			lc->device, lc->device, major(devno), minor(devno));
> +}

 The lib/loopdev.c code is also used in libmount, so it should not
 directly print anything on stderr. It's application business to print
 the warning. I have moved it to losetup.c

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


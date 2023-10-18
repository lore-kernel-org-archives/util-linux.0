Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A6CDB47E
	for <util-linux@archiver.kernel.org>; Wed, 18 Oct 2023 18:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjJRSBQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 18 Oct 2023 14:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjJRSBD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 18 Oct 2023 14:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC76184
        for <util-linux@vger.kernel.org>; Wed, 18 Oct 2023 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697651998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwCEe7Ikk8MNubDO2nxGu/OD/K1RRQnoP+hNP9TyzCU=;
        b=eOVJ6ERe34Xotf73sB8dJX9IvtSQ2hsqt8B7kGdjhEE85nIo0LPbxf2WZFA6l2N/BWxkH6
        QZNHGQhMyI/iLEi6RG2SGuSoPdi/S/AwD/ro9vfqxccuRunp1q+GVfVSIT4oLdKmIy7M/m
        etLMGLVpVvtvDujCYhosqjc4gcjEil0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-o1G4YMAHM26io01x9kBYYw-1; Wed, 18 Oct 2023 13:59:44 -0400
X-MC-Unique: o1G4YMAHM26io01x9kBYYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EE7610201E6;
        Wed, 18 Oct 2023 17:59:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A70502166B26;
        Wed, 18 Oct 2023 17:59:43 +0000 (UTC)
Date:   Wed, 18 Oct 2023 19:59:41 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] loopdev: fix losetup failure with a lost device file
Message-ID: <20231018175941.f2zysgnq4ibwoyvl@ws.net.home>
References: <20231012215524.44326-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012215524.44326-1-junxiao.bi@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi Junxiao,

On Thu, Oct 12, 2023 at 02:55:24PM -0700, Junxiao Bi wrote:
> +	sprintf(path, "/dev/loop%d", nr);
> +	/* default loop device permission is "brw-rw----" */
> +	umask(0003);
> +	ret = mknod(path, S_IFBLK|0660, makedev(major, minor));
> +	if (ret)
> +		return -1;

frankly, it will be challenging to convince me that using mknode in a
tool like losetup is a good idea. After all these decades, it's still
not a common practice (although I have see many attempts).  Nodes are
typically created by udevd by default, following udev rules.

IMHO, it's better to report the problem (perhaps with a helpful hint)
as error message and assume that the administrator will address it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


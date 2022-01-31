Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4858C433EF
	for <util-linux@archiver.kernel.org>; Mon, 31 Jan 2022 09:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiAaJzZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 31 Jan 2022 04:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232052AbiAaJzY (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jan 2022 04:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643622923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UUxTPRtxQPzm9tzkpbYXUJfzoS2W02GCXkmO6iOSJ0c=;
        b=I4SOPKpM/jmmUo/G8y5M5JvP+yd0cg46862QurTmx7iLru9RT2QyltQqgYiRWOCGx0KfVN
        Ga3qkN2NjytXsf+hZxvppG+l6JOxfdb/b1+NweEFljs9dNjY7++rstC/6gyuZZj3myUwPJ
        KiLIIHTwg2b1qtDL+NYPQVFW/k0vItU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-zrwcqrinP4aJxfpXPYj47w-1; Mon, 31 Jan 2022 04:55:21 -0500
X-MC-Unique: zrwcqrinP4aJxfpXPYj47w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E20CC1083F60;
        Mon, 31 Jan 2022 09:55:20 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E90D6E4D1;
        Mon, 31 Jan 2022 09:55:20 +0000 (UTC)
Date:   Mon, 31 Jan 2022 10:55:17 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: Add fstab option x-fstrim.notrim
Message-ID: <20220131095517.ngxxlu3vb74orljy@ws.net.home>
References: <823c644a-9eec-4832-0f52-e5e9419aad95@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823c644a-9eec-4832-0f52-e5e9419aad95@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 31, 2022 at 01:21:30AM +0100, Stanislav Brabec wrote:
> Sometimes it makes sense to skip fstrim for selected file mounts, but
> still be able to use fstrim.service.
> 
> Add a possibility to specify "x-fstrim.notrim" in fstab.

Good idea, but I've merged it with small change.

We need "X-fstrim.notrim", because x-* options are stored by libmount
in utab to be accessible for umount (etc.). This is expensive and
unnecessary for fstrim.

Thanks!

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


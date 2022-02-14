Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C44C433FE
	for <util-linux@archiver.kernel.org>; Mon, 14 Feb 2022 11:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351026AbiBNL2g (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:28:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351172AbiBNL2a (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 14 Feb 2022 06:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E23CBC77
        for <util-linux@vger.kernel.org>; Mon, 14 Feb 2022 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644836775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=E/YpHuLzrUWFj5TanGTnC9HK9BdBVrDfvGFNAraLJPY=;
        b=K8dWtsyHZgwuMtdUKYHtQDt9YqpFts7gV83CC1BPNdgcSiTWkaEgsrzxPKEi72JCtSf2zQ
        rd4251mFGiBJXHT8hS/ZDLDMzjRrnKUraeSHHsdTIEgXqT+RW6gKHFIQA6VlzPktBHhPDx
        eLGE1Es0h7jQGIecGWzibk1KQpDG4pU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-IGc_LG5PMPiiz7KszaeE2A-1; Mon, 14 Feb 2022 06:06:13 -0500
X-MC-Unique: IGc_LG5PMPiiz7KszaeE2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C186C1091DA1;
        Mon, 14 Feb 2022 11:06:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E81B66E1F8;
        Mon, 14 Feb 2022 11:06:11 +0000 (UTC)
Date:   Mon, 14 Feb 2022 12:06:09 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.37.4
Message-ID: <20220214110609.msiwlm457ngoic6w@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


The util-linux release v2.37.4 is available at
            
  http://www.kernel.org/pub/linux/utils/util-linux/v2.37/
 
Feedback and bug reports, as always, are welcomed.


This release fixes security issue in chsh(1) and chfn(8) when
util-linux compiled with libreadline.

CVE-2022-0563

  The readline library uses INPUTRC= environment variable to get a path
  to the library config file. When the library cannot parse the
  specified file, it prints an error message containing data from the
  file.

  Unfortunately, the library does not use secure_getenv() (or a similar
  concept), or sanitize the config file path to avoid vulnerabilities that
  could occur if set-user-ID or set-group-ID programs.


Note, this vulnerability has been reproduced on chfn(8), but this command
requires enabled CHFN_RESTRICT setting in /etc/login.defs. This setting 
may be disabled by default.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


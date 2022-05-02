Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA468C433EF
	for <util-linux@archiver.kernel.org>; Mon,  2 May 2022 13:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiEBNk2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 2 May 2022 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385334AbiEBNk0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 2 May 2022 09:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C886715822
        for <util-linux@vger.kernel.org>; Mon,  2 May 2022 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651498614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XynN5vA2TbXpQPKGLtCmjRxK24BTpVV/clMZh7rt9to=;
        b=MaLLch2onpsYvcJc9BXZGQgLYS0NG0LKWGl4F6wjIQ2rOs59me6XPVroZ//KuNVqw6y3US
        fmmCM5AV23ZqXorBK/49Qtayb7B8VgPoDGOJ1G4xv23bs7fr75UIf5NqwbUmgByWjPrOjw
        g7aVWhTI8agvUFpUcXcMmyaqnGGWpGk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-R9t_hgOwMC2oTMDcyy9ivw-1; Mon, 02 May 2022 09:36:51 -0400
X-MC-Unique: R9t_hgOwMC2oTMDcyy9ivw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 419D13C025D2;
        Mon,  2 May 2022 13:36:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B85FC40E7F06;
        Mon,  2 May 2022 13:36:50 +0000 (UTC)
Date:   Mon, 2 May 2022 15:36:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: logger: invalid structured data parameter: 'fo\o="b\"a\"r"'
Message-ID: <20220502133648.dbztxenhvc3n2sde@ws.net.home>
References: <626FB419020000A100049B7A@gwsmtp.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <626FB419020000A100049B7A@gwsmtp.uni-regensburg.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 02, 2022 at 12:36:09PM +0200, Ulrich Windl wrote:
> Hi!
> 
> Testing my syslogd that was extended to handle RFC 5424 type messages, I found
> out that
> 
> --sd-param 'fo\o="bar"'
> 
> would work, but
> 
> --sd-param 'fo\o="b\"a\"r"'
> 
> won't. Reading RFC 5424, I guess that using \" in PARAM-VALUE is OK (passing a
> literal "):
> 
> On page 16, 6.3.3.:
>    Inside PARAM-VALUE, the characters ’"’ (ABNF %d34), ’\’ (ABNF %d92),
>    and ’]’ (ABNF %d93) MUST be escaped.  This is necessary to avoid
>    parsing errors.
> 
> So I guess if " miust be escaped, it's allowed to be escaped (to pass a
> literal ").
> 
> Found in util-linux-systemd-2.33.2-4.18.1.x86_64 of SLES12 SP5.
> Still present in util-linux-systemd-2.36.2-150300.4.20.1.x86_64 of SLES15
> SP3.

Fixed by commit:
https://github.com/util-linux/util-linux/commit/6ab10df254c62e1abf962a8756c0cd4aa333a47f

Thanks for your report.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


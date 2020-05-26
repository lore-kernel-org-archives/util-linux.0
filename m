Return-Path: <SRS0=W0VW=7I=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83900C433DF
	for <util-linux@archiver.kernel.org>; Tue, 26 May 2020 08:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1BA2073B
	for <util-linux@archiver.kernel.org>; Tue, 26 May 2020 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtBeV01b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgEZIu7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 May 2020 04:50:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54665 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725771AbgEZIu7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 26 May 2020 04:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590483057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BT5SK86viIVsr/ZkKwRHjGHZVnHdVL9Rm6NER+dw5HE=;
        b=UtBeV01bCIN5fsLd03y1XfmP7CQDchBdj3EZb7fzx55aJdEuZtHhxbD6/c6nFlNVFsPMJ3
        2oE8BYZAaJ1z+2VP9RBxPAEdfV8IDZgYxOTv/j/vWohMIIl4jhNipZFBEDgJDx4vvFr0Rs
        heybUiyLg2J5jRG6M3phv+lDrJXX8LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-kzd4dqfuMIKNIx9Ua8ZcVA-1; Tue, 26 May 2020 04:50:53 -0400
X-MC-Unique: kzd4dqfuMIKNIx9Ua8ZcVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6285F800688;
        Tue, 26 May 2020 08:50:52 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E9741968F;
        Tue, 26 May 2020 08:50:51 +0000 (UTC)
Date:   Tue, 26 May 2020 10:50:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/9] Manual pages: nsenter.1, unshare.1: update
 references to *_namespaces(7) pages
Message-ID: <20200526085048.23ue2dcz7cvc5wx7@ws.net.home>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
 <20200525121745.rmdn47zlchtf76fh@ws.net.home>
 <4d4bb487-4a9c-1fcb-71a6-059379597d15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d4bb487-4a9c-1fcb-71a6-059379597d15@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 25, 2020 at 03:13:18PM +0200, Michael Kerrisk (man-pages) wrote:
> A follow-up question. There was one piece of the unshare(1) examples
> that I did not try to rework, because I simply don't understand it:
> v
>        Establish  a  persistent  mount  namespace  referenced by the bind
>        mount /root/namespaces/mnt.  This example shows a  portable  solu‐
>        tion,  because  it  makes sure that the bind mount is created on a
>        shared filesystem.
> 
>            # mount --bind /root/namespaces /root/namespaces
>            # mount --make-private /root/namespaces
>            # touch /root/namespaces/mnt
>            # unshare --mount=/root/namespaces/mnt
> 
> I think you wrote this example. What does the sentence "This example shows
> a portable solution, because it makes sure that the bind mount is created
> on a shared filesystem" mean? I think this needs clarification, and I'd try
> to do so, but it's not clear to me what the sentence is trying to say.

Hmm... it should be "the /root/namespaces/mnt is on a private
filesystem". The important thing is --make-private in this case,
because for example on Fedora we use "shared" propagation flag for
root FS and without bind + make-private you will be unsuccessful. The
example makes it portable between distros.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


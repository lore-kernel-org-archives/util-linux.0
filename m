Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A11EB64DD
	for <util-linux@archiver.kernel.org>; Wed,  9 Aug 2023 10:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjHIKhb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 9 Aug 2023 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHIKhb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 9 Aug 2023 06:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A428E4A
        for <util-linux@vger.kernel.org>; Wed,  9 Aug 2023 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691577401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8rPMpZJPdKUcctCp8kXUv9myVzmbQkpIFDy1QVsj9U=;
        b=hUnU0bcLfws932s8lft7VoURZCV2O2uyaEeQaD4b/3Hd/ctj44gEXIabcM7QgnBuqO45G4
        jbmt5aqIHIGr5j7/ZG7iH72KthgjXo9Wxh0n189nxxNI9jNZocN3TIPKNupAHBiIMeOTEm
        ZgXHyFkUTOVk2kBYNTh6GOh5ahs0K34=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-YwufQa-UNWqJmJCbD8I2AQ-1; Wed, 09 Aug 2023 06:36:37 -0400
X-MC-Unique: YwufQa-UNWqJmJCbD8I2AQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F3EC1C05EB2;
        Wed,  9 Aug 2023 10:36:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B9B4492C3E;
        Wed,  9 Aug 2023 10:36:36 +0000 (UTC)
Date:   Wed, 9 Aug 2023 12:36:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     John David Anglin <dave@parisc-linux.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix build on hppa
Message-ID: <20230809103634.jogwiltnwnbg62j6@ws.net.home>
References: <ZNEPrah0JvjV24vw@mx3210.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEPrah0JvjV24vw@mx3210.localdomain>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Aug 07, 2023 at 03:37:17PM +0000, John David Anglin wrote:
> --- ./include/audit-arch.h.save	2023-08-03 20:42:00.937401304 +0000
> +++ ./include/audit-arch.h	2023-08-03 20:53:40.755627981 +0000

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


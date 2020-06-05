Return-Path: <SRS0=WsHy=7S=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119E7C433DF
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 07:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B3D2053B
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 07:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OD+6O92a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFEHqC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:46:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37386 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726099AbgFEHqC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 5 Jun 2020 03:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591343161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BoTrkALCtgbioecva2JUbG85sfVYi+q0bInt5IQwyVI=;
        b=OD+6O92aj7XSKmDG/8X5IH53ils0S/AtKZ1MzTt9LS379cDe13cSald7Sqek/VZS1XUizc
        +walcT36oeTc1YnNpAr+PCSFSFE1UlEE7DYakD0eqIMVdgFHhz3LKIWumCChfJ5uEUBEIo
        XVVaqxrbpjQ0kH0qcQ7HjttG16dIdog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-QUb0ZFrNNCSr2kzrm8Q3dg-1; Fri, 05 Jun 2020 03:45:58 -0400
X-MC-Unique: QUb0ZFrNNCSr2kzrm8Q3dg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E59A100A8EC;
        Fri,  5 Jun 2020 07:45:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90FEE5D9D7;
        Fri,  5 Jun 2020 07:45:56 +0000 (UTC)
Date:   Fri, 5 Jun 2020 09:45:53 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     util-linux@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blkzone: Add --force option
Message-ID: <20200605074553.bsepxxwzk4zhhh4r@ws.net.home>
References: <20200605050618.591153-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605050618.591153-1-shinichiro.kawasaki@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 05, 2020 at 02:06:18PM +0900, Shin'ichiro Kawasaki wrote:
> Also fix missing initialization and too many periods in man page of
> --verbose option.
 
The initialization is not missing :-)

> @@ -382,12 +387,15 @@ int main(int argc, char **argv)
>  		.count = 0,
>  		.length = 0
>  	};
> +	ctl.force = 0;
> +	ctl.verbose = 0;

This is unnecessary.

According to C standard all subobjects that are not initialized
explicitly shall be initialized implicitly the same as objects that
have static storage duration. (C11 standard, 6.7.8 Initialization).

For example: 

 struct A {
    int x, y, z;
 };

 struct A foo = { .x = 0 };

means that foo.y as well as foo.z are zero.

You can see this pattern pretty often our code.


Anyway, your patch has been merged (with tiny changes). Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


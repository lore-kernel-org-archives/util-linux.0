Return-Path: <SRS0=FFMN=C6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFDCC43463
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DE821789
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu1/t80c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgIUNIy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbgIUNIx (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Sep 2020 09:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600693733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GaD2AGl/WJiWbA7IeZZgv0XcauxdotZYUkSnayFDr4=;
        b=Pu1/t80c8oJs1JYmM9OyEn5OY/9nJNmnHpe99/CZ1dew4uGp6tM3FyVN3XJYBUZqN+jRib
        sgFYju/X79YaxLo7k/y+QdPuL8vF1/M+XW4CZbX/P0djmGeEjibMCaWeOnH9ShZgVZDOCe
        F96HR+pCHxWsBf43Mt9rX/mziNwN0Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-VXienh2_PaqOwc2o-e4Tlg-1; Mon, 21 Sep 2020 09:08:49 -0400
X-MC-Unique: VXienh2_PaqOwc2o-e4Tlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F5251091067;
        Mon, 21 Sep 2020 13:08:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49B3360C13;
        Mon, 21 Sep 2020 13:08:47 +0000 (UTC)
Date:   Mon, 21 Sep 2020 15:08:44 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Lennard Hofmann <lennard.hofmann@web.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] column: Deprecate --table-empty-lines in favor of
 --keep-empty-lines
Message-ID: <20200921130844.zrulvqcc44ee6zxz@ws.net.home>
References: <20200920130818.29756-1-lennard.hofmann@web.de>
 <20200920130818.29756-2-lennard.hofmann@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200920130818.29756-2-lennard.hofmann@web.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Sep 20, 2020 at 03:08:18PM +0200, Lennard Hofmann wrote:
> +.IP "\fB\-L, \-\-keep\-empty\-lines\fP"
> +Preserve whitespace-only lines in the input. The default is ignore empty lines
> +at all. This option’s original name was \-\-table-empty-lines but is now
> +deprecated because it gives the false impression that the option only applies
> +to table mode.

Please update also usage() (--help output) where we do not need --table-empty-lines
anymore.

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


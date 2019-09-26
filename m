Return-Path: <SRS0=uN1w=XV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F63AC4360C
	for <util-linux@archiver.kernel.org>; Thu, 26 Sep 2019 21:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72B9222C2
	for <util-linux@archiver.kernel.org>; Thu, 26 Sep 2019 21:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fifth.space header.i=@fifth.space header.b="wVhIizZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfIZVfC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:35:02 -0400
Received: from fifth.space ([45.32.148.28]:22523 "EHLO fifth.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfIZVfC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 26 Sep 2019 17:35:02 -0400
Received: from fifth.space (localhost [127.0.0.1])
        by fifth.space (OpenSMTPD) with ESMTP id aee381d9
        for <util-linux@vger.kernel.org>;
        Thu, 26 Sep 2019 23:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=fifth.space; h=date:from
        :to:subject:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=dkim; bh=2HdZPoXr4g+8
        IJYesV8AHvz237M=; b=wVhIizZhcFfhcPCf9Z+M4EI0td3BMdsh2s9v7cdb4fl0
        txa6n5P2/bkpPFKbhffZBRjiMjMTANCtDRqP0ZsEB4+fjpPacsauNmn2dWyOXgcq
        lxbAM9LcukPIRQOpbIMQR3vohcnt/c2v2LaLWlfZgUscLMIoX4F0o7day6ZiZO/l
        AEON+SS4a8lhYWJe0Ysnc55Svd7XTVkKNei72PPG/CikV4fiFzTgUSzwp5U4qc7i
        UFqqru73331A8Hp9BkR9T/oyNvAIWxgoQU97y29VlvvkssUwnN5jlBuOmAY2qlcx
        5iUtIiFk6uP4CiT+KFsu2bKo33buBLFSvyLnYbk2rw==
DomainKey-Signature: a=rsa-sha1; c=nofws; d=fifth.space; h=date:from:to
        :subject:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=dkim; b=XohbF1
        IBQA5d3LcfZK84pCCpRb9pih68/uClqYtKJEZv/Z24ByrwzA10Gzntm8fAEuIc1q
        w9G+EV/QpvQUdo/p/VkMQ8XTeA3yp4pnIwHWYKpXLOqH9vP/dwZJlo06q7Eq+uRn
        B7vKMTj5HZcZ4rijNknDiwE9IRJZcAIfjTYoMsSGaipOZefz/itf70js2PFF8Vd+
        u3TJStfF1jBCzyr3U0meD2oYdPsWoGdc6AS3yR+lmHtng6E+p8mPbeL3O1Gs1ieQ
        khrofdyVRMYsYZEvXDc6/3cDaAXFKMkosaYV3Jd4QBfagzRae+pr41F4N3vAhLXk
        6gtSTtKeG1BsPeuw==
Received: from localhost.localdomain (<unknown> [IPv6:2a01:e34:ecae:2d51:21f0:3e05:65bc:2808])
        by fifth.space (OpenSMTPD) with ESMTPSA id ea676906 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <util-linux@vger.kernel.org>;
        Thu, 26 Sep 2019 23:34:59 +0200 (CEST)
Date:   Thu, 26 Sep 2019 23:34:55 +0200
From:   Quentin Rameau <quinq@fifth.space>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix chsh when called as root
Message-ID: <20190926233455.7e17ea54@fifth.space>
In-Reply-To: <20190926135759.g243df5agf7zdcd4@10.255.255.10>
References: <20190921185021.10568-1-quinq@fifth.space>
        <20190926135759.g243df5agf7zdcd4@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

> > Because chsh was using getpwuid/getpwnam, there was an issue with
> > subsequent call to readline with tilde expansion which would also call
> > the same function and overwrite the getpwuid/getpwnam internal storage
> > struct passwd, replacing passed username results.
> 
> Applied, thanks.

Thank you!

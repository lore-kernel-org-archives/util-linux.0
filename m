Return-Path: <SRS0=VVbZ=YE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635BC47404
	for <util-linux@archiver.kernel.org>; Fri, 11 Oct 2019 08:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D982190F
	for <util-linux@archiver.kernel.org>; Fri, 11 Oct 2019 08:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfJKINN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:13:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47261 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfJKINN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 11 Oct 2019 04:13:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4651518CB8E0;
        Fri, 11 Oct 2019 08:13:13 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59CE5600C4;
        Fri, 11 Oct 2019 08:13:12 +0000 (UTC)
Date:   Fri, 11 Oct 2019 10:13:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     util-linux@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] lscpu: Add HiSilicon aarch64 tsv110 cpupart
Message-ID: <20191011081309.hnlcgajvt2ut7uej@10.255.255.10>
References: <1570540341-233493-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570540341-233493-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 08:13:13 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Oct 08, 2019 at 09:12:21PM +0800, John Garry wrote:
> Add an entry for the HiSilicon aarch64 part tsv110.
> 
> Another known alias for this part is TaishanV110, and it can be
> found in the Kunpeng920/Hi1620 SoC.

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

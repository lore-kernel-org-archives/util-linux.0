Return-Path: <SRS0=QJpf=XF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E90C3A5A2
	for <util-linux@archiver.kernel.org>; Tue, 10 Sep 2019 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC4520872
	for <util-linux@archiver.kernel.org>; Tue, 10 Sep 2019 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfIJKlR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfIJKlR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Sep 2019 06:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED637308C38B;
        Tue, 10 Sep 2019 10:41:16 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-73.brq.redhat.com [10.40.204.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37ED85D6B2;
        Tue, 10 Sep 2019 10:41:16 +0000 (UTC)
Date:   Tue, 10 Sep 2019 12:41:13 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (gpt) add GUID for APFS containers
Message-ID: <20190910104113.ef3kkaqtjewot7gy@10.255.255.10>
References: <20190909205907.alytemtibvk4kv37@eaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909205907.alytemtibvk4kv37@eaf>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 10 Sep 2019 10:41:17 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Sep 09, 2019 at 05:59:07PM -0300, Ernesto A. Fernández wrote:
>  libfdisk/src/gpt.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F57C43461
	for <util-linux@archiver.kernel.org>; Wed, 14 Apr 2021 14:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE5961220
	for <util-linux@archiver.kernel.org>; Wed, 14 Apr 2021 14:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhDNOLE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 14 Apr 2021 10:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232557AbhDNOLD (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Apr 2021 10:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618409441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4ByqTfXJ8k+NvlvYhIt4aLMU+a1YsezIFT8EQWJI2k=;
        b=clBeoSBC7x/gKXTh35O0BUa1cFtMIHK0Egiik5Wz92ukPh6eU6HilV2W7uqIMXlcvOu/+J
        a0YkMzHnAHkSUvX17T4Nvz2+SCW7NQ+0lUbUpfIhb5BqYLOVElZ62q2J1BHNVROEeR940w
        cY8/N7/ATMgmIx7HB5912+6M338SFgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-rXG25RV7Mkas5mSNzxTU0g-1; Wed, 14 Apr 2021 10:10:26 -0400
X-MC-Unique: rXG25RV7Mkas5mSNzxTU0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24B3A83DD2B;
        Wed, 14 Apr 2021 14:09:50 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADEFC19D9B;
        Wed, 14 Apr 2021 14:09:48 +0000 (UTC)
Date:   Wed, 14 Apr 2021 16:09:46 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 0/3] implement zone-aware probing/wiping for zoned
 btrfs
Message-ID: <20210414140946.j57uo7kvlfkpwsz3@ws.net.home>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414013339.2936229-1-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 14, 2021 at 10:33:36AM +0900, Naohiro Aota wrote:
> This series implements probing and wiping of the superblock of zoned btrfs.

I have no disk with zones support, but it seems scsi_debug supports
it. Do you have any step by step example how to test with btrfs? If
yes, I will add a test to our test suite.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


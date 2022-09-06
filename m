Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2EFECAAA1
	for <util-linux@archiver.kernel.org>; Tue,  6 Sep 2022 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbiIFQsA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 6 Sep 2022 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiIFQre (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 6 Sep 2022 12:47:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1213E1174
        for <util-linux@vger.kernel.org>; Tue,  6 Sep 2022 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662481867; x=1694017867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=abtml6zPnbNJgpcjqf0NQj2gVM9ZRL8DWFY03VFz2DI=;
  b=Lck3QuwLb3zfHc69uppZc+ElnPyiUhNRZCCbK6/6Vev8pCNpPn8Owos2
   nDQR9BhRyj2E90NTY18jg1ymC7oYRZ2dxzNKIjMgRzT6/ipspeA4487hE
   FxrEc3k773vjjGwEWlenFmg1Wl5e6lY5ZLmxChx6Du7nd6brk6FJPMH4Z
   Waqwk7j7s+xXKlSRhJijWVy33d9DQXAnJf0hjekXMZQoyYWa+X3MaF0/I
   cBfcBlLbJQV3/vaVHM7/yMaK4m0CKzZJfjW4frh/H5vBizyOA/KoXBiLi
   k08KrOqethlqYuh+YEW6lAl5up+tGexpbovS3oLt7et4qmKY5uzfNvLH9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279653978"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279653978"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 09:31:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942520462"
Received: from cphenegh-mobl.ger.corp.intel.com (HELO [10.252.31.69]) ([10.252.31.69])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 09:31:05 -0700
Message-ID: <849c4ca2-a1b7-7429-1b3c-fc135d9f4d72@linux.intel.com>
Date:   Tue, 6 Sep 2022 19:31:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH] lib/timeutils: Add %s (seconds since the Epoch) to
 parse_timestamp()
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20220906070436.684-1-peter.ujfalusi@linux.intel.com>
 <20220906084716.4bgsdahoyjfaaksc@ws.net.home>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220906084716.4bgsdahoyjfaaksc@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,

On 06/09/2022 11:47, Karel Zak wrote:
> On Tue, Sep 06, 2022 at 10:04:36AM +0300, Peter Ujfalusi wrote:
>>  lib/timeutils.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
> 
> Applied, thanks.

After some tinkering with a script where I needed this, would it make
sense to change the way how one should be specifying seconds since the
Epoch time to
'@'<number>

This would match how for example systemd.time requires it [1]

Basically I (or anyone) can use dmesg instead of journalctl in a script
with the same --since=@<timestamp> parameter.

'date +%s' prints out just a number.

If not, then I have made a rookie mistake with the patch, which should
be fixed (discarding the seconds we got out from the timestamp).
/me hides

[1] https://www.man7.org/linux/man-pages/man7/systemd.time.7.html

-- 
Péter

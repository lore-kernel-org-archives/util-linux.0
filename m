Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B3C6FA82
	for <util-linux@archiver.kernel.org>; Tue, 13 Sep 2022 11:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiIML04 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 13 Sep 2022 07:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiIML0y (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 13 Sep 2022 07:26:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356194D4C2
        for <util-linux@vger.kernel.org>; Tue, 13 Sep 2022 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663068414; x=1694604414;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I8vRCtxj4jxQN2KTEJXV006kSoH3xaN1FVbhEItjC4s=;
  b=HABxnJADhkK7o2hsv8oUHbxDHvT3zZphlB9J9HgeAWQveHv5HC7UBxZU
   3/ouoTd5PP47CjAuEDw0cEJFhl0UwEfprgWkKP71gWbZiavsSvOU9EL8g
   prnFwryD73Z/c3ta1JMZixfuBjkoMuCjQmbFgcySePWKqTRr3V87UROB+
   Dzy9STCWPmyEvaGNHwLJ0tch8oc7lIK5gObv6m/QxPhTulHkEnE3CLP+a
   HW1ecDL3wlfU4EACgrrj2yPIZIBmlLEmrDPHTXm+qxqvyHNTcUdY7RjrI
   UD2CVDZQWioteRdkHb6ujQrdOYR5wZncOKPfEQrr9VTOyMo9xy1Pp8/XC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="299451054"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="299451054"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 04:26:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="593901610"
Received: from rreill2x-mobl.ger.corp.intel.com (HELO [10.252.15.189]) ([10.252.15.189])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 04:26:52 -0700
Message-ID: <b89d8afb-75fb-8917-cb13-dff5fc589ae7@linux.intel.com>
Date:   Tue, 13 Sep 2022 14:26:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH] lib/timeutils: Require '@' prefix for seconds since the
 Epoch timestamp
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20220907054141.15608-1-peter.ujfalusi@linux.intel.com>
 <20220912122337.nmoc7tpzuxes4ejj@ws.net.home>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220912122337.nmoc7tpzuxes4ejj@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On 12/09/2022 15:23, Karel Zak wrote:
> On Wed, Sep 07, 2022 at 08:41:41AM +0300, Peter Ujfalusi wrote:
>>  lib/timeutils.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> Applied, let's use '@' prefix :-) Thanks.

I will try to look at documenting the supported time formats within
util-linux...

My guess would be to add a new file:
man-common/timestamp-formats.adoc

and link it in dmesg for example?

> 
>     Karel
> 

-- 
Péter

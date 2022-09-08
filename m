Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A05C38145
	for <util-linux@archiver.kernel.org>; Thu,  8 Sep 2022 09:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiIHJ3V (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 8 Sep 2022 05:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIHJ3T (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Sep 2022 05:29:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E276CFBF0B
        for <util-linux@vger.kernel.org>; Thu,  8 Sep 2022 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662629356; x=1694165356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7kfa6VN0nFF5WeD1cw6m2QFmDl6mX1M/4cfOo9osLys=;
  b=kzZVKrlQkWzfYpIROwDanvkfvlcZ5CyPnMR6YIxKB0mYuM776JpiJsKJ
   NvECt5sNrKoQsRTN3pZ7tcqAfsBtpna4RZmXfCqAoeshaFsmqalNx3cgY
   itsS9tkNlgjCrWQR3fTlqc3FAFTXiQjwIO4VjljkPakpCbGwJBpMLAmPd
   W0hJ2RJTqQSAwzSBGM1e7neiYsKVPP95MSL2D72CwN+fKhVNvQmsF0S8j
   GY542bTYx67JIJor9xDppqNnrSqJxcjEiu+rSzqfgM09YxY5wCyEV2Z7c
   QD1hbwE1KpJBAg7YoTWMgqjmfWlcOdgsX2WWBw4npP1tUhHV8g0abSpH0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="358852170"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="358852170"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 02:29:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="610630094"
Received: from rnicolau-mobl1.ger.corp.intel.com (HELO [10.252.15.201]) ([10.252.15.201])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 02:29:14 -0700
Message-ID: <613a861f-7af9-df43-9863-dd869bcef9e0@linux.intel.com>
Date:   Thu, 8 Sep 2022 12:29:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH] lib/timeutils: Add %s (seconds since the Epoch) to
 parse_timestamp()
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20220906070436.684-1-peter.ujfalusi@linux.intel.com>
 <20220906084716.4bgsdahoyjfaaksc@ws.net.home>
 <849c4ca2-a1b7-7429-1b3c-fc135d9f4d72@linux.intel.com>
 <20220907072048.5buz33o2df5cvdiw@ws.net.home>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220907072048.5buz33o2df5cvdiw@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On 07/09/2022 10:20, Karel Zak wrote:
> On Tue, Sep 06, 2022 at 07:31:07PM +0300, Péter Ujfalusi wrote:
>> On 06/09/2022 11:47, Karel Zak wrote:
>>> On Tue, Sep 06, 2022 at 10:04:36AM +0300, Peter Ujfalusi wrote:
>>>>  lib/timeutils.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>
>>> Applied, thanks.
>>
>> After some tinkering with a script where I needed this, would it make
>> sense to change the way how one should be specifying seconds since the
>> Epoch time to
>> '@'<number>
> 
> Yes, '@' seems more readable. I have no strong opinion about it, maybe
> we can support both convention (with and without @).
> 
> Anyway, we really need to add something like "INPUT TIMESTAMP" section
> to the man page to describe supported formats.
> 
>> This would match how for example systemd.time requires it [1]
>>
>> Basically I (or anyone) can use dmesg instead of journalctl in a script
>> with the same --since=@<timestamp> parameter.
>>
>> 'date +%s' prints out just a number.
> 
> It's possible to use --since=$(date +'@%s')
> 
>> If not, then I have made a rookie mistake with the patch, which should
>> be fixed (discarding the seconds we got out from the timestamp).
> 
> Do you mean your copy & past tm.tm_sec = 0;? This should be fixed.
> 
>> /me hides
> 
> Come back and send a patch :-)

I have sent a fix patch which requires @ as a prefix and keeps the
seconds intact:
https://lore.kernel.org/util-linux/20220907054141.15608-1-peter.ujfalusi@linux.intel.com/T/#u

-- 
Péter

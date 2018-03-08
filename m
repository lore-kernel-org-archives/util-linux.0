Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbeCHVnx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 8 Mar 2018 16:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CE2080F8F
        for <util-linux@vger.kernel.org>; Thu,  8 Mar 2018 21:43:53 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [PATCH 1/1] libblkid: ignore private Stratis devices
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20180305185611.16667-1-tasleson@redhat.com>
 <20180305185611.16667-2-tasleson@redhat.com>
 <20180306111956.o3pyv3vjld6ye462@ws.net.home>
From: Tony Asleson <tasleson@redhat.com>
Message-ID: <21086c3d-1e26-2bb8-644d-769a4e647479@redhat.com>
Date: Thu, 8 Mar 2018 15:43:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180306111956.o3pyv3vjld6ye462@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/06/2018 05:19 AM, Karel Zak wrote:
> On Mon, Mar 05, 2018 at 12:56:11PM -0600, Tony Asleson wrote:
>> +		} else if (strncmp(id, "stratis-", 8) == 0) {
>> +			/* Private Stratis devices will be those that start with "stratis-"
>> +			 * and that do not match the expected pattern for a thinly
>> +			 * provisioned device.
>> +			 */
>> +			if (!regcomp(&re,
>> +						"^stratis-1-[0-9a-f]{32}-thin-fs-[0-9a-f]{32}$",
>> +						REG_EXTENDED)) {
>> +				if (REG_NOMATCH == regexec(&re, id, 0, NULL, 0))
>> +					rc = 1;
>> +
>> +				regfree(&re);
>> +			}
> 
> regcomp() ... would be possible to identify the device by any other
> way? It would be nice to keep the code simple and stupid.
> 
> BTW, why you do not use any special prefix for the private device?

Very good question, we've updated dm/uuid and dm/name to have the prefix
signature "stratis-1-private" if the device is to be ignored.

Please see v2 for simplified change.

Thank you!

-Tony

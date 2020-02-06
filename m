Return-Path: <SRS0=rU+A=32=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0A1C35247
	for <util-linux@archiver.kernel.org>; Thu,  6 Feb 2020 23:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156A1214AF
	for <util-linux@archiver.kernel.org>; Thu,  6 Feb 2020 23:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgBFXIy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:08:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:21892 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgBFXIy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Feb 2020 18:08:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 15:08:54 -0800
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="scan'208";a="220603177"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.78.25.164])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2020 15:08:53 -0800
Subject: Re: Re: [RFC] utility for SED management
To:     Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <20190614074828.iqgomebc6gilprkn () ws ! net ! home>
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <4f66147e-8938-2fa2-b9ce-b92915798c70@linux.intel.com>
Date:   Thu, 6 Feb 2020 16:08:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20190614074828.iqgomebc6gilprkn () ws ! net ! home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 6/14/19 12:48 AM, Karel Zak wrote:
> On Thu, Jun 13, 2019 at 01:51:12PM +0000, Jakowski, Andrzej wrote:
>> On Wed, Jun 12, 2019 at 01:40:08PM +0000, Karel Zak wrote:
>>>  From my point of view (and maybe I'm wrong ;-)) it seems complex enough to keep it as an independent stand-alone project ("sed-utils").
>>> Not sure if it makes sense to push it to generic util-linux package.
>> It sounds to me that your major concern for inclusion sedcli into util-linux is
>> its complexity. What would be the best method to understand if sedcli fits into
>> util-linux?
> Do you have the current code/repo with sedcli accessible anywhere? It
> would be nice to see it.
> 
>      Karel

Trying to resurect that thread.
Code has been published on github:
https://github.com/sedcli/sedcli

Andrzej

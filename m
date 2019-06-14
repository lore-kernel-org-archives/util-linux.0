Return-Path: <SRS0=Z60+=UN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E49C31E44
	for <util-linux@archiver.kernel.org>; Fri, 14 Jun 2019 09:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DE120866
	for <util-linux@archiver.kernel.org>; Fri, 14 Jun 2019 09:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFNJBR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:01:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:52350 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfFNJBR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 14 Jun 2019 05:01:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 02:01:16 -0700
X-ExtLoop1: 1
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.15.131])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2019 02:01:15 -0700
Subject: Re: [RFC] utility for SED management
To:     Karel Zak <kzak@redhat.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <548EA37F71F6AC4BB746F459732504FF7F1810E3@FMSMSX119.amr.corp.intel.com>
 <20190612134005.cb7m2qhgf2aolrf6@ws.net.home>
 <548EA37F71F6AC4BB746F459732504FF7F184907@FMSMSX119.amr.corp.intel.com>
 <20190614074828.iqgomebc6gilprkn@ws.net.home>
From:   Andrzej Jakowski <andrzej.jakowski@intel.com>
Message-ID: <608c1dad-09a0-8bb9-bc55-d01e136bc0b5@intel.com>
Date:   Fri, 14 Jun 2019 11:01:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614074828.iqgomebc6gilprkn@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 6/14/19 9:48 AM, Karel Zak wrote:
> Do you have the current code/repo with sedcli accessible anywhere? It
> would be nice to see it.
> 
>      Karel

Code is still work-in-progress on non-public repo. I will let you know 
once available.


Andrzej

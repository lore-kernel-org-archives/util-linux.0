Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C74DC388F7
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 05:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1776720795
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 05:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgKJFTK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Nov 2020 00:19:10 -0500
Received: from foss.arm.com ([217.140.110.172]:50760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbgKJFTK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Nov 2020 00:19:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A79031B;
        Mon,  9 Nov 2020 21:19:09 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E8103F719;
        Mon,  9 Nov 2020 21:19:09 -0800 (PST)
To:     util-linux@vger.kernel.org
Cc:     Jeffrey Bastian <jbastian@redhat.com>, msys.mizuma@gmail.com,
        m.mizuma@jp.fujitsu.com
From:   Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 2/2] lscpu-arm: Remove hard corded model name of Cortex
 family and X-Gene
Message-ID: <201fdf4b-5238-6e39-8883-f1ba0dbca4a5@arm.com>
Date:   Mon, 9 Nov 2020 23:19:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

(sorry about the threading problem, I wasn't a linux-util subscriber)

It appears you are removing much of the hard coded cpu part number lists.

I don't agree with this, I think the hard coded table should be the 
first authority on the manufacture/part number lists. That is because 
SMBIOS isn't available on a fairly large number of arm systems, and on 
systems where it does exist, it suffers from the same kinds of problems 
that exist on many !arm machines. Its not particularly a reliable source 
of information.

So, maybe if you have a situation where the SMBIOS information is more 
correct than the hardcoded tables, maybe its a good idea to create a new 
line?


Aka:

Vendor Id: ARM
Model Name: Cortex-A57
BIOS Name: JoeSmithsCore


In the vast majority of cases I imagine the strings should match. The 
problematic cases are LTS os's running on newer hardware. For that i'm 
somewhat of the opinion the Model Name should remain "unknown" rather 
than being silently updated. That is to avoid cases where the output 
from newer lscpu's changes during an upgrade.

PS, Having this hardcoded table isn't optimal, but for now I think we 
are stuck with it. Hopefully at some point we can work out a reliable 
way to source the info. In the meantime, it looks like I need to submit 
some table updates, since there are some newer arm models...


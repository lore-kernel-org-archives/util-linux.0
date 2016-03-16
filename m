Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp08.in.ibm.com ([125.16.236.8]:38838 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbcCPFg4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Mar 2016 01:36:56 -0400
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <hegdevasant@linux.vnet.ibm.com>;
	Wed, 16 Mar 2016 11:06:54 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2G5ZDvs49021120
	for <util-linux@vger.kernel.org>; Wed, 16 Mar 2016 11:05:13 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2G5ZXLD018352
	for <util-linux@vger.kernel.org>; Wed, 16 Mar 2016 11:05:34 +0530
Subject: Re: [PATCH 2/2] lscpu: use cpu and revision tag if available
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1458055880-18766-1-git-send-email-sweet_f_a@gmx.de>
 <1458055880-18766-2-git-send-email-sweet_f_a@gmx.de>
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Message-ID: <56E8F0A2.4040209@linux.vnet.ibm.com>
Date: Wed, 16 Mar 2016 11:05:30 +0530
MIME-Version: 1.0
In-Reply-To: <1458055880-18766-2-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/15/2016 09:01 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Avoid ifdef which does not work with --sysroot. Our existing test
> dumps produce even better output now for ppc and sparc.
>
> CC: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>

Ruediger,

Thanks for the fix. Patch looks good. I've tested on Power system and it works fine.

Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>


-Vasant


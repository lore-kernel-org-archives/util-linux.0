Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp04.in.ibm.com ([125.16.236.4]:39940 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbcCRFdD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Mar 2016 01:33:03 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <hegdevasant@linux.vnet.ibm.com>;
	Fri, 18 Mar 2016 11:02:59 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2I5WuQD33751220
	for <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 11:02:57 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2I5Ws2M018452
	for <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 11:02:55 +0530
Subject: Re: [PATCH 2/3] lscpu: use cpu and revision tag if available
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1458130699-25464-1-git-send-email-sweet_f_a@gmx.de>
 <1458130699-25464-3-git-send-email-sweet_f_a@gmx.de>
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Message-ID: <56EB9302.9060302@linux.vnet.ibm.com>
Date: Fri, 18 Mar 2016 11:02:50 +0530
MIME-Version: 1.0
In-Reply-To: <1458130699-25464-3-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/16/2016 05:48 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Avoid ifdef which does not work with --sysroot. Our existing test
> dumps produce even better output now for ppc and sparc.
>
> The logic moved to the printing section.
>
> CC: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>

Looks good. Tested on Power8 system and it works fine.

-Vasant


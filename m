Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63578 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753368AbdDQJAz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Apr 2017 05:00:55 -0400
Subject: Re: [PATCH]lscpu: Read available CPUs max and min frequencies
References: <149241772437.12614.9759492302686190446.stgit@localhost.localdomain>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
To: mamatha4@linux.vnet.ibm.com, util-linux@vger.kernel.org
Message-ID: <de6f8c47-b5ff-a1a6-da61-9776bb0cc6a3@gmx.de>
Date: Mon, 17 Apr 2017 11:00:50 +0200
MIME-Version: 1.0
In-Reply-To: <149241772437.12614.9759492302686190446.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/17/2017 10:30 AM, Mamatha Inamdar wrote:
> Problem: On power syatems "lscpu frequency-info" command was always
> reading CPU0 max and min frequencies. If CPU0 is guarded or offline
> then it used to display max and min frequencies as NULL.
>
> Solution: This patch will check for the available/online CPUs
> and read the max/min frequencies of that CPU

Maybe we could do it even more generically, not letting the first lookup 
win but really using the minimum/maximum over *all* CPUs. Who knows, 
maybe different cores could have different min/max.

cu,
Rudi

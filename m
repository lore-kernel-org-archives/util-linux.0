Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755286AbdDRKbn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Apr 2017 06:31:43 -0400
Date: Tue, 18 Apr 2017 12:31:38 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: mamatha4@linux.vnet.ibm.com, util-linux@vger.kernel.org
Subject: Re: [PATCH]lscpu: Read available CPUs max and min frequencies
Message-ID: <20170418103138.p7zqetpaq4wkym3h@ws.net.home>
References: <149241772437.12614.9759492302686190446.stgit@localhost.localdomain>
 <de6f8c47-b5ff-a1a6-da61-9776bb0cc6a3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <de6f8c47-b5ff-a1a6-da61-9776bb0cc6a3@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 17, 2017 at 11:00:50AM +0200, Rüdiger Meier wrote:
> On 04/17/2017 10:30 AM, Mamatha Inamdar wrote:
> > Problem: On power syatems "lscpu frequency-info" command was always
> > reading CPU0 max and min frequencies. If CPU0 is guarded or offline
> > then it used to display max and min frequencies as NULL.
> > 
> > Solution: This patch will check for the available/online CPUs
> > and read the max/min frequencies of that CPU
> 
> Maybe we could do it even more generically, not letting the first lookup win
> but really using the minimum/maximum over *all* CPUs. Who knows, maybe
> different cores could have different min/max.

Good point.

We already have this information for all CPUs in the desc->maxmhz[]
and desc->minmhz[].  So all we need is function that will return
max/min from the arrays.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

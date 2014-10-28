Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39391 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaJ1OyY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Oct 2014 10:54:24 -0400
Received: by mail-pa0-f43.google.com with SMTP id eu11so905342pac.2
        for <util-linux@vger.kernel.org>; Tue, 28 Oct 2014 07:54:24 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.82.149])
        by mx.google.com with ESMTPSA id oq3sm1883320pbb.67.2014.10.28.07.54.22
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 07:54:23 -0700 (PDT)
Message-ID: <544FAE07.6080605@gmail.com>
Date: Tue, 28 Oct 2014 20:23:59 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <20141028075308.GI10134@x2.net.home> <yq138a8pdxh.fsf@sermon.lab.mkp.net>
In-Reply-To: <yq138a8pdxh.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/28/14 18:08, Martin K. Petersen wrote:
>>>>>> "Karel" == Karel Zak <kzak@redhat.com> writes:
> Karel> This is standard behavior for all modern partitioning tools.
>
> Karel> the goal is to start the first partition on offset which is the
> Karel> most portable and the most useful on all possible disk
> Karel> configurations.
>
> Not only that. It was an explicit request from IDEMA. The disk drive and
> RAID vendors asked all operating system vendors to ensure 1MB alignment
> by default.
>

Ok, it's an IDEMA recommendation. That's why.
